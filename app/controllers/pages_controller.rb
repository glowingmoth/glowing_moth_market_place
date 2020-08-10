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

  def remove_account
  end

  def bootstrap
  end

  def purchase_history
    @purchase = Purchase.where(user_id: current_user.id)
  end

  def customer_records
  
  end
  
end
