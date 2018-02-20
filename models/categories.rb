require_relative( '../db/sql_runner' )

class Category

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end


  def save()
    sql = "INSERT INTO categories
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def total_by_category()
    sql = "SELECT SUM(amount) FROM transactions WHERE category_id = $1"
    values = [@id]
    results = SqlRunner.run(sql,values)
    final_result = results[0]['sum']
    return final_result
  end

  def self.all()
    sql = "SELECT * FROM categories"
    results = SqlRunner.run(sql)
    return results.map { |category| Category.new(category) }
  end

  def self.find(id)
    sql = "SELECT * FROM categories
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Category.new(results.first)
  end

  def self.delete_all
    sql = "DELETE FROM categories"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM categories WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def delete()
  sql = "DELETE FROM categories
  WHERE id = $1"
  values = [@id]
  SqlRunner.run( sql, values )
end

end
