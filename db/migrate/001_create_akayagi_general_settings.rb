class CreateAkayagiGeneralSettings < ActiveRecord::Migration
  def change
    create_table :akayagi_general_settings do |t|
      t.string :subject_prefix
    end
  end
end
