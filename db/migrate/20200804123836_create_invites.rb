class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.references :team, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end

    add_foreign_key :invites, :users, column: :recipient_id
    add_foreign_key :invites, :users, column: :sender_id
    
  end
end
