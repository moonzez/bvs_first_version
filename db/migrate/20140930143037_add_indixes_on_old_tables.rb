class AddIndixesOnOldTables < ActiveRecord::Migration
  def change
    add_index :htsreferents, :htseminar_id
    add_index :htsreferents, :referent_id
    add_index :languages_users, :language_id
    add_index :languages_users, :user_id
    add_index :licenses_users, :license_id
    add_index :licenses_users, :user_id
    add_index :opentourrefs, :opentour_id
    add_index :opentourrefs, :referent_id
    add_index :opentourwishes, :opentour_id
    add_index :opentourwishes, :referent_id
    add_index :roles_users, :role_id
    add_index :roles_users, :user_id
    add_index :tourreferents, :detour_id
    add_index :tourreferents, :referent_id
    add_index :tsreferents, :ts_request_id
    add_index :tsreferents, :referent_id
    add_index :workreferents, :workshop_id
    add_index :workreferents, :referent_id
  end
end
