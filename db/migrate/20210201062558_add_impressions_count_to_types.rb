class AddImpressionsCountToTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :types, :impressions_count, :int
  end
end
