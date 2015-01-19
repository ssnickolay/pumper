describe Pumper::Specification do
  subject { described_class.new }

  before do
    currrent_path = Dir.pwd
    allow(Dir).to receive_messages(pwd: "#{ currrent_path }/spec/fixtures")
  end

  its(:name) { is_expected.to eq('simple_gem') }
  its(:version) { is_expected.to eq('1.2.3') }
  its(:for_gemfile) { is_expected.to eq("gem 'simple_gem', '~> 1.2.3'") }
  its(:gem_file_name) { is_expected.to eq('simple_gem-1.2.3.gem') }
end