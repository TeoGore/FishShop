from flask import Flask, render_template, url_for

app = Flask(__name__)


@app.route("/", methods=['GET','POST'])
def homepage():
    return render_template("base.html", page_type="Home")


@app.route("/login/", methods=['GET','POST'])
def login_page():
    return render_template("login.html", page_type="Sign In")


@app.route("/registration/", methods=['GET','POST'])
def registration_page():
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
    app.run(port=5000, debug=True)

