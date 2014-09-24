class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :language
    end

    create_table :languages_users, :id => false do |t|
      t.integer :language_id
      t.integer :user_id
    end
  end
end
