class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = Transaction.desc(:created_at).where(:user_id => current_user.id).page(params[:page]).per(15)
  end

end
