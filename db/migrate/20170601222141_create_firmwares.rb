class CreateFirmwares < ActiveRecord::Migration[5.1]
  def change
    create_table :firmwares do |t|
      t.string :name
      t.string :manufacturer
      t.integer :arduino_model, default: 0
      t.integer :compilation_result, default: 0

      t.timestamps
    end
  end
end
