module ErrorHandlers
    extend ActiveSupport::Concern
  
    included do
      # エラー(ステータスコード500)の発生時に特定の処理を行う
      rescue_from StandardError, with: :rescue500
      # 閲覧する権限がないなどのエラー(ステータスコード403)の発生時に特定の処理を行う
      rescue_from ApplicationController::Forbidden, with: :rescue403
      # IPアドレス制限によるアクセス拒否などのエラー(ステータスコード403)の発生時に特定の処理を行う
      rescue_from ApplicationController::IpAddressRejected, with: :rescue403
      rescue_from ActiveRecord::RecordNotFound, with: :rescue404
      rescue_from ActionController::ParameterMissing, with: :rescue400
      rescue_from ApplicationController::LoginRequired, with: :rescue_login_required
    end
  
    private def rescue400(e)
      render "errors/bad_request", status: 400
    end
    
    # ステータスコード403のエラーページを表示するための処理を行う
    private def rescue403(e)
      # rescue403メソッドで受け取ったエラーオブジェクト(e)をインスタンス変数@exceptionに代入しています。
      @exception = e
      render "errors/forbidden", status: 403
    end
  
    private def rescue404(e)
      render "errors/not_found", status: 404
    end

    # ステータスコード500のエラーページを表示するための処理を行う
    private def rescue500(e)
      render "errors/internal_server_error", status: 500
    end

    private def rescue_login_required(e)
      render "errors/login_required", status: 403
    end
end