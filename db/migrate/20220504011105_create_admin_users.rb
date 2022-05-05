class CreateAdminUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_users do |t|
      t.string :user_name, nil: false
      t.string :password_hash, nil: false
      t.string :password_solt, nil: false
      t.string :session_id, nil: true
      t.datetime :expired_at, nil: true
      t.datetime :deleted_at, nil: true
      t.timestamps
    end

    add_index :admin_users, :user_name, unique: true
    add_index :admin_users, :session_id, unique: true
  end
end
