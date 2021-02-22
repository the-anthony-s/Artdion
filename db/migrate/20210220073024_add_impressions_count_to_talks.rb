class AddImpressionsCountToTalks < ActiveRecord::Migration[6.1]
  def change
    add_column :talks, :impressions_count, :int
  end
end
