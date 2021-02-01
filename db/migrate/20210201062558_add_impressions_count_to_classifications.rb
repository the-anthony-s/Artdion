class AddImpressionsCountToClassifications < ActiveRecord::Migration[6.1]
  def change
    add_column :classifications, :impressions_count, :int
  end
end
