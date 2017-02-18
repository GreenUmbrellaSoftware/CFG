class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :dn
      t.string :cn
      t.boolean :active, :default => false
      t.boolean :pending, :default => true

      t.timestamps
    end
  end
end
