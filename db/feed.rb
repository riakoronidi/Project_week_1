require_relative( "../models/user.rb" )
require_relative( "../models/transaction.rb" )
require_relative( "../models/trans_users.rb" )
require_relative( "../models/categories.rb" )

require("pry-byebug")

Trans_User.delete_all()
User.delete_all()
Transaction.delete_all()

user1 = User.new({"full_name" => "Ria Koronidi", "budget" => "1000"})
user1.save()


category1 = Category.new({"name" => "Housing"})
category1.save()

category2 = Category.new({"name" => "Living Expenses"})
category2.save()

category3 = Category.new({"name" => "Utilities"})
category3.save()

transaction1 = Transaction.new({"name"=>"rent", "category_id"=> category1.id, "calendar"=>"2018-2-19", "amount"=>"650"})
transaction1.save()

transaction2 = Transaction.new({"name"=>"council tax", "category_id"=> category1.id, "calendar"=>"2018-2-19", "amount"=>"190"})
transaction2.save()


trans_users1 = Trans_User.new ({"user_id"=> user1.id, "transaction_id"=> transaction1.id})
trans_users1.save()

trans_users2 = Trans_User.new ({"user_id"=> user1.id, "transaction_id"=> transaction2.id})
trans_users2.save()

binding.pry
nil
