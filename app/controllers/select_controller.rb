class SelectController < ApplicationController
  def top
    # TeamMasterインスタンスの取得
    @teams = TeamMaster.all
    # 新規ユーザーのインスタンスを定義
    @user = User.new
  end

  def create
    # 新規ユーザーのインスタンスの作成
    @user = User.new(user_params)
    if @user.save
      # インスタンス変数にユーザーを保存できたら、/logs/topに遷移
      render '/logs/top'
    else
      # 失敗したら、戻る
      render 'new'
    end
  end

  def user_params
    # ユーザーインスタンスの生成に必須であるパラメータを定義
    params.require(:user).permit(:login_id, :name, :mail_adress, :password, :favorite1)
  end

end
