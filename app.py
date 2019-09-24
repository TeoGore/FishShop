from flask import Flask, render_template, url_for, request, redirect, session, flash
import mysql.connector  # serve installare: mysqlclient e mysql-connector
import gc
from functools import wraps
import secrets
import random

#todo togliere sfondo bianco al logo e alla altra immagine di errore 404
#todo mettere tweak su: logo e immagine utente nel template base, su immagine utente nella pagina profilo e sul logo nella pagin about
#todo JS for profile, cart (per ora su profile non metto nulla)
#todo rifare css del cart (sia quando è vuoto, sia pieno)
#todo fare funzionare js per calcolare totale in carrello
#todo mettere animazione al bottone nella pagina profilo per fare soldi

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
            return redirect(url_for('signin', page_type='signin_page'))

    return wrap


def check_login(s):
    if 'logged_in' in s and s['logged_in']:
        return True, s['user_id'], s['username']
    return False, 0, ""


@app.errorhandler(404)
def page_not_found(error):
    login = check_login(session)
    return render_template("404.html", page_type='404', login=login)


@app.errorhandler(500)
def page_not_found(error):
    login = check_login(session)
    return render_template("404.html", page_type='500', error=error, login=login)


@app.route("/")
def homepage():
    login = check_login(session)
    query = "SELECT * FROM FISHES;"
    element_list = fetch_db(query)
    random.shuffle(element_list)
    return render_template("home.html", page_type=request.args.get('page_type'), login=login, element_list=element_list)


@app.route("/signup/", methods=['GET', 'POST'])
def signup_page():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']

        # search user
        query = "SELECT * FROM USERS WHERE USERNAME ='" + username + "';"
        result = fetch_db(query)
        if len(result) == 0:
            # adding the new user
            query = "INSERT INTO USERS (USERNAME, EMAIL, PASSWORD, CREDIT) VALUES('{}','{}','{}','{}');".format(username, email, password, 10.00)
            insert_db(query)

            query = "SELECT * FROM USERS WHERE USERNAME ='" + username + "';"
            result = fetch_db(query)
            user_id = result[0][0]

            session['logged_in'] = True
            session['username'] = username
            session['user_id'] = user_id

            login = check_login(session)

            return redirect(url_for('homepage', page_type="Home", login=login))

        else:
            return render_template("registration.html", login=(False, 0, ""), page_type="Sign Up", existing_user=1)

    # registration failed | get request
    return render_template("registration.html", login=(False, 0, ""), page_type="Sign Up", existing_user=None)


@app.route("/signin/", methods=['GET', 'POST'])
def signin_page():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        query = "SELECT * FROM USERS WHERE USERNAME ='" + username + "';"
        result = fetch_db(query)
        if len(result) > 0:
            # user exists
            db_password = result[0][3]  # result[0] = (ID, username, email, password, credit)

            if password == db_password:
                # provided correct password
                # cookies
                session['logged_in'] = True
                session['username'] = username
                session['user_id'] = result[0][0]

                login = check_login(session)

                return redirect(url_for('homepage', page_type="Home", login=login))

    # get request | user not found
    return render_template("login.html", page_type="Sign In", login=(False, 0, ""))


@app.route('/signout/')
def signout_page():
    session.clear()
    return redirect(url_for('homepage', page_type="Home", login=(False, 0, "")))


@app.route("/profile/")
def profile_page():
    login = check_login(session)
    user_id = login[1]

    if request.args.get('invest', default="") == '€€€':
        # the user want to invest, so we generate money
        amount = round(random.uniform(500, 5000), 2)
        query = f"SELECT * FROM USERS WHERE USER_ID = {user_id};"
        user_info = fetch_db(query)
        user_info = user_info[0]
        new_credit = round(user_info[4] + amount, 2)
        #update DB
        query = f"UPDATE USERS SET CREDIT = {new_credit} WHERE USER_ID = {user_id};"
        insert_db(query)

    query = f"SELECT * FROM USERS WHERE USER_ID = {user_id};"
    user_info = fetch_db(query)     # (ID,USERNAME, EMAIL, PASSWORD, CREDIT)

    return render_template("profile.html", page_type="Profile", login=login, user_info=user_info[0])


