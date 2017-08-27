class AddPidToFirmwares < ActiveRecord::Migration[5.1]
  def change
    add_column :firmwares, :pid, :string
  end
end
