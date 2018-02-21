require_relative('../models/user.rb')
require_relative('../models/transaction.rb')
require_relative('../models/trans_users.rb')
require_relative('../models/categories.rb')


# index_category
get '/budgetup/categories' do
  @categories = Category.all()
  erb(:"categories/index_category")
end

# create_category
post '/budgetup/categories' do
  @category = Category.new(params)
  @category.save()
  erb(:"categories/create_category")
end

# new_category
get '/budgetup/categories/new' do
  @categories = Category.all()
  erb(:"categories/new_category")
end

# delete_category
post '/budgetup/categories/:id/delete_category' do
  @category = Category.find(params[:id])
  @category.delete()
  redirect to ('/budgetup/categories')
end
