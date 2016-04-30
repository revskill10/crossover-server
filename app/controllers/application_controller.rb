class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_origin
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from NotAuthorizedError, with: :permission_denied
  protected
  def set_origin
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
  def permission_denied
    render_json_error_message "Invalid access", 403
    return
  end
  def parameter_missing(exception)
    render_json_error_message "Bad Request", 400
    return
  end
  def render_json_error_message(message, status = 400)
    render json: {message: message, errors: []}, status: status
  end

  def raise_permission_denied_exception(message = "")
    raise NotAuthorizedError, message
  end
end
