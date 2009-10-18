require File.dirname(__FILE__) + '/../spec_helper'

module <%= class_name %>Attributes
  def valid_attributes
    {
      :mailer_method   => "send_some_email",
      :attempts        => 0,
      :last_attempt_at => nil,
      :created_at      => Date.parse("2009-02-11"),
      :updated_at      => Date.parse("2009-02-11")
    }
  end
end

describe <%= class_name %> do

  include <%= class_name %>Attributes

  before do
    @<%= object_name %> = <%= class_name %>.create!(valid_attributes)
    @tmail = mock_model(TMail)
    @<%= object_name %>.stub!(:tmail => @tmail)

    @obj = mock("something")
  end

  it "should be valid" do
    @<%= object_name %>.should be_valid
  end

  it "should know how to queue an <%= object_name %> with a singular recipient" do
    <%= class_name %>.should_receive(:generate_mail).with("send_some_<%= object_name %>", "foo@bar.com", [@obj])
    <%= class_name %>.queue("send_some_<%= object_name %>", "foo@bar.com", @obj)
  end

  it "should know how to queue an <%= object_name %> with a multiple recipients" do
    <%= class_name %>.should_receive(:generate_mail).with("send_some_<%= object_name %>", "foo@bar.com", [@obj])
    <%= class_name %>.should_receive(:generate_mail).with("send_some_<%= object_name %>", "bar@foo.com", [@obj])
    <%= class_name %>.queue("send_some_<%= object_name %>", ["foo@bar.com", "bar@foo.com"], @obj)
  end

  it "should convert the method parameter to a String if its a Symbol" do
    <%= class_name %>.should_receive(:generate_mail).with("send_some_<%= object_name %>", "foo@bar.com", [@obj])
    <%= class_name %>.queue(:send_some_<%= object_name %>, "foo@bar.com", @obj)
  end

  it "should be able to deliver all queued <%= object_name %>s" do
    <%= class_name %>.stub!(:all => [@<%= object_name %>])
    @<%= object_name %>.should_receive(:deliver)

    <%= class_name %>.deliver_all
  end

  it "should tell us who the <%= object_name %> is for" do
    @tmail.stub!(:to => "foo@bar.com")
    @<%= object_name %>.to.should == "foo@bar.com"
  end

  it "should tell us who the <%= object_name %> is for (via the BCC field)" do
    @tmail.stub!(:to => "", :bcc => "foo@bar.com")
    @<%= object_name %>.to.should == "foo@bar.com"
  end

  it "should tell us who the <%= object_name %> is from" do
    @tmail.stub!(:from => "foo@bar.com")
    @<%= object_name %>.from.should == "foo@bar.com"
  end

  it "should be able to deliver its self" do
    @<%= object_name %>.should respond_to(:deliver)
    <%= mailer_name %>.should_receive(:deliver).with(@tmail).and_return(true)
    @<%= object_name %>.deliver
  end


  describe " when it is successfully delivered" do
    before do
      <%= mailer_name %>.stub!(:deliver => true)
    end

    it "should commit suicide" do
      @<%= object_name %>.should_receive(:destroy)
      @<%= object_name %>.deliver
    end
  end

  describe " when it is not successfully delivered" do
    before do
      <%= mailer_name %>.stub!(:deliver => false)
    end

    it "should increment the attempts attribute" do
      @<%= object_name %>.deliver
      @<%= object_name %>.attempts.should == 1
    end

    it "should set the #last_attempt_at attribute" do
      now = Time.now
      Time.stub!(:now => now)
      @<%= object_name %>.deliver
      @<%= object_name %>.last_attempt_at.should == now
    end
  end

  describe " the #generate_mail method" do
    it "should create a new <%= class_name %> object" do
      <%= mailer_name %>.should_receive("create_send_some_<%= object_name %>").with("foo@bar.com", @obj).and_return(@tmail)
      <%= class_name %>.should_receive(:create!).with(:mailer_method => "send_some_<%= object_name %>", :tmail => @tmail)

      <%= class_name %>.queue("send_some_<%= object_name %>", "foo@bar.com", @obj)
    end
  end

end
