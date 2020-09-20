class AddHospitalTypeToHospitals < ActiveRecord::Migration[6.0]
  def change
    add_reference :hospitals, :hospital_type, index: true
  end
end
