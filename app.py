from flask import Flask, render_template, url_for, request, redirect, session
import mysql.connector
import gc


#TODO le query al db sembrano essere case insensitive, forse è perchè l'imac lo è, verificare su macbook

app = Flask(__name__)

online_users = {}

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

    gc.collect() #call garbage collector

    return

@app.errorhandler(404)
def page_not_found(error):
    return render_template("404.html", page_type='404')

'''
@app.errorhandler(500)
def page_not_found(error):
    return render_template("404.html", page_type='500', error=error)
'''


@app.route("/", methods=['GET','POST'])
def homepage():
    return render_template("base.html", page_type="Home")

#TODO
@app.route("/signin/", methods=['GET', 'POST'])
def signin_page():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        query = "SELECT * FROM USERS WHERE USERNAME ='" + username + "' AND PASSWORD = '" + password + "'"
        result = fetch_db(query)
        if len(result) > 0:
            user_info = result[0]  # (ID, username, email, password)


            '''
            session['logged_in'] = True
            session['username'] = user_info[1]

            return redirect(url_for('homepage'))
            '''



            #TODO decidere cosa aggiungere al dizionario (online_users) per controllare gli utenti collegati alla sessione
            return render_template("home.html", page_type="Home", user_id=user_info[0], username=user_info[1])
        #TODO il template renderizzato è corretto ma la root nell'URL no (vedere come cambairla, serve farlo mantenendo il passaggio dei parametri quindi redirect non va bene)

    #get request or user not found
    return render_template("login.html", page_type="Sign In")

#TODO CREARE PAGINA DI LOGOUT


#TODO
@app.route("/signup/", methods=['GET','POST'])
def signup_page():
    # TODO verificare uguaglianza password con JS nell'html registration.html
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']

        #pip install passlib
        #from passlib.hash import sha256_crypt

        #password = sha256_crypt.encrypt(str(password))

        #from mysql import escape_string as thwart # usate per mitigare le SQLi (non sono sicuro di dove fare la from!)

        # campo_sanitizzato = thwart(campo_di_un_form)

        # add user
        query = "INSERT INTO USERS (USERNAME, EMAIL, PASSWORD) VALUES('{}', '{}', '{}');".format(username, email, password)
        insert_db(query)
        # TODO il template renderizzato è corretto ma la root nell'URL no (vedere come cambairla, serve farlo mantenendo il passaggio dei parametri quindi redirect non va bene)
        # dovrebbe andare a signin ma rimane a sign up (non posso usare redirect perchè devo passare il parametro page type)
        return render_template("login.html", page_type="Sign In")
    return render_template("registration.html", page_type="Sign Up")


@app.route("/search/", methods=['GET','POST'])
def search_page():
    return render_template("search.html", page_type="Search")


@app.route("/about/", methods=['GET'])
def about_page():
    return render_template("about.html", page_type="About")

#mettere pagina per mostrare i dettagli del prodotto
#mettere pagina carrello
#se voglio fare anche pagina wishlist


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)

