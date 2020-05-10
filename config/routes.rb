Rails.application.routes.draw do
  devise_for :users

  root to: 'select#index'
  get 'select' => 'select#index'

  get 'select/top'

  get 'test/test'

  get 'test_dir/test'

  get 'logs/top/:user_id' => "logs#top"

  post "select/new" => "select#create"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end