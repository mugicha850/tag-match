class ErrorsController < ApplicationController
  layout "errors"
  around_action :handle_errors
  def not_found
    log_path_info
    log_env
    render :not_found, status: 404
  end

  def unprocessable_entity
    render status: 422
  end

  def internal_server_error
    log_path_info
    log_env
    render :internal_server_error, status: 500
  end

  private def log_path_info
    Rails.logger.info "path_info: #{request.path_info}"
  end
  private def log_env
    logger.error "404 Error - Environment Variables: #{ENV.inspect}"
  end

  private def handle_errors
    yield
  rescue StandardError => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    raise e
  end
end
