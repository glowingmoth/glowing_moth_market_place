class AssetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy, :payment_success, :payment_failed]
  before_action :admin_check, only: [:new, :edit, :update, :create, :destroy]
  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  # GET /assets
  # GET /assets.json
  def index
    @assets = Asset.all
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    if user_signed_in?
      session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          customer_email: current_user.email,
          line_items: [{
              name: @asset.title,
              description: @asset.description,
              amount: @asset.price * 100,
              currency: 'aud',
              quantity: 1
          }],
          payment_intent_data: {
              metadata: {
                  user_id: current_user.id,
                  asset_id: @asset.id
              }
          },
          success_url: "#{root_url}assets/payment_success?userId=#{current_user.id}&assetId=#{@asset.id}&price=#{@asset.price}",
          cancel_url: "#{root_url}assets/payment_failed?assetId=#{@asset.id}"
      )

      @session_id = session.id
    end
  end

  # GET /assets/new
  def new
    @asset = Asset.new
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = Asset.new(asset_params)
    @asset.user_id = current_user.id
    # if params[:asset][:pictures].present?
    #   params[:asset][:pictures].each do |pic|
    #     @asset.pictures.attach(pic)
    #   end
    # end
    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
        format.json { render :show, status: :created, location: @asset }
      else
        format.html { render :new }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update
    respond_to do |format|
      if @asset.update(asset_params)
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset }
      else
        format.html { render :edit }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to assets_url, notice: 'Asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def payment_success
    Purchase.create(asset_id: params[:assetId].to_i, user_id: params[:userId].to_i, price: params[:price].to_i)
    redirect_to asset_path(params[:assetId].to_i), notice: 'Payment was successful.'
  end

  def payment_failed
    redirect_to asset_path(params[:assetId].to_i), notice: 'Payment.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = Asset.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_params
      params.require(:asset).permit(:title, :description, :content, :price, :zip_file, pictures: [])
    end

    def admin_check
      if !(current_user.has_role? :admin)
        redirect_to pages_home_path, alert: 'You don\'t have permissions.'
      end
    end

end
