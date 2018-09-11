class UserStocksController < ApplicationController
    
    def create
        stock = Stock.find_by_ticker(params[:stock_ticker])
        if stock.blank?
            stock = Stock.new_from_lookup(params[:stock_ticker])
            stock.save
        end
        @user_stocks = UserStock.create(user: current_user,stock: stock)
        flash[:success] = " #{@user_stocks.stock.name} was successfully added to the Stocks Tracking List"
        redirect_to my_portfolio_path
    end
    
    def destroy
        
        stock = Stock.find(params[:id])
        @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
        @user_stock.destroy
        flash[:notice] = "Stopped tracking #{@user_stock.stock.name}"
        redirect_to my_portfolio_path
    end
    
end