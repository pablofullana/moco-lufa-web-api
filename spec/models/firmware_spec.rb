# == Schema Information
#
# Table name: firmwares
#
#  id                 :integer          not null, primary key
#  name               :string
#  manufacturer       :string
#  arduino_model      :string
#  compilation_result :integer          default("0")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  pid                :string
#

require 'rails_helper'

RSpec.describe Firmware, type: :model do
  describe 'validations' do
    let(:subject) { described_class.new }

    %i(name manufacturer arduino_model compilation_result pid).each do |attribute|
      it "validates presence of #{attribute}" do
        subject.send(:attribute, nil)
        subject.valid?

        expect(subject.errors.messages.values.flatten).to include(
          described_class.new.errors.generate_message(attribute, :blank)
        )
      end
    end
  end

  describe '#arduino_model_pid' do
    let(:subject) { described_class.new }

    context 'when arduino_model is uno' do
      before do
        subject.arduino_model = :uno
      end

      it 'returns 0x0001' do
        expect(subject.arduino_model_pid).to eq '0x0001'
      end
    end

    context 'when arduino_model is mega' do
      before do
        subject.arduino_model = :mega
      end

      it 'returns 0x0010' do
        expect(subject.arduino_model_pid).to eq '0x0010'
      end
    end
  end

  describe '#pid' do
    let(:subject) { described_class.new }
    valid_values = ['0x1000', '0x1001', '0x100A', '0x999F', '0xf000', '0xffff']
    invalid_values = ['0x0000', '0x0x999F', '0xfffff', '0x10000']

    valid_values.each do |valid_value|
      context "when pid is #{valid_value}" do
        before do
          subject.pid = valid_value
          subject.valid?
        end

        it 'returns no errors' do
          expect(subject.errors[:pid]).to be_empty
        end
      end
    end

    invalid_values.each do |invalid_value|
      context "when pid is #{invalid_value}" do
        before do
          subject.pid = invalid_value
          subject.valid?
        end

        it 'returns a format error' do
          expect(subject.errors.messages.values.flatten).to include(
            described_class.new.errors.generate_message(:pid, :invalid_format)
          )
        end
      end
    end
  end
end
