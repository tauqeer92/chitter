TRUNCATE TABLE users RESTART IDENTITY CASCADE; -- replace with your own table name.

INSERT INTO users (name, email, password) VALUES ('Tauqeer', 'tauqeer@aol.com', '12345');
INSERT INTO users (name, email, password) VALUES ('Adam', 'adam@aol.com', '12345');