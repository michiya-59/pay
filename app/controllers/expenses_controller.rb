# frozen_string_literal: true

class ExpensesController < ApplicationController
  before_action :redirect_when_no_logged_in
  before_action :set_expense_params, only: [:create]
  before_action :set_expense_category, only: [:create]
  before_action :part_expenses
  before_action :expense, only: %i[edit expense_confirm_edit update]
  before_action :set_expense, only: [:update]
  before_action :line_judge

  def index
    @expense = Expense.new
    @expense_categories = ExpenseCategory.where(user_id: current_user.id)
    @expense_price_all = @expenses.group(:year).group(:month).sum(:price)
  end

  def new; end

  def create
    @expense = Expense.new(set_expense_params.merge(set_expense_category))
    redirect_to user_expenses_path(current_user)
    if @expense.save
      flash[:success] = '経費を登録しました'
    else
      flash[:error] = @expense.errors.full_messages
    end
  end

  def edit; end

  def expense_confirm_edit
    @expense_price = params[:price]
    @expense_price = params[:price].tr!('０-９', '0-9') if /\A[０-９]+\z/.match?(@expense_price.to_s) # 全角数字だった場合半角数字に変換している処理
    if @expense_price.blank?
      redirect_to edit_user_expense_path(current_user)
      flash[:error] = '経費を正しく収入を入力してください'
    end
  end

  def update
    @expense.update(set_expense)
    redirect_to shows_user_expenses_path(current_user, month: @expense.month, year: @expense.year)
    flash[:success] = '編集完了しました'
  end

  def destroy; end

  def show; end

  def shows
    @month = params[:month]
    @year = params[:year]

    @monthly_expenses = Expense.where(user_id: current_user.id, year: @year, month: @month)
  end

  private

  def set_expense_params
    params.require(:expense).permit(:month, :price, :user_id, :year)
  end

  def set_expense_category
    params.require(:expense_category).permit(:expense_category_id)
  end

  def set_expense
    params.require(:expense).permit(:month, :price, :user_id, :year, :expense_category_id)
  end

  def part_expenses
    @expenses = Expense.where(user_id: current_user.id)
  end

  def expense
    @expense = Expense.find(params[:id])
  end

  def line_judge
    @line = 'expense'
  end
end
