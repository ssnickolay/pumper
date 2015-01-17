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

  context 'when --config' do
    let(:options) { { config: true } }
    before do
      pwd = Dir.pwd
      allow(Dir).to receive(:pwd) { "#{ pwd }/spec/fixtures" }
    end

    it 'should parse yml' do
      is_expected.to eq([
        {
          project: '/Users/admin/Projects/my_app',
          is_absolute_path: true,
          gemset: 'ruby-1.9.3@my_app',
          is_vendor: true
        },
        {
          project: '/Users/admin/Projects/my_app2',
          is_absolute_path: true,
          gemset: 'ruby-2.1.0@my_app2',
          is_vendor: nil
        }
      ])
    end
  end
end