class <%= class_name %> < ActiveRecord::Base

  serialize :tmail

  def self.queue(method, to, *args)
    method = method.to_s if method.is_a?(Symbol)
    [*to].each{|address| self.generate_mail(method, address, args)}
  end

  def self.deliver_all
    all.each{|m| m.deliver}
  end

  def to
    to = tmail.to.to_s
    to.blank? ? bcc : to
  end

  def bcc
    tmail.bcc.to_s
  end

  def from
    tmail.from.to_s
  end

  def deliver
    if <%= mailer_name %>.deliver(tmail)
      self.destroy
    else
      self.update_attributes({:attempts => self.attempts += 1, :last_attempt_at => Time.now})
    end
  end
  
  
  private

    def self.generate_mail(method, address, args)
      create!(:mailer_method => method, :tmail => <% mailer_name %>.send("create_#{method}".to_sym, address, *args))
    end

end
