class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :editor_id
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
