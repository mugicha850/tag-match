Rails.application.configure do
  # 後ほどストロングパラメータを設定時削除する
  config.action_controller.permit_all_parameters = true
end