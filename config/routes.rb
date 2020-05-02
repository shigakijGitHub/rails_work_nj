Rails.application.routes.draw do
  get 'select/top'

  get 'test/test'

  get 'test_dir/test'

  get 'logs/top/:user_id' => "logs#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end