module StaticHelper
  def application_server_setup
    {
      'avr-gcc': `avr-gcc --version`.split("\n").first,
      'avrdude': ENV['AVRDUDE_VERSION'],
      'LUFA': ENV['LUFA_VERSION'],
      'dualMocoLUFA': ENV['DUALMOCOLUFA_VERSION']
    }
  end

  def application_stats
    Firmware.compilation_results.reduce({}) { |acc, (k, _v)| acc.merge!({ k => Firmware.send(k).count }) }
  end
end
