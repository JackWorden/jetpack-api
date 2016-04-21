require 'rails_helper'

describe DebtCalculator do
  let(:project) { FactoryGirl.create(Project) }
  let(:sprint) { FactoryGirl.create(Sprint, project: project) }
  let(:story) { FactoryGirl.create(Story, project: project, sprint: sprint) }
  subject { described_class.new(story) }

  describe '#calculate' do
    context 'when the story is ahead of schedule' do
      before do
        allow(story).to receive(:completed_points) { 6 }
        allow(subject).to receive(:expected_points) { 5 }
      end

      it 'should return 0' do
        expect(subject.calculate).to eq 0
      end
    end

    context 'when the story is behind schedule' do
      before do
        allow(story).to receive(:completed_points) { 1 }
        allow(subject).to receive(:expected_points) { 5 }
      end

      it 'should return the difference between the number of completed and expected points' do
        expect(subject.calculate).to eq 4
      end
    end
  end

  describe '#expected_points' do
    before do
      allow(story).to receive(:total_points) { 10 }
      allow(sprint).to receive(:duration) { 10 }
      allow(subject).to receive(:days_passed) { 5 }
    end

    it 'should return the number of points the story should have completed by the current date' do
      expect(subject.expected_points).to eq 5
    end

    context 'when the expected points are a decimal' do
      before do
        allow(story).to receive(:total_points) { 12 }
        allow(sprint).to receive(:duration) { 10 }
        allow(subject).to receive(:days_passed) { 1 }
      end

      it 'should round to the nearest integer' do
        expect(subject.expected_points).to eq 1
      end
    end
  end
end
