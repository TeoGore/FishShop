from flask import Flask, render_template, url_for, request, redirect, session, flash
import mysql.connector  # serve installare: mysqlclient e mysql-connector
import gc
from functools import wraps
import secrets
import random

#todo togliere sfondo bianco al logo e alla altra immagine di errore 404
#todo creare root per il logout


'''
Useful queries:

fare con fetch_db():
query = "SELECT * FROM USERS WHERE USERNAME ='" + username + "' AND PASSWORD = '" + password + "'"
query = "SELECT * FROM TABLE_NAME WHERE TEXT LIKE '%" + searched_text + "%' AND USERNAME = '" + username + "'"

fare con insert_db():
query = "INSERT INTO USERS (USERNAME, EMAIL, PASSWORD) VALUES('{}', '{}', '{}');".format(username, email, password)
query = "DELETE FROM TABLE_NAME WHERE FIELD = '" + user_input + "'"
'''

app = Flask(__name__)
app.config['SECRET_KEY'] = secrets.token_urlsafe(16)


def dbconnect():
    return mysql.connector.connect(host="localhost", user='user', passwd='password',
                                   database="FISHSHOP", auth_plugin='mysql_native_password')


def fetch_db(query):
    db = dbconnect()
    cursor = db.cursor()
    cursor.execute(query)
    results = cursor.fetchall()
    cursor.close()
    db.close()
    gc.collect() #call garbage collector
    return results


def insert_db(query):
    db = dbconnect()
    cursor = db.cursor()
    cursor.execute(query)
    db.commit()
    cursor.close()
    db.close()
    gc.collect()
    return


def login_required(route_function):
    @wraps(route_function)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return route_function(*args, **kwargs)
        else:
            flash("You need to login first!")
            return redirect(url_for('signin'))

    return wrap


@app.errorhandler(404)
def page_not_found(error):
    return render_template("404.html", page_type='404')

'''
@app.errorhandler(500)
def page_not_found(error):
    return render_template("404.html", page_type='500', error=error)
'''

#todo
@app.route("/")
def homepage():
    query = "SELECT * FROM FISHES;"
    element_list = fetch_db(query)
    random.shuffle(element_list)
    # todo se l'utente è loggato cambiare le dovute icone
    return render_template("home.html", page_type=request.args.get('page_type'), element_list=element_list)

@app.route("/product/")
def product_page():
    fish_id = request.args.get('fish_id', default=1, type=int)
    query = "SELECT * FROM FISHES WHERE FISH_ID = '" + str(fish_id) + "';"
    fish = fetch_db(query)

    if len(fish) == 1:
        # (ID, NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL)
        return render_template("product.html", page_type=f'{fish[0][1]}', fish=fish[0])
    else:
        # fish not found (not exits in the DB)
        return redirect('not existing page')


def retrieve_fishes(element_list):
    # element list = lista di tuple (uid, fish_id, qta)
    # for each fish we create a tuple (fish_id, name, price, description, img_url, qta)
    # (ID, NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL)
    result = []
    for elem in element_list:
        query = f"SELECT * FROM FISHES WHERE FISH_ID = {str(elem[1])};"
        fish = fetch_db(query)
        fish = fish[0]
        t = (fish[0], fish[1], fish[2], fish[6], fish[7], elem[2])
        result.append(t)
    return result


#TODO
@app.route("/shopping_cart/")
def shopping_cart():
    #todo handle with fish id removing or updating quantity of elements

    #todo get user id
    user_id = 1


    quantity = request.args.get("quantity", type=int)
    fish_id = request.args.get("fish_id", default=1)

    if quantity is not None:
        query = f"SELECT * FROM CART WHERE USER = {str(user_id)} AND FISH = {str(fish_id)};"
        element_list = fetch_db(query)
        if len(element_list) == 0:
            # need new entry
            query = f"INSERT INTO CART VALUES ({user_id}, {fish_id}, {quantity});"
            insert_db(query)
        else:
            # entry already exists, sum quantity to the pre-existing
            old_quantity = element_list[0][2]
            new_quantity = old_quantity + quantity
            query = f"UPDATE CART SET QUANTITY = {str(new_quantity)} WHERE USER = {str(user_id)} AND FISH = {str(fish_id)};"
            insert_db(query)


    query = f"SELECT * FROM CART WHERE USER = {str(user_id)};"
    element_list = fetch_db(query)

    element_list = retrieve_fishes(element_list)   # now is (fish_id, fish_name, price, description, img_url, qta)
    return render_template("cart.html", page_type="Cart", element_list=element_list)


