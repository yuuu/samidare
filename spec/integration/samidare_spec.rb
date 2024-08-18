# frozen_string_literal: true

require 'mqtt'

RSpec.describe Samidare do
  let(:host) { 'localhost' }
  let(:port) { 1883 }
  let(:test_topic) { 'test-topic' }
  let(:test_message) { '{ "message": "hello world!" }' }

  it 'is possible to subscribe to messages published by mqtt' do
    threads = []
    queue = Queue.new

    threads << Thread.new do
      queue.pop
      publisher = MQTT::Client.connect(host:, port:)
      publisher.publish(test_topic, test_message)
      publisher.disconnect
    end

    threads << Thread.new do
      subscriber = MQTT::Client.connect(host:, port:)
      subscriber.subscribe(test_topic)
      queue.push('')
      topic, message = subscriber.get
      expect(message).to eq(test_message)
      expect(topic).to eq(test_topic)
      subscriber.disconnect
    end

    threads.each(&:join)
  end
end
