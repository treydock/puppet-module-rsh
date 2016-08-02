shared_context "rsh::install" do |facts|
  it do
    is_expected.to contain_package('rsh-server').only_with({
      :ensure => 'present',
      :name   => 'rsh-server',
    })
  end
end
