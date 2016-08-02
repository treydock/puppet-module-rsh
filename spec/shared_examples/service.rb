shared_context "rsh::service" do |facts|
  case facts[:osfamily]
  when 'RedHat'
    case facts[:operatingsystemmajrelease]
    when '7'
      it do
        is_expected.to contain_service('rsh').with({
          :ensure => 'running',
          :enable => 'true',
          :name   => 'rsh.socket',
        })
      end
      it do
        is_expected.to contain_service('rlogin').with({
          :ensure => 'running',
          :enable => 'true',
          :name   => 'rlogin.socket',
        })
      end
      it do
        is_expected.to contain_service('rexec').with({
          :ensure => 'running',
          :enable => 'true',
          :name   => 'rexec.socket',
        })
      end
    end
  end
end
