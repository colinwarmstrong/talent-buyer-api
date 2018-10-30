class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end
end
