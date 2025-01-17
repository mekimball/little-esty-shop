Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, except: [:delete]
    resources :invoices, except: [:delete]
  end

  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index]
    resources :bulk_discounts
    resources :items, except: :delete
    resources :invoices, only: %i[index show update]
  end
end
