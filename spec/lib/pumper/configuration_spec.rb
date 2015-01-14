describe Pumper::Configuration do
  let(:options) { Hash.new }

  subject { described_class.configure!(options) }

  context 'when raise error ProjectNotSet' do
    it { expect { subject }.to raise_error(Pumper::Configuration::ProjectNotSet) }
    it { expect { subject }.to raise_exception('You need set project (--project <PATH_TO_PROJECT>) or use config') }
  end

  context 'when valid project' do
    let(:options) { { project: 'cashier' } }

    it { is_expected.to eq(options) }
  end

  context 'when raise error InvalidOptions' do
    let(:options) { { project: 'cashier', config: true, gemset: 'ruby-2.1.0' } }

    it { expect { subject }.to raise_error(Pumper::Configuration::InvalidOptions) }
  end
end