class HomeController < ApplicationController
  def index
    render_success(:ok, meta: { message: "Api is working. Wuhoo..!!" })
  end
end
