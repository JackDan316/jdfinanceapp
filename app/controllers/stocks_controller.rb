class StocksController < ApplicationController
    
   def search 
      if params[:stock].blank?
         flash.now[:danger] = "Please enter a symbol"
      else
         @stock = Stock.new_from_lookup(params[:stock]) 
         flash.now[:danger] = "Kindly Enter a Valid Symbol" unless @stock
      end   
      respond_to do |format|
         format.js { render partial: 'users/result' }
      end   
   end
end