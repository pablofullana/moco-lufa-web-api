FactoryBot.define do
  factory :firmware do
    sequence(:name) { |i| "firmware##{i}" }
    sequence(:manufacturer) { |i| "manufacturer##{i}" }
    arduino_model { 'uno' }
    pid { "0x#{rand(0x1000..0xffff).to_s(16)}" }
  end
end
