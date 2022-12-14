require_relative 'user'

class UserRepository
    def all
        sql = 'SELECT * FROM users;'
        result = DatabaseConnection.exec_params(sql, [])
        users = []
        result.each do |record|
            user = User.new
            user.id = record['id']
            user.name = record['name']
            user.email = record['email']
            user.password = record['password']
            users << user
        end
        return users
    end

    def find(id)
      sql = 'SELECT * FROM users WHERE id = $1;'
      sql_params = [id]
      result = DatabaseConnection.exec_params(sql, sql_params)
      first = result[0]
      user = User.new
      user.id = first['id']
      user.name = first['name']
      user.email = first['email']
      user.password = record['password']
      return user
    end

    def create(user)
      sql = 'INSERT INTO users (name, email, password) VALUES ($1, $2, $3);'
      sql_params = [user.name, user.email, user.password]
      DatabaseConnection.exec_params(sql, sql_params)
    end

    def delete(id)
      sql = 'DELETE FROM users WHERE id = $1;'
      sql_params = [id]
      DatabaseConnection.exec_params(sql, sql_params)
    end
end