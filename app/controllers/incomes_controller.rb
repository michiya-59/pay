class IncomesController < ApplicationController
  before_action :get_switch_bisiness
  before_action :redirect_when_no_logged_in

  def index
    @income = Income.new
    @suppliers = Supplier.where(user_id: current_user.id, is_side_business: @supplier_switch)
    @income_main_price_all = Income.where(user_id: current_user.id, is_side_business: @supplier_switch).group(:month).sum(:price)
  end

  def new
  end

  def create
    @suppliers = Supplier.where(user_id: current_user.id, is_side_business: @supplier_switch)
    @income = Income.new(set_income_params.merge(set_income_params_supplier))
    if @income.save
      redirect_to user_incomes_path(current_user, is_side_business: false)
      flash[:success] = "本業収入を登録しました"
    else
      redirect_to user_incomes_path(current_user, is_side_business: false)
      flash[:error] = @income.errors.full_messages
    end
  end

  def edit
  end

  def destroy
  end

  def show
  end

  private

  def set_income_params
    params.require(:income).permit(:month, :price, :user_id, :is_side_business, :year)
  end

  def set_income_params_supplier
    params.require(:supplier).permit(:supplier_id)
  end

  def get_switch_bisiness
    @supplier_switch = params[:is_side_business]
  end
end
