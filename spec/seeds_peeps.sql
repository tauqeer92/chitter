TRUNCATE TABLE peeps RESTART IDENTITY; -- replace with your own table name.

INSERT INTO peeps (subject, content, time, user_id) VALUES ('Exercise', 'Do more', '04:05 AM', '1');
INSERT INTO peeps (subject, content, time, user_id) VALUES ('Eating Junk', 'Do less', '08:05 AM', '2');