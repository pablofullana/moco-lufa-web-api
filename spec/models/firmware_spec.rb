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

require 'rails_helper'

RSpec.describe Firmware, type: :model do
  describe 'validations' do
    let(:subject) { described_class.new }

    %i(name manufacturer arduino_model compilation_result).each do |attribute|
      it "validates presence of #{attribute}" do
        subject.send(:attribute, nil)
        subject.valid?

        expect(subject.errors.messages.values.flatten).to include(
          described_class.new.errors.generate_message(attribute, :blank)
        )
      end
    end
  end
end
