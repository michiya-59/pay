# frozen_string_literal: true

class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[edit suppliers_confirm_edit update]
  before_action :set_user_id

  def index
    @suppliers = Supplier.all
    @switch_line = 'main'
  end

  def new
    @supplier = Supplier.new
  end

  def supplier_confirm_new
    @supplier = Supplier.new(set_supplier_params)
    render 'new' unless @supplier.valid?
  end

  def create
    @supplier = Supplier.new(set_supplier_params)
    if @supplier.save
      redirect_to user_suppliers_url
      flash[:success] = '登録完了しました'
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def suppliers_confirm_edit
    @supplier_name = params[:name]
  end

  def update
    @supplier.update(set_supplier_params)
    redirect_to user_suppliers_url
    flash[:success] = '編集完了しました'
  end

  private

  def set_supplier_params
    params.require(:supplier).permit(:name, :user_id, :is_side_business)
  end

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def set_user_id
    @user = params[:user_id]
  end
end
