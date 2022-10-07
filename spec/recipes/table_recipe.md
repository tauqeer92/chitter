
1. Extract nouns from the user stories or specification

STRAIGHT UP

As a Maker
So that I can let people know what I am doing  
I want to post a message (peep) to chitter

As a maker
So that I can see what others are saying  
I want to see all peeps in reverse chronological order

As a Maker
So that I can better appreciate the context of a peep
I want to see the time at which it was made

As a Maker
So that I can post messages on Chitter as me
I want to sign up for Chitter

HARDER

As a Maker
So that only I can post messages on Chitter as me
I want to log in to Chitter

As a Maker
So that I can avoid others posting messages on Chitter as me
I want to log out of Chitter

ADVANCED

As a Maker
So that I can stay constantly tapped in to the shouty box of Chitter
I want to receive an email if I am tagged in a Peep

STRAIGHT UP

post message to chitter, messages in reverse chronological order, time of message, sign up for chitter

HARDER

log in to chiitter, log out of chitter

ADVANCED

receive email if tagged in message



2. Infer the Table Name and Columns

user: name

peeps: content, time,  


3. Decide the column types.

Table: user
id SERIAL
name text

Table: peeps
id SERIAL
subject text
content text
time time


4. Decide on The Tables Relationship

Can one peep have many users? NO
Can one user have many peeps? YES

Student -> many to one -> Cohort

The foreign key is on Peeps (cohort_id)


5. Write the SQL.

CREATE TABLE user (
  id SERIAL PRIMARY KEY
  name text,
);

CREATE TABLE peeps (
  id SERIAL PRIMARY KEY
  subject text,
  content text,
  time time,
  constraint fk_cohort foreign key(user_id) references
  users(id)
);



6. Create the tables.

psql -h 127.0.0.1 database_name < albums_table.sql