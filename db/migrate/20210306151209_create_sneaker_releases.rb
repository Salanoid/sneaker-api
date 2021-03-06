class CreateSneakerReleases < ActiveRecord::Migration[6.1]
  def change
    create_table :sneaker_releases do |t|
      t.string :name
      t.string :price
      t.string :date
      t.text :image

      t.timestamps
    end
  end
end
