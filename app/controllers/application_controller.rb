class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken
  layout :set_layout
  skip_before_action :verify_authenticity_token

  # アクセス権限がない時などのエラー処理クラスの定義
  class Forbidden < ActionController::ActionControllerError; end

  #特定のIPアドレスからのリクエストをアプリケーションで拒否する必要がある場合などのエラー処理クラスの定義
  class IpAddressRejected < ActionController::ActionControllerError; end

  # アクセスが制限されたリソースにアクセスしようとした場合や、ログインしていないユーザーが特定の機能を利用しようとした場合などのエラー処理クラスの定義
  class LoginRequired < StandardError; end

  include ErrorHandlers if Rails.env.production?

  private def set_layout
    if params[:controller].match(%r{\A(external_coach|club_advisor|errors)/})
      Regexp.last_match[1]
    else
      "club_advisor"
    end
  end
end