# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

post '/auth/sign_in', to: 'auth#sign_in'
post '/auth/sign_up', to: 'auth#sign_up'

resources :records, only: [:index, :create, :update, :destroy]
