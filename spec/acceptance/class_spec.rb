require 'spec_helper_acceptance'

describe 'rsh class:' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
      class { 'rsh': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    if fact('osfamily') == 'RedHat'
      if fact('operatingsystemmajrelease') == '7'
        rsh_service = 'rsh.socket'
        rlogin_service = 'rlogin.socket'
        rexec_service = 'rexec.socket'
      end
    end

    describe package('rsh-server') do
      it { should be_installed }
    end

    describe service(rsh_service) do
      it { should be_enabled }
      it { should be_running }
    end

    describe service(rlogin_service) do
      it { should be_enabled }
      it { should be_running }
    end

    describe service(rexec_service) do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
