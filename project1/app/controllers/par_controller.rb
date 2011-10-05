class ParController < ApplicationController
  def search
    
  end

  def display
     @account = Salesforce::Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

end
