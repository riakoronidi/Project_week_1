require_relative( '../db/sql_runner' )

class Trans_User

  attr_reader :id, :user_id, :transaction_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @user_id = options['user_id'].to_i
    @transaction_id = options['transaction_id'].to_i
  end

  def save()
    sql = "INSERT INTO trans_users
    (
      user_id,
      transaction_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@user_id, @transaction_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end


  def self.all()
    sql = "SELECT * FROM trans_users"
    results = SqlRunner.run(sql)
    return results.map { |output| Trans_User.new(output) }
  end

  def self.find(id)
    sql = "SELECT * FROM trans_users
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Trans_User.new(results.first)
  end

  def self.delete_all()
    sql = "DELETE FROM trans_users"
    SqlRunner.run(sql)
  end

end
