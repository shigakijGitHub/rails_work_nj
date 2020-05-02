class LogsController < ApplicationController
  def top
    # ユーザ情報取得
    @userInfo = User.find(params[:user_id])

    # お気に入りを配列に詰める
    favoArry = [@userInfo.favorite1, @userInfo.favorite2, @userInfo.favorite3]

    # お気に入りがnilの場合、配列から削除
    favoArry.delete_if {|n| n == nil }

    # チームマスタからお気に入り画像を取得
    @logoArry = Array.new
    favoArry.each do |favo| 
        @logoArry << TeamMaster.find_by(team_id:favo).team_logo_url
    end

    # お気に入りチームの試合取得
    @allGames = selectAllGames(favoArry)

    # 観戦履歴取得
    @userLogs = UsersLog.where(user_id:params[:user_id])

    # 試合日程用の曜日リスト取得
    @weeks = getWeeks()
  end

  # 試合日程用の曜日リスト返却
  def getWeeks
    ["月","火","水","木","金","土","日"]
  end

  # お気に入りチームの試合返却
  def selectAllGames(favoArry)
    query = ActiveRecord::Base.send(
        :sanitize_sql_array,
        ['SELECT 
            gd.score_home    AS score_home,
            gd.score_away    AS score_away,
            agm.team_id_home AS team_id_home,
            agm.team_id_away AS team_id_away,
            agm.stadiam_name AS stadiam_name,
            agm.game_date    AS game_date,
            gd.game_id       AS game_id,
            (SELECT team_name
             FROM team_master 
             WHERE team_id = agm.team_id_home) AS team_name_home,
            (SELECT team_name
             FROM team_master 
             WHERE team_id = agm.team_id_away) AS team_name_away,
            (SELECT team_logo_url
             FROM team_master 
             WHERE team_id = agm.team_id_home) AS team_logo_url_home,
            (SELECT team_logo_url
             FROM team_master 
             WHERE team_id = agm.team_id_away) AS team_logo_url_away
        FROM all_game_master agm
            INNER JOIN game_details gd ON agm.game_id = gd.game_id
            INNER JOIN team_master tm ON tm.team_id = agm.team_id_home
         WHERE 
            agm.team_id_away IN (:favos)
            OR agm.team_id_home IN (:favos)
         ORDER BY agm.game_date ASC',
         favos: favoArry]
        )
    allGames = ActiveRecord::Base.connection.select_all(query)
  end

end