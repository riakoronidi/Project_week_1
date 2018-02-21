require_relative('../models/user.rb')
require_relative('../models/transaction.rb')
require_relative('../models/trans_users.rb')
require_relative('../models/categories.rb')


# index_expense
get '/budgetup/expenses' do
  @transactions = Transaction.all()
  @total = Transaction.total()
 erb(:"expenses/index_expense")
end

# expenses_categories
get '/budgetup/expenses/categories' do
  @categories = Category.all()
  erb(:"expenses/expenses_categories")
end

# create_expense
post '/budgetup/expenses' do
  @spending = Transaction.new(params)
  @spending.save()
  erb(:"expenses/create_expense")
end

# new_expense
get '/budgetup/expenses/new' do
  @categories = Category.all()
  erb(:"expenses/new_expense")
end

# edit_expense
get "/budgetup/expenses/:id/edit" do
  @transaction = Transaction.find(params[:id])
  @categories = Category.all()
  erb(:"expenses/edit_expense")
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
  erb(:"expenses/show_expense")
end

# delete_expense
post '/budgetup/expenses/:id/delete_expense' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()
  redirect to ('/budgetup/expenses')
end
