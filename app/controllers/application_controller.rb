class ApplicationController < ActionController::API
  protected

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
end
