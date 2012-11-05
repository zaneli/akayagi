class CreateAkayagiProjectSettings < ActiveRecord::Migration
  def change
    create_table :akayagi_project_settings do |t|
      t.integer :project_id, :null => false
      t.string :subject_prefix
      t.string :from_address
    end
  end
end
