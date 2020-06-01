Rails.application.routes.draw do
  devise_for :users

  root :to => "select#index"

  get 'select/top'

  get 'test/test'

  get 'test_dir/test'

  # TODO user_idをcookieか何かから取得したい
  get 'logs/top/:user_id' => "logs#top", as: 'logs_top'

  get 'logs/detail/:game_id' => "logs#detail"

  get 'select/new' => "select#index"
  
  post 'select/new' => "select#create"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end