{{TABLE NAME}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table

CREATE TABLE peeps (
    id SERIAL PRIMARY KEY,
    subject text,
    content text,
    time TIME,
    user_id INT,
    constraint fk_user foreign key(user_id) references
    users(id)
  )

  CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name text,
  )

2. Create Test SQL seeds

TRUNCATE TABLE users RESTART IDENTITY; -- replace with your own table name.

INSERT INTO users (name) VALUES ('Tauqeer');
INSERT INTO users (name) VALUES ('Adam');

TRUNCATE TABLE peeps RESTART IDENTITY; -- replace with your own table name.

INSERT INTO peeps (subject, content, time, user_id) VALUES ('Exercise', 'Do more', '04:05 AM', '1');
INSERT INTO peeps (subject, content, time, user_id) VALUES ('Eating Junk', 'Do less', '08:05 AM', '2');


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql

3. Define the class names

class User 
end

class UserRepository
end

class Peep
end

class PeepRepository
end

4. Implement the Model class

class User
  attr_accessor :id, :name
end

class Peep
  attr_accessor :id, :subject, :content, :time, :user_id
end


5. Define the Repository Class interface

class PeepRepository
  def all
  end

  def find(id)
  end

  def create
  end

  def delete(id)
  end

end

class UserRepository
  def all
  end

  def find
  end

  def create
  end

  def delete(id)
  end
end


6. Write Test Examples

User Repository

#1 
# Testing all method 

repo = UserRepository.new

users = repo.all

users.length # =>  2

users[0].id # =>  1
users[0].name # =>  'Tauqeer'

students[1].id # =>  2
students[1].name # =>  'Adam'


# 2
# Get a single User

repo = UserRepository.new

user = repo.find(1)

user.id # =>  1
user.name # =>  'Tauqeer'

Peep Repository

# 1
# all method

repo = PeepRepository.new

peeps = repo.all

peeps.length = 2

peeps[0].subject = 'Exercise'
peeps[1].subject = 'Eating junk'

# 2
# find method

repo = PeepRepository.new

user = repo.find(1)

user.subject = 'Exercise'
user.content = 'Do more' 



7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.