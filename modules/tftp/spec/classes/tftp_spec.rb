require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'tftp' do

  let(:title) { 'tftp' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test standard installation' do
    it { should contain_package('tftp').with_ensure('present') }
    it { should contain_file('tftp.conf').with_ensure('present') }
  end

  describe 'Test standard installation with monitoring and firewalling' do
    let(:params) { {:monitor => true , :firewall => true, :port => '42', :protocol => 'tcp' } }

    it { should contain_package('tftp').with_ensure('present') }
    it { should contain_file('tftp.conf').with_ensure('present') }
    it 'should place a firewall rule' do
      content = catalogue.resource('firewall', 'tftp_tcp_42').send(:parameters)[:enable]
      content.should == true
    end
  end

  describe 'Test decommissioning - absent' do
    let(:params) { {:absent => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'  } }

    it 'should remove Package[tftp]' do should contain_package('tftp').with_ensure('absent') end 
    it 'should remove tftp configuration file' do should contain_file('tftp.conf').with_ensure('absent') end
    it 'should remove a firewall rule' do
      content = catalogue.resource('firewall', 'tftp_tcp_42').send(:parameters)[:enable]
      content.should == false
    end
  end

  describe 'Test decommissioning - disable' do
    let(:params) { {:disable => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp' } }

    it { should contain_package('tftp').with_ensure('present') }
    it { should contain_file('tftp.conf').with_ensure('present') }
    it 'should remove a firewall rule' do
      content = catalogue.resource('firewall', 'tftp_tcp_42').send(:parameters)[:enable]
      content.should == false
    end
  end

  describe 'Test decommissioning - disableboot' do
    let(:params) { {:disableboot => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp' } }
  
    it { should contain_package('tftp').with_ensure('present') }
    it { should contain_file('tftp.conf').with_ensure('present') }
    it 'should keep a firewall rule' do
      content = catalogue.resource('firewall', 'tftp_tcp_42').send(:parameters)[:enable]
      content.should == true
    end
  end 

  describe 'Test customizations - template' do
    let(:params) { {:template => "tftp/spec.erb" , :options => { 'opt_a' => 'value_a' } } }

    it 'should generate a valid template' do
      content = catalogue.resource('file', 'tftp.conf').send(:parameters)[:content]
      content.should match "fqdn: rspec.example42.com"
    end
    it 'should generate a template that uses custom options' do
      content = catalogue.resource('file', 'tftp.conf').send(:parameters)[:content]
      content.should match "value_a"
    end

  end

  describe 'Test customizations - custom class' do
    let(:params) { {:my_class => "tftp::spec" } }
    it 'should automatically include a custom class' do
      content = catalogue.resource('file', 'tftp.conf').send(:parameters)[:content]
      content.should match "fqdn: rspec.example42.com"
    end
  end

  describe 'Test Puppi Integration' do
    let(:params) { {:puppi => true, :puppi_helper => "myhelper"} }

    it 'should generate a puppi::ze define' do
      content = catalogue.resource('puppi::ze', 'tftp').send(:parameters)[:helper]
      content.should == "myhelper"
    end
  end

  describe 'Test Firewall Tools Integration' do
    let(:params) { {:firewall => true, :firewall_tool => "iptables" , :protocol => "tcp" , :port => "42" } }

    it 'should generate correct firewall define' do
      content = catalogue.resource('firewall', 'tftp_tcp_42').send(:parameters)[:tool]
      content.should == "iptables"
    end
  end

  describe 'Test OldGen Module Set Integration' do
    let(:params) { {:monitor => "yes" , :monitor_tool => "puppi" , :firewall => "yes" , :firewall_tool => "iptables" , :puppi => "yes" , :port => "42" , :protocol => 'tcp' } }

    it 'should generate firewall resources' do
      content = catalogue.resource('firewall', 'tftp_tcp_42').send(:parameters)[:tool]
      content.should == "iptables"
    end
    it 'should generate puppi resources ' do 
      content = catalogue.resource('puppi::ze', 'tftp').send(:parameters)[:ensure]
      content.should == "present"
    end
  end

end
