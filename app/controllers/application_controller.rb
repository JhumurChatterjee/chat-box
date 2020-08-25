class ApplicationController < ActionController::API
  require "auth"

  rescue_from ActiveRecord::RecordNotFound, with: :not_found!

  protected

  def authenticate_user
    render_error(:unauthorized, ["Login required"]) unless current_user
  end

  def current_user
    return unless auth_present? && auth.first["exp"] > Time.zone.now.to_i

    @current_user ||= User.find_by(id: auth.first["user"])
  end

  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    request.env.fetch("HTTP_AUTHORIZATION", "").scan(/Bearer/).flatten.first.present?
  end

  def render_json_api(resource, options = {})
    options[:adapter]               ||= :json_api
    options[:key_transform]         ||= :camel_lower
    options[:serialization_context] ||= ActiveModelSerializers::SerializationContext.new(request)
    options[:serializer]              = NullSerializer unless resource
    ActiveModelSerializers::SerializableResource.new(resource, options)
  end

  def render_success(status, resource, options = {})
    render json: render_json_api(resource, options).as_json, status: status
  end

  def render_error(status, errors = [], meta = {})
    if errors.is_a?(ActiveModel::Errors)
      render json: { errors: Hash[errors.keys.map { |f| [f, errors.full_messages_for(f)] }], meta: meta }, status: status
    else
      render json: { errors: errors, meta: meta }, status: status
    end
  end

  def not_found!
    render_error(:not_found, ["Record not found"])
  end
end
