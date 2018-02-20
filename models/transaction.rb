require_relative( '../db/sql_runner' )

class Transaction

  attr_reader :id
  attr_accessor :name, :category_id, :calendar, :amount

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @category_id = options['category_id'].to_i
    @calendar = options['calendar']
    @amount = options['amount'].to_f
  end

  def save()
    sql = "INSERT INTO transactions
    (
      name,
      category_id,
      calendar,
      amount
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@name, @category_id, @calendar,@amount]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE transactions
    SET
    (
      name,
      category_id,
      calendar,
      amount
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5"
      values = [@name, @category_id, @calendar,@amount, @id]
      SqlRunner.run( sql, values )
    end

    def category()
      sql = "SELECT * FROM categories WHERE id = $1"
      values = [@category_id]
      row = SqlRunner.run(sql, values).first
      return Category.new(row)
    end

    def self.total_by_category()
      sql = "SELECT SUM(amount) FROM transactions WHERE category_id = $1"
      values = [@category_id]
      results = SqlRunner.run(sql,values)
      final_result = results[0]['sum']
      return final_result
    end

    def self.total()
      sql = "SELECT SUM(amount) FROM transactions"
      results = SqlRunner.run(sql)
      final_result = results[0]['sum']
      return final_result
    end

    def self.all()
      sql = "SELECT * FROM transactions"
      results = SqlRunner.run(sql)
      return results.map { |transaction| Transaction.new(transaction) }
    end

    def self.find(id)
      sql = "SELECT * FROM transactions
      WHERE id = $1"
      values = [id]
      results = SqlRunner.run(sql, values)
      return Transaction.new(results.first)
    end

    def self.delete_all
      sql = "DELETE FROM transactions"
      SqlRunner.run(sql)
    end

    def self.delete(id)
      sql = "DELETE FROM transactions WHERE id = $1"
      values = [id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM transactions
      WHERE id = $1"
      values = [@id]
      SqlRunner.run( sql, values )
    end

  end
