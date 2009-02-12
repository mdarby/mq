class CreateEmailTable < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
      t.text :tmail
      t.string :mailer_method
      t.integer :attempts, :default => 0
      t.datetime :last_attempt_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :<%= table_name %>
  end
end