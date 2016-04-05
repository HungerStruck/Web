class BundlesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery except: [:hook]
  skip_before_filter :verify_authenticity_token, :only => [:hook]
  skip_before_filter :authenticate_user!, :only => :hook

  def index
    @bundles = Bundle.desc(:created_at).where(:user_id => current_user.id).page(params[:page]).per(5)
  end

  def new
    @bundle = Bundle.new
  end

  def create
    @bundle = Bundle.new(bundle_params)
    @bundle.user = current_user.id
    # TODO: Actually generate the bundle here with GCP lib
    #@bundle.ip = "xxx.xxx.xxx.xxx"
    #@bundle.expires = Time.now

    if @bundle.save
      flash[:success] = "bundle created successfully!"
      redirect_to @bundle
    else
      render 'new'
    end
  end

  def show
    @bundle = Bundle.find(params[:id])
  end

  def destroy
    Bundle.find(params[:id]).destroy
    flash[:success] = "Bundle destroyed."
    redirect_to bundles_path
  end

  def check_out
      @transaction = Transaction.new
      @transaction.user = current_user.id
      @transaction.bundle = params[:bundle]
      #@transaction.hours = params[:hours]

      @bundle = Bundle.find(params[:bundle])
      @transaction.name = @bundle.name
      @transaction.amount = @bundle.amount
      @transaction.save

      @url = @bundle.paypal_url(bundle_path(@bundle),@transaction.amount, @transaction.id ,"#{@bundle.name}" , "#{@bundle.id}" )
      redirect_to @url

  end

  def hook
    paypal_response = Ipn.new(params, request.raw_post)

    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed" && paypal_response.valid?
      @transaction = Transaction.find params[:custom]
      @transaction.complete = true
      @bundle = @transaction.bundle
      #@bundle.expires = @bundle.expires + @transaction.hours.hours
      @bundle.save
      @transaction.save
    end
    render nothing: true
  end

  private

    def bundle_params
      params.require(:bundle).permit(:name, :description, :amount)
    end
end
