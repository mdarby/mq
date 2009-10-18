require File.dirname(__FILE__) + '/../spec_helper'

describe <%= class_name %>sController do
  describe "route generation" do

    it "should map { :controller => '<%= object_name %>s', :action => 'index' } to /<%= object_name %>s" do
      route_for(:controller => "<%= object_name %>s", :action => "index").should == "/<%= object_name %>s"
    end

    it "should map { :controller => '<%= object_name %>s', :action => 'destroy', :id => 1} to /<%= object_name %>s/1" do
      route_for(:controller => "<%= object_name %>s", :action => "destroy", :id => '1').should == {:path => "/<%= object_name %>s/1", :method => :delete}
    end

    it "should map { :controller => '<%= object_name %>s', :action => 'deliver', :id => 1} to /<%= object_name %>s/1/deliver" do
      route_for(:controller => "<%= object_name %>s", :action => "deliver", :id => '1').should == "/<%= object_name %>s/1/deliver"
    end

    it "should map { :controller => '<%= object_name %>s', :action => 'deliver_all'} to /<%= object_name %>s/deliver_all" do
      route_for(:controller => "<%= object_name %>s", :action => "deliver_all").should == "/<%= object_name %>s/deliver_all"
    end

    it "should map { :controller => '<%= object_name %>s', :action => 'destroy_all'} to /<%= object_name %>s/destroy_all" do
      route_for(:controller => "<%= object_name %>s", :action => "destroy_all").should == "/<%= object_name %>s/destroy_all"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => '<%= object_name %>s', action => 'index' } from GET /<%= object_name %>s" do
      params_from(:get, "/<%= object_name %>s").should == {:controller => "<%= object_name %>s", :action => "index"}
    end

    it "should generate params { :controller => '<%= object_name %>s', action => 'destroy', id => '1' } from DELETE /<%= object_name %>s/1" do
      params_from(:delete, "/<%= object_name %>s/1").should == {:controller => "<%= object_name %>s", :action => "destroy", :id => "1"}
    end

    it "should generate params { :controller => '<%= object_name %>s', action => 'deliver', id => '1' } from GET /<%= object_name %>s/1/deliver" do
      params_from(:get, "/<%= object_name %>s/1/deliver").should == {:controller => "<%= object_name %>s", :action => "deliver", :id => "1"}
    end

    it "should generate params { :controller => '<%= object_name %>s', action => 'deliver_all' } from GET /<%= object_name %>s/deliver_all" do
      params_from(:get, "/<%= object_name %>s/deliver_all").should == {:controller => "<%= object_name %>s", :action => "deliver_all"}
    end

    it "should generate params { :controller => '<%= object_name %>s', action => 'destroy_all' } from GET /<%= object_name %>s/destroy_all" do
      params_from(:get, "/<%= object_name %>s/destroy_all").should == {:controller => "<%= object_name %>s", :action => "destroy_all"}
    end
  end
end