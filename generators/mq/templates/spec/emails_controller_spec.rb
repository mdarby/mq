require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module <%= class_name %>Attributes
  def valid_attributes
    {
      :mailer_method   => "send_some_<%= object_name %>",
      :attempts        => 0,
      :last_attempt_at => nil,
      :created_at      => Date.parse("2009-02-11"),
      :updated_at      => Date.parse("2009-02-11")
    }
  end
end

describe <%= class_name %>sController do

  include <%= class_name %>Attributes

  before do
    @<%= object_name %> = <%= class_name %>.create!(valid_attributes)
    @<%= object_name %>.stub!(:deliver => true)

    <%= class_name %>.stub!({
      :find        => @<%= object_name %>,
      :all         => [@<%= object_name %>],
      :deliver_all => true,
      :destroy_all => true
    })

    request.env["HTTP_REFERER"] = "/somewhere"
    @back = "http://test.host/somewhere"
  end

  describe "GET :index" do
    def do_get
      get :index
    end

    it "should find all <%= object_name %>s" do
      <%= class_name %>.should_receive(:all)
      do_get
    end

    it "should assign @<%= object_name %>s for the view" do
      do_get
      assigns[:<%= object_name %>s].should == [@<%= object_name %>]
    end

  end

  describe "GET :deliver" do
    before do
      <%= class_name %>.stub!(:find).with("1").and_return(@<%= object_name %>)
    end

    def do_get
      get :deliver, :id => "1"
    end

    it "should find the <%= object_name %> in question" do
      <%= class_name %>.should_receive(:find).with("1").and_return(@<%= object_name %>)
      do_get
    end

    it "should deliver the <%= object_name %>" do
      @<%= object_name %>.should_receive(:deliver)
      do_get
    end

    it "should redirect back" do
      do_get
      response.should redirect_to(@back)
    end

  end

  describe "GET :deliver_all" do
    def do_get
      get :deliver_all
    end

    it "should deliver all <%= object_name %>s" do
      <%= class_name %>.should_receive(:deliver_all)
      do_get
    end

    it "should redirect back" do
      do_get
      response.should redirect_to(@back)
    end

  end

  describe "DELETE :destroy" do

    def do_destroy
      delete :destroy, :id => "1"
    end

    it "should destroy the <%= object_name %>" do
      @<%= object_name %>.should_receive(:destroy)
      do_destroy
    end

    it "should redirect back" do
      do_destroy
      response.should redirect_to(@back)
    end

  end

  describe "DELETE :destroy_all" do

    def do_destroy
      delete :destroy_all
    end

    it "should destroy all <%= object_name %>" do
      <%= class_name %>.should_receive(:destroy_all)
      do_destroy
    end

    it "should redirect back" do
      do_destroy
      response.should redirect_to(@back)
    end

  end

end
