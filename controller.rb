require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/user.rb')
require_relative('./models/transaction.rb')
require_relative('./models/trans_users.rb')
require_relative('./models/categories.rb')

# index
get '/budgetup' do
 erb(:index)
end

# about
get '/budgetup/about' do
 erb(:about)
end


# index_expense
get '/budgetup/expenses' do
  @transactions = Transaction.all()
  @total = Transaction.total()
 erb(:index_expense)
end

# index_category
get '/budgetup/categories' do
  @categories = Category.all()
 erb(:index_category)
end

# expenses_categories
get '/budgetup/expenses/categories' do
  @categories = Category.all()
  erb(:expenses_categories)
end


# create_expense
post '/budgetup/expenses' do
  @spending = Transaction.new(params)
  @spending.save()
  erb(:create_expense)
end

# new_expense
get '/budgetup/expenses/new' do
  @categories = Category.all()
  erb(:new_expense)
end

# create_category
post '/budgetup/categories' do
  @category = Category.new(params)
  @category.save()
  erb(:create_category)
end

# new_category
get '/budgetup/categories/new' do
  @categories = Category.all()
  erb(:new_category)
end

# edit_expense
get "/budgetup/expenses/:id/edit" do
  @transaction = Transaction.find(params[:id])
  @categories = Category.all()
  erb(:edit_expense)
end

# update_expense
post "/budgetup/expenses/:id" do
  transaction = Transaction.new(params)
  transaction.update()
  redirect to '/budgetup/expenses'
end

# show_expense
get '/budgetup/expenses/:id' do
  @transaction = Transaction.find(params[:id])
  erb(:show_expense)
end

# delete_expense
post '/budgetup/expenses/:id/delete_expense' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()
  redirect to ('/budgetup/expenses')
end

# delete_category
post '/budgetup/categories/:id/delete_category' do
  @category = Category.find(params[:id])
  @category.delete()
  redirect to ('/budgetup/categories')
end
