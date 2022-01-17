# frozen_string_literal: true

class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[edit suppliers_confirm_edit update destroy]
  before_action :get_switch_bisiness
  before_action :redirect_when_no_logged_in

  def index
    if @supplier_switch == 'false'
      @suppliers_main = Supplier.where(user_id: current_user, is_side_business: false).order(id: 'ASC')
      @switch_line = 'main'
    else
      @suppliers_sub = Supplier.where(user_id: current_user, is_side_business: true).order(id: 'ASC')
      @switch_line = 'sub'
    end
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
      redirect_to suppliers_url(is_side_business: false)
      flash[:success] = '登録完了しました'
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def destroy
    @supplier.destroy
    redirect_to suppliers_url(is_side_business: @supplier_switch)
    flash[:success] = '削除しました'
  end

  def suppliers_confirm_edit
    @supplier_name = params[:name]
  end

  def update
    @supplier.update(set_supplier_params)
    redirect_to suppliers_url(is_side_business: false)
    flash[:success] = '編集完了しました'
  end

  private

  def set_supplier_params
    params.require(:supplier).permit(:name, :user_id, :is_side_business)
  end

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def get_switch_bisiness
    @supplier_switch = params[:is_side_business]
  end
end
