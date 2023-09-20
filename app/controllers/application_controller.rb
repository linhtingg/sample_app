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

end
