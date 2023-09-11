class ApplicationController < ActionController::Base
    include SessionsHelper
    
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
