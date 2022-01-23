# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
class IncomesController < ApplicationController
  before_action :redirect_when_no_logged_in
  before_action :get_switch_bisiness
  before_action :total_income
  before_action :line_judge
  include(IncomesHelper)

  def index
    @income = Income.new
    @suppliers = Supplier.where(user_id: current_user.id, is_side_business: @supplier_switch)
    @monthly_income = @incomes.group(:year).group(:month).sum(:price)
    @is_side_business_income = Income.find_by(user_id: current_user.id, is_side_business: true)
    @income_sub_total_price = Income.where(user_id: current_user.id, is_side_business: true).group(:year).group(:month).sum(:price)
    @income_main_total_price = Income.where(user_id: current_user.id, is_side_business: false).group(:year).group(:month).sum(:price)
    @expense_price_all = Expense.where(user_id: current_user.id).group(:year).group(:month).sum(:price)
    @tax_calculation_price = tax_calculation(@monthly_income, @income_sub_total_price, @expense_price_all)
  end

  def new; end

  def create
    @suppliers = Supplier.where(user_id: current_user.id, is_side_business: @supplier_switch)
    @income = Income.new(set_income_params.merge(set_income_params_supplier))
    case @income.is_side_business
    when false
      redirect_to user_incomes_path(current_user, is_side_business: false)
      if @income.save
        flash[:success] = '本業収入を登録しました'
      else
        flash[:error] = @income.errors.full_messages
      end
    when true
      redirect_to user_incomes_path(current_user, is_side_business: true)
      if @income.save
        flash[:success] = '副業収入を登録しました'
      else
        flash[:error] = @income.errors.full_messages
      end
    end
  end

  def edit; end

  def destroy; end

  def show; end

  def shows
    @month = params[:month]
    @year = params[:year]
    @supplier_business = params[:is_side_business]

    @monthly_incomes = Income.where(user_id: current_user.id, is_side_business: @supplier_business, year: @year, month: @month)
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

  def total_income
    @incomes = Income.where(user_id: current_user.id, is_side_business: @supplier_switch)
  end

  def line_judge
    if @supplier_switch == "false"
      @line = "main"
    else
      @line = "sub"
    end
  end
end
# rubocop:enable Metrics/AbcSize
