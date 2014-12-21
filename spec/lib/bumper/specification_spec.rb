describe Bumper::Specification do
  let(:gemspec) { File.expand_path('../../../fixtures/simple_gem.gemspec', __FILE__) }

  subject { described_class.new(gemspec) }

  its(:name) { is_expected.to eq('simple_gem') }
  its('version.to_s') { is_expected.to eq('1.2.3') }
end