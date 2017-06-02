# == Schema Information
#
# Table name: firmwares
#
#  id                 :integer          not null, primary key
#  name               :string
#  manufacturer       :string
#  arduino_model      :integer          default("0")
#  compilation_result :integer          default("0")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Firmware < ApplicationRecord
  validates_presence_of :name, :manufacturer, :arduino_model, :compilation_result

  validates_inclusion_of :arduino_model, in: %w(uno mega)

  enum compilation_result: [:pending, :completed, :failed]

  def arduino_model_pid
    case arduino_model
    when 'uno'
      '0x0001'
    when 'mega'
      '0x0010'
    else
      '0x0000'
    end
  end

  def generate_hex_file
    firmware_path = File.join(Rails.root, 'tmp', 'firmwares', SecureRandom.uuid)
    FileUtils.mkdir_p firmware_path
    FileUtils.cp_r File.join(Rails.root, 'lib', 'assets', 'lufa_100807'), firmware_path

    project_directory_path = File.join(firmware_path, 'lufa_100807', 'Projects', 'mocolufa-master')

    # Descriptors
    descriptors_file_path = File.join(project_directory_path, 'Descriptors.c')
    content = File.read(descriptors_file_path)
    new_content = content.gsub(/{{MANUFACTURER_STRING}}/, manufacturer)
    new_content = new_content.gsub(/{{MANUFACTURER_STRING_LENGTH}}/, manufacturer.length.to_s)
    new_content = new_content.gsub(/{{PRODUCT_STRING}}/, name)
    new_content = new_content.gsub(/{{PRODUCT_STRING_LENGTH}}/, name.length.to_s)
    File.open(descriptors_file_path, "w") { |file| file.puts new_content }

    # Makefile
    make_file_path = File.join(project_directory_path, 'makefile')
    content = File.read(make_file_path)
    new_content = content.gsub(/{{ARDUINO_MODEL_PID}}/, arduino_model_pid)
    File.open(make_file_path, "w") {|file| file.puts new_content }

    # Make
    system "make -C #{project_directory_path}"
    return File.read File.join(project_directory_path, 'arduino_midi.hex')
    # return File.read make_file_path
  rescue
    errors.add(:compilation, 'Generic compilation error')
  ensure
    # Cleanup
    FileUtils.rm_rf firmware_path
  end
end
