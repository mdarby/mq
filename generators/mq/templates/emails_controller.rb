class <%= class_name %>sController < ApplicationController
  
  before_filter :load_items
  
  
  def load_items
    @<%= object_name %> = <%= class_name %>.find(params[:id]) if params[:id]
  end
  
  def index
    @<%= object_name %>s = <%= class_name %>.all(:order => "created_at")
  end
  
  def deliver
    @<%= object_name %>.deliver
    redirect_to :back
  end
  
  def deliver_all
    <%= class_name %>.deliver_all
    redirect_to :back
  end
  
  def destroy
    @<%= object_name %>.destroy
    redirect_to :back
  end
  
  def destroy_all
    <%= class_name %>.destroy_all
    redirect_to :back
  end
  
end