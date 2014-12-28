describe Pumper::Specification do
  let(:gemspec) { File.expand_path('../../../fixtures/simple_gem.gemspec', __FILE__) }

  subject { described_class.new(gemspec) }

  its(:name) { is_expected.to eq('simple_gem') }
  its(:version) { is_expected.to eq('1.2.3') }
  its(:for_gemfile) { is_expected.to eq("gem 'simple_gem', '~> 1.2.3'") }
  its(:gem_file_name) { is_expected.to eq('simple_gem-1.2.3.gem') }
end