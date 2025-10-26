class AddDeletedAtToQuestionnaires < ActiveRecord::Migration[8.0]
  def change
    add_column :questionnaires, :deleted_at, :datetime
  end
end
