class LogsController < ApplicationController
  def top
    # ユーザ情報取得
    @userInfo = User.find(params[:user_id])
    
    # お気に入りを配列に詰める
    favoArry = [@userInfo.favorite1, @userInfo.favorite2, @userInfo.favorite3]
    
    # お気に入りがnullの場合、配列から削除
    favoArry.delete_if {|n| n == nil }

    # チームマスタからお気に入り画像を取得
    @logoArry = Array.new
    favoArry.each do |favo| 
        @logoArry << TeamMaster.find_by(team_id:favo).team_logo_url
    end

    # お気に入りチームの全試合取得
    query = ActiveRecord::Base.send(
        :sanitize_sql_array,
        ['SELECT 
            gd.score_home    AS scoreHome,
            gd.score_away    AS scoreAway,
            agm.team_id_home AS teamIdHome,
            agm.team_id_away AS TeamIdAway,
            agm.stadiam_name AS stadiamName,
            agm.game_date    AS gameDate,
            (SELECT team_name
             FROM team_master 
             WHERE team_id = agm.team_id_home) AS teamNameHome,
            (SELECT team_name
             FROM team_master 
             WHERE team_id = agm.team_id_away) AS teamNameAway
        FROM all_game_master agm
            INNER JOIN game_details gd ON agm.game_id = gd.game_id
            INNER JOIN team_master tm ON tm.team_id = agm.team_id_home
         WHERE 
            agm.team_id_away IN (:favos)
            AND agm.team_id_home IN (:favos)
         ORDER BY agm.game_date DESC 
        ',favos: favoArry]
        )
    @allGames = ActiveRecord::Base.connection.select_all(query)

    # 全チーム取得

    # 観戦履歴取得
    @userLogs = UsersLog.where(user_id:params[:user_id])
    # 試合日程用の曜日リスト
    @weeks = ["月","火","水","木","金","土","日"]

  end
end
