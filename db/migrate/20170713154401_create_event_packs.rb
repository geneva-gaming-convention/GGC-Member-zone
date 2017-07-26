class CreateEventPacks < ActiveRecord::Migration[5.0]
  def change
    create_table    :event_packs do |t|
      t.string      :name
      t.text        :description
      t.numeric     :price
      t.string      :external_reference
      t.belongs_to  :event, index: true
      t.timestamps
    end
  end
end
