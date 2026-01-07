require 'rails_helper'

RSpec.describe Kudo do
  describe '.create' do
    it 'creates a kudo from sender to receiver' do
      kudo = Kudo.create(sender: 'Mihle', receiver: 'Sam', message: 'Great job!')
      
      expect(kudo.sender).to eq('Mihle')
      expect(kudo.receiver).to eq('Sam')
      expect(kudo.message).to eq('Great job!')
    end
  end
end
