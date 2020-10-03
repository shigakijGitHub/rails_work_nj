class LogsController < ApplicationController

  # ****************************************************
  # top画面表示
  # ****************************************************
  def top
    # ユーザ情報取得
    @userInfo = getUserInfo(params[:user_id])

    # お気に入りを配列に詰める
    favoList = [@userInfo.favorite1, @userInfo.favorite2, @userInfo.favorite3]

    # お気に入りがnilの場合、配列から削除
    favoList.delete_if {|n| n == nil }

    # チームマスタからお気に入り画像を取得
    @logoList = Array.new
    favoList.each do |favo| 
        @logoList << AllTeam.find_by(id:favo).team_logo_url
    end

    # お気に入りチームの試合取得
    @allGames = selectAllGames(favoList)

    # 観戦履歴取得
    @userLogs = UsersLog.where(user_id:params[:user_id])

    @visitedList = Array.new
    @userLogs.each do |userLog|
        @visitedList << userLog.all_game_id
    end

    # 試合日程用の曜日リスト取得
    @weeks = getWeeks()
  end

  # ****************************************************
  # detail画面表示
  # ****************************************************
  def detail
    # TODO game_idの改竄チェック
    # ユーザ情報取得
    @userInfo = getUserInfo(params[:user_id])

    # 試合情報取得
    @gameDetail = selectGameDetail(params[:game_id])

    # 試合日程用の曜日リスト取得
    @weeks = getWeeks()

    # 観戦履歴取得
    @log = UsersLog.where(user_id:params[:user_id])

  end

  # ****************************************************
  # 保存処理
  # ****************************************************
  def create
    @gameDetail
  end

  # ****************************************************
  # 各メソッド
  # ****************************************************

  # ユーザ情報返却
  def getUserInfo(userId)
    User.find(userId)
  end

  # 試合日程用の曜日リスト返却
  def getWeeks
    ["月","火","水","木","金","土","日"]
  end

  # お気に入りチームの試合返却
  def selectAllGames(favoList)
    query = ActiveRecord::Base.send(
        :sanitize_sql_array,
        ['SELECT 
            gd.score_home    AS score_home,
            gd.score_away    AS score_away,
            ag.team_id_home  AS team_id_home,
            ag.team_id_away  AS team_id_away,
            ag.stadium_name  AS stadium_name,
            ag.game_date     AS game_date,
            gd.all_game_id   AS all_game_id,
            (SELECT team_name
             FROM all_teams 
             WHERE id = ag.team_id_home) AS team_name_home,
            (SELECT team_name
             FROM all_teams 
             WHERE id = ag.team_id_away) AS team_name_away,
            (SELECT team_logo_url
             FROM all_teams
             WHERE id = ag.team_id_home) AS team_logo_url_home,
            (SELECT team_logo_url
             FROM all_teams 
             WHERE id = ag.team_id_away) AS team_logo_url_away
        FROM all_games ag
            INNER JOIN game_details gd ON ag.id = gd.all_game_id
            INNER JOIN all_teams at ON at.id = ag.team_id_home
         WHERE 
            ag.team_id_away IN (:favos)
            OR ag.team_id_home IN (:favos)
         ORDER BY ag.game_date ASC',
         favos: favoList
        ]
        )
    allGames = ActiveRecord::Base.connection.select_all(query)
  end

  # 選択された試合情報返却
  def selectGameDetail(gameId)
    query = ActiveRecord::Base.send(
        :sanitize_sql_array,
        ['SELECT 
            gd.score_home    AS score_home,
            gd.score_away    AS score_away,
            ag.team_id_home  AS team_id_home,
            ag.team_id_away  AS team_id_away,
            ag.stadium_name  AS stadium_name,
            ag.game_date     AS game_date,
            gd.all_game_id   AS all_game_id,
            (SELECT team_name
             FROM all_teams 
             WHERE id = ag.team_id_home) AS team_name_home,
            (SELECT team_name
             FROM all_teams 
             WHERE id = ag.team_id_away) AS team_name_away,
            (SELECT team_logo_url
             FROM all_teams
             WHERE id = ag.team_id_home) AS team_logo_url_home,
            (SELECT team_logo_url
             FROM all_teams 
             WHERE id = ag.team_id_away) AS team_logo_url_away
        FROM all_games ag
            INNER JOIN game_details gd ON ag.id = gd.all_game_id
            INNER JOIN all_teams at ON at.id = ag.team_id_home
         WHERE 
            ag.id = 1',
         gameId: 1
        ]
        )
    gameDetail = ActiveRecord::Base.connection.select_all(query)
  end

end