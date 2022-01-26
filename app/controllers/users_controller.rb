# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :income_info_all, only: %i[main sub]

  def home; end

  def new
    @user = User.new
  end

  def user_confirm_new
    @user = User.new(user_params)
    render 'new' unless @user.valid?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to suppliers_path(is_side_business: false)
    else
      render 'new'
    end
  end

  def main
    @line = 'main'
    render 'main'
  end

  def sub
    @line = 'main'
    render 'sub'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def income_info_all
    @income_main_total_price = Income.where(user_id: current_user.id, is_side_business: false, year: now_date_year).group(:year).group(:month).sum(:price)
    @income_sub_total_price = Income.where(user_id: current_user.id, is_side_business: true, year: now_date_year).group(:year).group(:month).sum(:price)
    @expense_price_all = Expense.where(user_id: current_user.id, year: now_date_year).group(:year).group(:month).sum(:price)
    @tax_calculation_price = tax_calculation(@income_main_total_price, @income_sub_total_price, @expense_price_all)
    @social_insurance_price = social_insurance_tax_calculation(@income_main_total_price, @income_sub_total_price)
  end
end
