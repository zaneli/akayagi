class AddAkayagiProjectSettingsToCcBcc < ActiveRecord::Migration
  def change
    add_column :akayagi_project_settings, :to_address, :string
    add_column :akayagi_project_settings, :cc_address, :string
    add_column :akayagi_project_settings, :bcc_address, :string
  end
end
