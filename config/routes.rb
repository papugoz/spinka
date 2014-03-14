Spinka::Application.routes.draw do

  root      'static_pages#home'

  resources :users, path: '/uzytkownicy', path_names: { edit: 'edycja' }
  get       '/rejestracja'            => 'users#new'

  resources :sessions, only: [:new, :create, :destroy]
  get       '/logowanie'              => 'sessions#new'
  delete    '/wyloguj'                => 'sessions#destroy'

  resources :news, path: '/newsy', path_names: { new: 'nowy', edit: 'edycja' }

  resources :comments, path:'/komentarze', only: [:create, :edit, :update, :destroy], path_names: { edit: 'edycja-komentarza' }

  # resources :categories do
  #   path: '/forum' 
  #   path_names: { new: 'nowa-kategoria', edit: 'edycja-kategorii' }
  #   resources :topics, path_names: { new: 'nowy-temat', edit: 'edycja-tematu' } do
  #     resources :posts, path_names: { edit: 'edycja-odpowiedzi' }
  #   end
  # end

  shallow do
    scope shallow_path: 'forum' do
      resources :categories, path: 'kategorie' do
        resources :topics, path: 'tematy' do
          resources :posts, path: 'odpowiedzi'
        end
      end
    end
  end

  get       '/onas'                   => 'static_pages#onas'
  get       '/pomoc'                  => 'static_pages#pomoc'
  get       '/kontakt'                => 'static_pages#kontakt'
  get       '/forum'                  => 'static_pages#forum'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
