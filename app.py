from flask import Flask, render_template, url_for, request, redirect, session, flash
import mysql.connector  # serve installare: mysqlclient e mysql-connector
import gc
from functools import wraps
import secrets

#TODO le query al db sembrano essere case insensitive, forse è perchè l'imac lo è, verificare su macbook
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


@app.route("/")
def homepage():
    return render_template("home.html", page_type=request.args.get('page_type'))

#TODO
@app.route("/signin/", methods=['GET', 'POST'])
def signin_page():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        query = "SELECT * FROM USERS WHERE USERNAME ='" + username + "'"
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
        query = "SELECT * FROM USERS WHERE USERNAME ='" + username + "'"
        result = fetch_db(query)
        if len(result) == 0:
            # adding the new user
            query = "INSERT INTO USERS (USERNAME, EMAIL, PASSWORD) VALUES('{}', '{}', '{}');".format(username, email, password)
            insert_db(query)

            # cookies
            session['logged_in'] = True
            session['username'] = username

            return redirect(url_for('homepage', page_type="Home"))
            # TODO serve poter passare i parametri meglio (per ora sono nella querystring della GET)

        else:
            flash("User already exists!!!")

    # registration failed | get request
    return render_template("registration.html", page_type="Sign Up")



#TODO da fare anche html
@app.route("/search/", methods=['GET', 'POST'])
def search_page():
    return render_template("search.html", page_type="Search")


#TODO da fare anche html
@app.route("/about/", methods=['GET'])
def about_page():
    return render_template("about.html", page_type="About")

#mettere pagina per mostrare i dettagli del prodotto
#mettere pagina carrello
#fare anche pagina wishlist


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)

