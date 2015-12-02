require_relative '../lib/light_stopwatch'

describe LightStopwatch do
  after do
    LS.reset
  end

  describe '.get_time' do
    subject { LS.get_time { sleep(0.01) } }

    it { expect(subject).to be > 0 }
  end

  describe '.measure' do
    subject { LS.measure { sleep(0.01) } }

    # Returns nothing
    it { expect(subject).to eql nil }
  end

  describe '.agg, .get_aggs, .get_agg, .get_agg_value, .get_agg_count' do
    before do
      allow(LS).to receive(:get_time).and_return(1.5)

      LS.agg(:foo) {}
      LS.agg(:foo) {}
      LS.agg(:bar) {}
    end

    describe '.get_aggs' do
      subject { LS.get_aggs }

      it {
        expect(subject).to eq(
          foo: {value: 3.0, count: 2},
          bar: { value: 1.5, count: 1 }
        )
      }
    end

    describe '.get_agg' do
      subject { LS.get_agg(:foo) }

      it { expect(subject).to eq(value: 3.0, count: 2) }
    end

    describe '.get_agg_value' do
      subject { LS.get_agg_value(:foo) }

      it { expect(subject).to eql 3.0 }
    end

    describe '.get_agg_count' do
      subject { LS.get_agg_count(:foo) }

      it { expect(subject).to eql 2 }
    end
  end
end
