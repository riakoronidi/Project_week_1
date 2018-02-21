require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('./controllers/expenses_controller.rb')
require_relative('./controllers/categories_controller.rb')

# index
get '/budgetup' do
 erb(:index)
end

# about
get '/budgetup/about' do
 erb(:about)
end
