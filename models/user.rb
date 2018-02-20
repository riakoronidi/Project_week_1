require_relative( '../db/sql_runner' )

class User

  attr_reader :id
  attr_accessor :full_name, :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @full_name = options['full_name']
    @budget = options['budget'].to_i
  end

  def save()
    sql = "INSERT INTO users
    (
      full_name,
      budget
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@full_name, @budget]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end


  def transactions()
    sql = "SELECT transactions.* FROM transactions INNER JOIN trans_users ON trans_users.transaction_id = transactions.id WHERE trans_users.user_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql,values)
    return results.map {|transaction| Transaction.new(transaction)}
  end

  def self.all()
    sql = "SELECT * FROM users"
    results = SqlRunner.run(sql)
    return results.map { |user| User.new(user) }
  end

  def self.find(id)
    sql = "SELECT * FROM users
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return User.new(results.first)
  end

  def self.delete_all
    sql = "DELETE FROM users"
    SqlRunner.run(sql)
  end

end
