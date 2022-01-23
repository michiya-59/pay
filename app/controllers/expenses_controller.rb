class ExpensesController < ApplicationController
  before_action :redirect_when_no_logged_in
  before_action :set_expense_params, only: [:create]
  before_action :set_expense_category, only: [:create]
  before_action :part_expense
  before_action :line_judge

  def index
    @expense = Expense.new
    @expense_categories = ExpenseCategory.where(user_id: current_user.id)
    @expense_price_all = @expenses.group(:year).group(:month).sum(:price)
  end

  def new
  end

  def create
    @expense = Expense.new(set_expense_params.merge(set_expense_category))
    if @expense.save
      redirect_to user_expenses_path(current_user)
      flash[:success] = "経費を登録しました"
    else
      redirect_to user_expenses_path(current_user)
      flash[:error] = @expense.errors.full_messages
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

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

  def part_expense
    @expenses = Expense.where(user_id: current_user.id)
  end

  def line_judge
    @line = "expense"
  end
end
