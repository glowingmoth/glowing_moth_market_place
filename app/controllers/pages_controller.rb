class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to assets_path
    else
      redirect_to new_user_registration_path
    end
  end

  def about
  end

  def contact
  end
end
