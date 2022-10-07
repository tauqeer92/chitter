require_relative './peep'
class PeepRepository

    def all
        sql = 'SELECT * FROM peeps;'
        result = DatabaseConnection.exec_params(sql, [])
        peeps = []
        result.each do |record|
            peep = Peep.new
            peep.id = record['id']
            peep.subject = record['subject']
            peep.content = record['content']
            peep.time = record['time']
            peep.user_id = record['user_id']
            peeps << peep
        end

        return peeps
    end

    def find(id)
      sql = 'SELECT * FROM peeps WHERE id = $1;'
      sql_params = [id]
      result = DatabaseConnection.exec_params(sql, sql_params)
      record = result[0]
      peep = Peep.new
      peep.id = record['id']
      peep.subject = record['subject']
      peep.content = record['content']
      peep.time = record['time']
      peep.user_id = record['user_id']
      return peep
    end

    def create(peep)
      sql = 'INSERT INTO peeps (subject, content, time, user_id) VALUES ($1, $2, $3, $4);'
      sql_params = [peep.subject, peep.content, peep.time, peep.user_id]
      DatabaseConnection.exec_params(sql, sql_params)
    end

    def delete(id)
      sql = 'DELETE FROM peeps WHERE id = $1;'
      sql_params = [id]
      DatabaseConnection.exec_params(sql, sql_params)
    end
end