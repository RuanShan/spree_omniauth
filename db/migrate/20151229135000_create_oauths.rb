class CreateOauths < ActiveRecord::Migration
  def self.up
    create_table :spree_oauths do |t|
      t.string :provider, :nil => false
      t.integer :uid, :nil => false
      t.text :user_info
      t.string :name
      t.integer :user_id, :nil => false
      t.timestamps
    end
    add_index :spree_oauths, [:uid,:provider], :unique => true
    add_index :spree_oauths, :user_id
  end

  def self.down
    drop_table :spree_oauths
  end
end
