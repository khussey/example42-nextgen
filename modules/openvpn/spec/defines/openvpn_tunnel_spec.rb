require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'openvpn::tunnel' do

  let(:title) { 'openvpn::tunnel' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :arch => 'i386' } }
  let(:params) {
    { 'enable'    => 'true',
      'name'      => 'mytunnel',
      'auth_type' => 'key',
      'remote'    => '1.1.1.1',
      'port'      => '1150',
      'auth_key'  => 'mykey',
    }
  }

  describe 'Test configuration file creation' do
    it 'should create a openvpn::tunnel configuration file' do
      should contain_file('openvpn_mytunnel.conf').with_ensure('present')
    end
    it 'should populate correctly the openvpn::tunnel configuration file' do
      content = catalogue.resource('file', 'openvpn_mytunnel.conf').send(:parameters)[:content]
      content.should match "secret /etc/openvpn/mytunnel.key "
    end
    it 'should create a key file when auth_key is provided' do
      content = catalogue.resource('file', 'openvpn_mytunnel.key').send(:parameters)[:source]
      content.should match "mykey"
    end
  end

  describe 'Test Monitoring Tools Integration' do
    let(:facts) { {:monitor => true, :monitor_tool => "puppi", :monitor_target => "2.2.2.2" } }

    it 'should generate monitor defines' do
      content = catalogue.resource('monitor::process', 'openvpn_mytunnel_process').send(:parameters)[:tool]
      content.should == "puppi"
    end
  end

  describe 'Test Firewall Tools Integration' do
    let(:facts) { {:firewall => true, :firewall_tool => "iptables" } }

    it 'should generate correct firewall define' do
      content = catalogue.resource('firewall', 'openvpn_mytunnel_tcp_1150').send(:parameters)[:tool]
      content.should == "iptables"
    end
  end

end
