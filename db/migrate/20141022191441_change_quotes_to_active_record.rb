class ChangeQuotesToActiveRecord < ActiveRecord::Migration
  def change
    create_table :quotes do |q|
      q.string :quote
      q.string :author
    end
  end
end
