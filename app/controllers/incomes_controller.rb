# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
class IncomesController < ApplicationController
  before_action :redirect_when_no_logged_in
  before_action :get_switch_bisiness
  before_action :total_income, only: %i[index shows]
  before_action :line_judge
  before_action :get_income, only: %i[edit income_confirm_edit update]
  include(IncomesHelper)

  def index
    @income = Income.new
    @suppliers = Supplier.where(user_id: current_user.id, is_side_business: @supplier_switch)
    @monthly_income = @incomes.group(:year).group(:month).sum(:price)
    @is_side_business_income = Income.find_by(user_id: current_user.id, is_side_business: true, year: now_date_year)
    @income_sub_total_price = Income.where(user_id: current_user.id, is_side_business: true, year: now_date_year).group(:year).group(:month).sum(:price)
    @income_main_total_price = Income.where(user_id: current_user.id, is_side_business: false, year: now_date_year).group(:year).group(:month).sum(:price)
    @expense_price_all = Expense.where(user_id: current_user.id, year: now_date_year).group(:year).group(:month).sum(:price)
    @tax_calculation_price = tax_calculation(@income_main_total_price, @income_sub_total_price, @expense_price_all)
  end

  def new; end

  def create
    @suppliers = Supplier.where(user_id: current_user.id, is_side_business: @supplier_switch)
    @income = Income.new(set_income_params.merge(set_income_params_supplier))
    case @income.is_side_business
    when false
      redirect_to incomes_path(is_side_business: false)
      if @income.save
        flash[:success] = '本業収入を登録しました'
      else
        flash[:error] = @income.errors.full_messages
      end
    when true
      redirect_to incomes_path(is_side_business: true)
      if @income.save
        flash[:success] = '副業収入を登録しました'
      else
        flash[:error] = @income.errors.full_messages
      end
    end
  end

  def edit; end

  def income_confirm_edit
    @income_price = params[:price]
    @income_price = params[:price].tr!('０-９', '0-9') if /\A[０-９]+\z/.match?(@income_price.to_s) # 全角数字だった場合半角数字に変換している処理
    if @income_price.blank?
      redirect_to edit_income_path(income, is_side_business: @income.is_side_business)
      flash[:error] = "#{supplier_which?(params[:is_side_business])}収入を入力してください"
    end
  end

  def update
    @income.update(post_params)
    redirect_to shows_incomes_path(is_side_business: @income.is_side_business, month: @income.month, year: @income.year)
    flash[:success] = '編集完了しました'
  end

  def destroy; end

  def show; end

  def shows
    @month = params[:month]
    @year = params[:year]
    @supplier_business = params[:is_side_business]

    @monthly_incomes = Income.includes(:supplier).where(user_id: current_user.id, is_side_business: @supplier_business, year: @year, month: @month)
  end

  private

  def set_income_params
    params.require(:income).permit(:month, :price, :user_id, :is_side_business, :year)
  end

  def set_income_params_supplier
    params.require(:supplier).permit(:supplier_id)
  end

  def post_params
    params.require(:income).permit(:price)
  end

  def get_switch_bisiness
    @supplier_switch = params[:is_side_business]
  end

  def total_income
    @incomes = Income.where(user_id: current_user.id, is_side_business: @supplier_switch, year: now_date_year)
  end

  def line_judge
    @line = if @supplier_switch == 'false'
              'main'
            else
              'sub'
            end
  end

  def get_income
    @income = Income.find(params[:id])
  end
end
# rubocop:enable Metrics/AbcSize
