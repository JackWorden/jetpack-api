require 'rails_helper'

describe Issue do
  let(:attributes) { {} }
  subject { FactoryGirl.build_stubbed(Issue, attributes) }

  describe 'validations' do
    context 'when an issue has no points' do
      let(:attributes) { { points: nil } }
      it { should be_invalid }
    end

    context "when an issue's points are < 1" do
      let(:attributes) { { points: 0 } }
      it { should be_invalid }
    end

    context 'when the points attribute is left blank' do
      let(:attributes) { {} }

      it 'should default to 1 point' do
        expect(subject.points).to eq 1
      end
    end
  end
end
