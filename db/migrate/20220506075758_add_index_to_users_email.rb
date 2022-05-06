class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :email, unique: true 
    # indexのuniqueを強制している
  end
end
