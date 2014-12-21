require 'ostruct'
describe Bumper::ProjectGemfile do
  let(:project) { File.expand_path('../../../fixtures', __FILE__) }
  let(:is_absolute_path) { true }
  let(:project_gemfile) { described_class.new(project, is_absolute_path) }

  before do
    File.open(project_gemfile.send(:gemfile), 'w') { |f| f.write("gem 'simple_gem'") }
  end

  describe 'bump_version!' do
    subject { File.read("#{ project }/Gemfile") }

    let(:specification) do
      OpenStruct.new(
        name: 'simple_gem',
        for_gemfile: "gem 'simple_gem', '~> 1.1.0'"
      )
    end
    let(:bump_version) { project_gemfile.bump_version!(specification) }

    it { should_not be_include(specification.for_gemfile) }

    context 'when everything is good :)' do
      before { bump_version }

      it { should be_include(specification.for_gemfile) }
    end

    context 'when Gemfile have not bumped gem' do
      before do
        File.open(project_gemfile.send(:gemfile), 'w') { |f| f.write('') }
      end

      it { expect { bump_version }.to raise_error(Bumper::ProjectGemfile::UndefinedGem)  }
    end
  end
end