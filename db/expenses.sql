DROP TABLE IF EXISTS trans_users;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  budget INT
);

CREATE TABLE categories
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE transactions
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  category_id INT REFERENCES categories(id) ON DELETE CASCADE,
  calendar DATE,
  amount FLOAT
);

CREATE TABLE trans_users
(
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE CASCADE,
  transaction_id INT REFERENCES transactions(id) ON DELETE CASCADE
);
