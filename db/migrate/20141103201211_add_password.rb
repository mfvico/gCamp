class AddPassword < ActiveRecord::Migration
  def change
    def change
      add_column :users, :password_digest, :string
    end
  end
end
