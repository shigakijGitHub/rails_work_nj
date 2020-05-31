class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  
  def after_sign_in_path_for(resource)
    logs_top_path(login) # ログイン後に遷移するpathを設定
    
  end

  
  def after_sign_up_path_for(resource)
    logs_top_path(login) #アカウント登録後のリダイレクト先
  end

  def login
    @current_user = current_user.id
  end
end
