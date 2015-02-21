require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#admin?' do
    subject { user.admin? }

    context 'when user is a normal user' do
      let(:user) { User.new(role: 'user') }

      it { is_expected.to eq(false) }
    end

    context 'when user is an admin' do
      let(:user) { User.new(role: 'admin') }

      it { is_expected.to eq(true) }
    end
  end
end
