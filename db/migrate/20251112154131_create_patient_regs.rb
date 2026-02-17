class CreatePatientRegs < ActiveRecord::Migration[8.1]
  def change
    create_table :patient_regs do |t|
      t.string :FirstName
      t.string :MiddleName
      t.string :LastName
      t.string :Phone
      t.string :Email
      t.text :Address
      t.string :Health_issue
      t.string :Diagnosis

      t.timestamps
    end
  end
end