#TODO
@app.route("/payment/")
def payment():
    #todo put logic for payment (or if no money redirect to cart with an error)

    return redirect(url_for("homepage", page_type="Home"))

# TODO
@app.route("/signin/", methods=['GET', 'POST'])
def signin_page():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        query = "SELECT * FROM USERS WHERE USERNAME ='" + username + "';"
        result = fetch_db(query)
        if len(result) > 0:
            # user exists
            db_password = result[0][3]  # result[0] = (ID, username, email, password)

            if password == db_password:
                # provided correct password
                # cookies
                session['logged_in'] = True
                session['username'] = username

                return redirect(url_for('homepage', page_type="Home"))
                # TODO serve poter passare i parametri meglio (per ora sono nella querystring della GET)
            else:
                flash("Invalid credentials!!!")
        else:
            flash("Invalid credentials!!!")

    # get request | user not found
    return render_template("login.html", page_type="Sign In")


#TODO CREARE PAGINA DI LOGOUT - vedere come usare session (e fare il redirect properly da sentdex)


#TODO
@app.route("/profile/")
def profile_page():
    #todo get user id
    user_id = 1

    if request.args.get('invest', default="") == '€€€':
        # todo implement logic to randomly make lose money (if broke restart from 500€)
        # the user want to invest, so we generate money
        amount = round(random.uniform(500, 5000), 2)
        query = f"SELECT * FROM USERS WHERE USER_ID = {user_id};"
        user_info = fetch_db(query)
        user_info = user_info[0]
        new_credit = round(user_info[4] + amount, 2)
        #update DB
        query = f"UPDATE USERS SET CREDIT = {new_credit} WHERE USER_ID = {user_id};"
        print(f"Query generated:\t{query}")
        insert_db(query)

    query = f"SELECT * FROM USERS WHERE USER_ID = {user_id};"
    user_info = fetch_db(query)     # (ID,USERNAME, EMAIL, PASSWORD, CREDIT)

    return render_template("profile.html", page_type="Profile", user_info=user_info[0])


#TODO
@app.route("/signup/", methods=['GET', 'POST'])
def signup_page():
    # TODO verificare uguaglianza password con JS nell'html registration.html
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']

        #from mysql import escape_string as thwart # usate per mitigare le SQLi (non sono sicuro di dove fare la from!)
        # campo_sanitizzato = thwart(campo_di_un_form)

        # search user
        query = "SELECT * FROM USERS WHERE USERNAME ='" + username + "';"
        result = fetch_db(query)
        if len(result) == 0:
            # adding the new user
            query = "INSERT INTO USERS (USERNAME, EMAIL, PASSWORD, CREDIT) VALUES('{}','{}','{}','{}');".format(username, email, password, 10.00)
            insert_db(query)

            session['logged_in'] = True
            session['username'] = username

            return redirect(url_for('homepage', page_type="Home"))
            # TODO serve poter passare i parametri meglio (per ora sono nella querystring della GET)

        else:
            flash("User already exists!!!")

    # registration failed | get request
    return render_template("registration.html", page_type="Sign Up")


@app.route("/search/")
def search_page():

    has_searched = False
    shuffle = False

    search_string = request.args.get("search_text", default="")
    search_type = request.args.get("search_type", default="")  # all, fish, sea
    maxprice = request.args.get("price-maxval", default=5000.00)  # (5, 5000)
    order = request.args.get("search-order", default="")  # random, low-price, high-price, fish, sea

    if len(request.args) > 0:
        has_searched = True

    if search_type == "fish":
        search = "NAME LIKE '%" + search_string + "%'"
    elif search_type == "sea":
        search = "SEA LIKE '%" + search_string + "%'"
    else:
        search = "(NAME LIKE '%" + search_string + "%' OR SEA LIKE'%" + search_string + "%')"

    price_string = " AND PRICE <= " + str(maxprice)

    if order == "low-price":
        order_string = " ORDER BY PRICE ASC"
    elif order == "high-price":
        order_string = " ORDER BY PRICE DESC"
    elif order == "fish":
        order_string = f" ORDER BY NAME ASC"
    elif order == "sea":
        order_string = f" ORDER BY SEA ASC"
    else:
        order_string = ""
        shuffle = True

    query = f"SELECT * FROM FISHES WHERE ({search}{price_string}){order_string};"
    print(f"Query generated (shuffle:{shuffle}):\n{query}")

    element_list = fetch_db(query)
    if shuffle:
        random.shuffle(element_list)

    return render_template("search.html", page_type="Search", has_searched=has_searched, search=search_string, element_list=element_list)


@app.route("/about/")
def about_page():
    return render_template("about.html", page_type="About")


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)

