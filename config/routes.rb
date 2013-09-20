Clear::Application.routes.draw do

    scope module: 'api' do
      scope module: 'v1' do
        #constraints subdomain: 'api' do
          match 'cards', :to => 'cards#list'
          match 'cards/create', :to => 'cards#create'
          match 'cards/update/:card_id', :to => 'cards#update'
          match 'cards/destroy/:card_id', :to => 'cards#destroy'
          match 'cards/:card_id', :to => 'cards#show'
          match 'invoices', :to => 'invoices#list'
          match 'invoices/create', :to => 'invoices#create'
          match 'invoices/update/:invoice_id', :to => 'invoices#update'
          match 'invoices/destroy/:invoice_id', :to => 'invoices#destroy'
          match 'invoices/:invoice_id', :to => 'invoices#show'
          match 'stores/invoices/:invoice_id', :to => 'stores/invoices#show'
          match 'stores/invoices/', :to => 'stores/invoices#list'
          match 'stores/:store_id', :to => 'stores#show'
          match 'subscriptions', :to => 'subscriptions#list'
          match 'subscriptions/create', :to => 'subscriptions#create'
          match 'subscriptions/update/:subscription_id', :to => 'subscriptions#update'
          match 'subscriptions/destroy/:subscription_id', :to => 'subscriptions#destroy'
          match 'subscriptions/:subscription_id', :to => 'subscriptions#show'
          match 'payments', :to => 'payments#list'
          match 'payments/create', :to => 'payments#create'
          match 'payments/update/:payment_id', :to => 'payments#update'
          match 'payments/destroy/:payment_id', :to => 'payments#destroy'
          match 'payments/:payment_id', :to => 'payments#show'
          match 'users/create', :to => 'users#create'
          match 'users/login', :to => 'users#show'
        #end
      end
    end

  # stores subdomain

    match '/', :to => 'admin/stores#list', :constraints => { :subdomain => "stores" }
    match 'stores/new', :to => 'admin/stores#new', :constraints => { :subdomain => "stores" }
    match 'stores/create', :to => 'admin/stores#create', :constraints => { :subdomain => "stores" }
    match 'stores/update/:id', :to => 'admin/stores#update', :constraints => { :subdomain => "stores" }
    match 'stores/destroy/:id', :to => 'admin/stores#destroy', :constraints => { :subdomain => "stores" }
    match 'stores/delete/:id', :to => 'admin/stores#delete', :constraints => { :subdomain => "stores" }
    match 'stores/:id', :to => 'admin/stores#show', :constraints => { :subdomain => "stores" }
    match 'invoices/', :to => 'admin/invoices#list', :constraints => { :subdomain => "stores" }
    match 'invoices/new', :to => 'admin/invoices#new', :constraints => { :subdomain => "stores" }
    match 'invoices/create', :to => 'admin/invoices#create', :constraints => { :subdomain => "stores" }
    match 'invoices/update/:id', :to => 'admin/invoices#update', :constraints => { :subdomain => "stores" }
    match 'invoices/destroy/:id', :to => 'admin/invoices#destroy', :constraints => { :subdomain => "stores" }
    match 'invoices/delete/:id', :to => 'admin/invoices#delete', :constraints => { :subdomain => "stores" }
    match 'invoices/:id', :to => 'admin/invoices#show', :constraints => { :subdomain => "stores" }

  devise_for :stores

  devise_for :users, :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" } #for password reset etc

  root :to => "home#index"
end
