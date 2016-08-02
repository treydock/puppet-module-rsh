require 'spec_helper'

describe 'rsh' do
  on_supported_os({
    :supported_os => [
      {
        "operatingsystem" => "RedHat",
        "operatingsystemrelease" => ["6", "7"],
      }
    ]
  }).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/dne',
        })
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to create_class('rsh') }
      it { is_expected.to contain_class('rsh::params') }

      it { is_expected.to contain_class('rsh::install').that_comes_before('Class[rsh::config]') }
      it { is_expected.to contain_class('rsh::config').that_comes_before('Class[rsh::service]') }
      it { is_expected.to contain_class('rsh::service') }

      include_context 'rsh::install', facts
      include_context 'rsh::config', facts
      include_context 'rsh::service', facts

      # Test validate_bool parameters
      [

      ].each do |param|
        context "with #{param} => 'foo'" do
          let(:params) {{ param.to_sym => 'foo' }}
          it 'should raise an error' do
            expect { is_expected.to compile }.to raise_error(/is not a boolean/)
          end
        end
      end

    end # end context
  end # end on_supported_os loop
end # end describe
