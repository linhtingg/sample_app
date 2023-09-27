class ApplicationController < ActionController::Base
  # to use all helper methods defined inside SessionsHelper
  include SessionsHelper
  include Pagy::Backend

  def hello
    render html: "hello, world!"
  end

  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  private
    # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

end
