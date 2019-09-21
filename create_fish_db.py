import random


def generate_random_numbers():
    price = round(random.uniform(5,5000), 2)
    weight = round(random.uniform(1, 10000), 2)
    length = round(random.uniform(5, 200), 2)
    return price, weight, length


def generate_random_sea():
    seas = ['Oceano Pacifico', 'Oceano Atlantico', 'Oceano Indiano', 'Mar Adriatico', 'Mar Mediterraneo', 'Mar Tirreno']
    return random.choice(seas)


# todo create better descriptions
def generate_description(name, price, weight, length, sea):
    if length >= 100:
        leng = 'long'
    else:
        leng = 'short'

    if weight >= 5000:
        weig = 'heavy-weight champion'
    else:
        weig = 'thin and light'

    cook = ['pasta', 'soups', 'lasagna', 'salads', 'sandwich', 'all kinds of stuff', 'rice', 'hamburgers', 'spaghetti', 'tartare']
    return f"The {name} is a very good fish! It is {leng} and can be very {weig}!! It costs only {price} € and is very good for cooking {random.choice(cook)}! It was caught in {sea}."


def generate_url(img_name):
    return f"/static/images/phishes/{img_name}"


def generate_db_entries():
    fishes = [('Squalo', 'shark.png'),
              ('Squalo Bianco', 'shark_white.png'),
              ('Grande Squalo Bianco', 'shark_great_white.png'),
              ('Delfino', 'dolphin.png'),
              ('Orca Assassina', 'orca.png'),
              ('Pesci Gialli', 'gialli.png'),
              ('Pesce Pagliaccio', 'nemo.png'),
              ('Pesce Chirurgo', 'dory.png'),
              ('Pesce Palla', 'palla.png'),
              ('Pesce Koi', 'koi.png'),
              ('Manta', 'manta.png'),
              ('Tonno Bianco', 'tonno_bianco.png'),
              ('Balena Azzurra', 'balena_azzurra.svg'),
              ('Balena', 'balena.svg'),
              ('Pesce Oro', 'goldfish.svg'),
              ('Cavalluccio Marino', 'horse.svg'),
              ('Tonno', 'tuna.svg'),
              ('Salmone', 'salmone.png'),
              ('Branzino', 'branzino.png'),
              ('Spigola', 'spigola.png'),
              ('Carpa', 'carpa.png'),
              ('Pesce Balestra', 'balestra.png'),
              ('Pesce Damigella', 'damigella.png'),
              ('Trota', 'trota.png')]   # list of tuples (fish_name, imag_name)

    for fish in fishes:
        name = "'" + fish[0] + "'"
        price, weight, length = generate_random_numbers()
        sea = generate_random_sea()
        sea_string = "'" + sea + "'"
        description = "'" + generate_description(fish[0], price, weight, length, sea) + "'"
        image_url = "'" + generate_url(fish[1]) + "'"
        db_entry = f"INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ({name}, {price}, {weight}, {length}, {sea_string}, {description}, {image_url});"
        print(db_entry)


if __name__ == '__main__':
    generate_db_entries()

