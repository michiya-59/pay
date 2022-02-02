# frozen_string_literal: true

class ExpenseCategoriesController < ApplicationController
  before_action :redirect_when_no_logged_in
  before_action :set_expense_category, only: %i[edit update expense_categories_confirm_edit]

  def index
    @expenses = ExpenseCategory.all.order(id: 'ASC')
    @switch_line = 'expenses'
  end

  def new
    @expense = ExpenseCategory.new
  end

  def expense_categories_confirm_new
    @expense = ExpenseCategory.new(set_expense_params)
    render 'new' unless @expense.valid?
  end

  def create
    @expense = ExpenseCategory.new(set_expense_params)
    if @expense.save
      redirect_to expense_categories_path
      flash[:success] = '登録完了しました'
    end
  end

  def edit; end

  def expense_categories_confirm_edit
    @expense_name = params[:name]
  end

  def update
    @expense.update(set_expense_params)
    redirect_to expense_categories_path
    flash[:success] = '編集完了しました'
  end

  private

  def set_expense_params
    params.require(:expense_category).permit(:name, :user_id)
  end

  def set_expense_category
    @expense = ExpenseCategory.find(params[:id])
  end
end
