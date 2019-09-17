from passlib.hash import sha256_crypt

'''
in generale un semplice sha256 a fronte dello stesso input da lo stesso output
allora viene modificato l'user input aggiungendo delle lettere dette "salt" in modo da mitigare la creazione di hashtable in grado di: dato un hash, ritrovare l'input dell'utente

il salt va cambiato spesso altrimenti se sempre uguale una volta trovato si può costruire una hash table
noi vogliamo che per lo stesso input venga generato un hash diverso ogni volta, infatti password1 e password2 sono stringhe differenti

quindi per comparare due hash serve un algoritmo particolare
'''

user_input = "password"     # assume a password entered in our form (of our web app)

password1 = sha256_crypt.hash(user_input)
password2 = sha256_crypt.encrypt(user_input)        #deprecated method

print(password1)
print(password2)    # see they are different

print(len(password1))   # always 77

#comparation: we assume the user has inserted the password into our form, so it's hashed and compared to the hash stored into the DB
verification1 = sha256_crypt.verify(user_input, password1)
verification2 = sha256_crypt.verify(user_input, password2)

#different hash strings from the same input make True the verification
print(verification1)
print(verification2)

#reating hashed passwords for the DB script
print(sha256_crypt.hash("admin"))
print(sha256_crypt.hash("teo"))
print(sha256_crypt.hash("test"))
print(sha256_crypt.hash("user"))

# NOT USED BECAUSE THE VERIFY SEEMS NOT WORKING!!!