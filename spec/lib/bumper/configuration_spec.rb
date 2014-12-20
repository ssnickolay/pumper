describe Bumper::Configuration do
  let(:options) { Hash.new }

  subject { described_class.configure!(options) }

  context 'when raise error ProjectNotSet' do
    it { expect { subject }.to raise_error(Bumper::Configuration::ProjectNotSet) }
  end

  context 'when valid project' do
    let(:options) { { project: 'cashier' } }

    it { should eq options }
  end
end