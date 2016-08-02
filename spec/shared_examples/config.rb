shared_context "rsh::config" do |facts|
  it do
    is_expected.to contain_concat('/etc/hosts.equiv').with({
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0644',
    })
  end
end
