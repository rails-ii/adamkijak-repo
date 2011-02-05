class DeviseCreateEditors < ActiveRecord::Migration
  def self.up
    create_table(:editors) do |t|
      t.database_authenticatable :null => false
      # t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both

      t.timestamps
    end

    add_index :editors, :email,                :unique => true
    # add_index :editors, :confirmation_token,   :unique => true
    add_index :editors, :reset_password_token, :unique => true
    # add_index :editors, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :editors
  end
end
