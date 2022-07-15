class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_id, index: { unique: true, name: 'unique_user_id' }
      t.string :password_digest

      t.timestamps
    end
  end
end
