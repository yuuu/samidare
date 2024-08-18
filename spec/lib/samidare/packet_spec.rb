# frozen_string_literal: true

require_relative '../../../lib/samidare/packet'

RSpec.describe Samidare::Packet do
  describe '#initialize' do
    context 'when CONNECT packet' do
      let(:binary) { "\x10\x0C\x00\x04MQTT\x04\x02\x00\x3C\x00\x00" }

      it 'parses Header Frags' do
        packet = Samidare::Packet.new(binary)
        expect(packet.type).to eq Samidare::Packet::CONNECT
        expect(packet.flags).to eq 0
        expect(packet.len).to eq 0x0C
      end
    end
  end
end