@app.route("/search/")
def search_page():
    login = check_login(session)

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
    element_list = fetch_db(query)
    if shuffle:
        random.shuffle(element_list)

    return render_template("search.html", page_type="Search", has_searched=has_searched, search=search_string, login=login, element_list=element_list)


@app.route("/product/")
def product_page():
    login = check_login(session)

    fish_id = request.args.get('fish_id', default=1, type=int)
    query = "SELECT * FROM FISHES WHERE FISH_ID = '" + str(fish_id) + "';"
    fish = fetch_db(query)

    if len(fish) == 1:
        # (ID, NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL)
        return render_template("product.html", page_type=f'{fish[0][1]}', fish=fish[0], login=login)
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


@app.route("/shopping_cart/")
def shopping_cart():
    login = check_login(session)

    if login[0]:
        user_id = login[1]

        quantity = request.args.get("quantity", type=int, default=0)
        fish_id = request.args.get("fish_id", default=0)

        if quantity > 0 and int(fish_id) > 0:
            query = f"SELECT * FROM CART WHERE USER = {str(user_id)} AND FISH = {str(fish_id)};"
            element_list = fetch_db(query)
            if len(element_list) == 0:
                # need new entry
                query = f"INSERT INTO CART VALUES ({str(user_id)}, {str(fish_id)}, {str(quantity)});"
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

        query = f"SELECT * FROM USERS WHERE USER_ID = {str(user_id)};"
        user_info = fetch_db(query)

        return render_template("cart.html", page_type="Cart", login=login, element_list=element_list, user_credit=user_info[0][-1])
    else:
        # user not logged, return an error
        return redirect(url_for('signin_page', page_type="Sign In", login=login))


@app.route('/delete_item/')
def delete_element():
    login = check_login(session)
    user_id = login[1]
    fish_id = request.args.get("fish_id", default=0)

    query = f"DELETE FROM CART WHERE USER = {str(user_id)} AND FISH = {str(fish_id)};"
    insert_db(query)

    query = f"SELECT * FROM CART WHERE USER = {str(user_id)};"
    element_list = fetch_db(query)
    element_list = retrieve_fishes(element_list)

    return redirect(url_for("shopping_cart", page_type="Cart", login=login, element_list=element_list))


def fetch_total_amount(user_id):
    total = 0
    query = f"SELECT * FROM CART WHERE USER = {str(user_id)};"
    products = fetch_db(query)
    for p in products:
        total += p[2]
    return total


def enough_money(credit, total):
    return credit > total


def make_payment(user_id, old_credit, total):
    new_credit = round(old_credit-total, 2)
    query = f"UPDATE USERS SET CREDIT = {str(new_credit)} WHERE USER_ID = {str(user_id)};"
    insert_db(query)


def update_user_cart(user_id):
    query = f"DELETE FROM CART WHERE USER = {str(user_id)};"
    insert_db(query)


@app.route("/payment/")
def payment():
    login = check_login(session)

    user_id = login[1]
    query = f"SELECT * FROM USERS WHERE USER_ID = {user_id};"
    user_info = fetch_db(query)

    total = fetch_total_amount(user_id)
    user_credit = user_info[0][-1]

    if enough_money(user_credit, total):
        make_payment(user_id, user_credit, total)
        update_user_cart(user_id)
        return redirect(url_for("homepage", page_type="Home", login=login))
    else:
        return redirect(url_for("profile_page", page_type="Profile", login=login, user_info=user_info[0]))


@app.route("/about/")
def about_page():
    login = check_login(session)
    return render_template("about.html", page_type="About", login=login)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)

