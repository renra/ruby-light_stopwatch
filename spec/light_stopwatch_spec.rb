require_relative '../lib/light_stopwatch'

describe LightStopwatch do
  let(:retval) { 'foo' }

  after do
    LS.reset
  end

  describe '.get_time' do
    subject {
      LS.get_time do
        sleep(0.01)
        retval
      end
    }

    it { expect(subject[:took]).to be > 0 }
    it { expect(subject[:retval]).to eql retval }
  end

  describe '.measure' do

    subject {
      LS.measure do
        sleep(0.01)
        retval
      end
    }

    it { expect(subject).to eql retval }
  end

  describe '.agg' do
    before do
      allow(LS).to receive(:get_time).and_return(took: 1.5, retval: 'foo')

      LS.agg(:foo) {}
      LS.agg(:foo) {}
      LS.agg(:bar) {}
    end

    it {
      expect(LS.agg(:foo) { retval }).to eql retval
    }

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
