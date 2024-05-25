class ApplicationController < ActionController::Base
  def goodbye
    render html: "goodbye, neko!"
  end
end
