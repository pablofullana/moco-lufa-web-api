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

  enum arduino_model: [:uno, :mega]

  enum compilation_result: [:pending, :completed, :failed]
end
