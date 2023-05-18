class ApplicationController < ActionController::Base
  layout :set_layout

  # アクセス権限がない時などのエラー処理クラスの定義
  class Forbidden < ActionController::ActionControllerError; end

  #特定のIPアドレスからのリクエストをアプリケーションで拒否する必要がある場合などのエラー処理クラスの定義
  class IpAddressRejected < ActionController::ActionControllerError; end

  # アクセスが制限されたリソースにアクセスしようとした場合や、ログインしていないユーザーが特定の機能を利用しようとした場合などのエラー処理クラスの定義
  class LoginRequired < StandardError; end

  # include ErrorHandlers if Rails.env.production?

  private def set_layout
    if params[:controller].match(%r{\A(external_coach|club_advisor)/})
      Regexp.last_match[1]
    else
      "club_advisor"
    end
  end

  # エラー(ステータスコード500)の発生時に特定の処理を行う
  rescue_from StandardError, with: :rescue500

  # 閲覧する権限がないなどのエラー(ステータスコード403)の発生時に特定の処理を行う
  rescue_from Forbidden, with: :rescue403

  # IPアドレス制限によるアクセス拒否などのエラー(ステータスコード403)の発生時に特定の処理を行う
  rescue_from IpAddressRejected, with: :rescue403

  rescue_from LoginRequired, with: :rescue_login_required
  
  # ステータスコード500のエラーページを表示するための処理を行う
  private def rescue500(e)
    render "errors/internal_server_error", status: 500
  end

  # ステータスコード403のエラーページを表示するための処理を行う
  private def rescue403(e)
    # rescue403メソッドで受け取ったエラーオブジェクト(e)をインスタンス変数@exceptionに代入しています。
    @exception = e
    render "errors/forbidden", status: 403
  end

  private def rescue_login_required(e)
    render "errors/login_required", status: 403
  end
end