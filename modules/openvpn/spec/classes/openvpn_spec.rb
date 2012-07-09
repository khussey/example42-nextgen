require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'openvpn' do

  let(:title) { 'openvpn' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test standard installation' do
    it { should contain_package('openvpn').with_ensure('present') }
    it { should contain_service('openvpn').with_ensure('running') }
    it { should contain_service('openvpn').with_enable('true') }
  end

  describe 'Test installation of a specific version' do
    let(:params) { {:version => '1.0.42' } }
    it { should contain_package('openvpn').with_ensure('1.0.42') }
  end

  describe 'Test decommissioning - absent' do
    let(:params) { {:absent => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }

    it 'should remove Package[openvpn]' do should contain_package('openvpn').with_ensure('absent') end 
    it 'should stop Service[openvpn]' do should contain_service('openvpn').with_ensure('stopped') end
    it 'should not enable at boot Service[openvpn]' do should contain_service('openvpn').with_enable('false') end
  end

  describe 'Test decommissioning - disable' do
    let(:params) { {:disable => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }

    it { should contain_package('openvpn').with_ensure('present') }
    it 'should stop Service[openvpn]' do should contain_service('openvpn').with_ensure('stopped') end
    it 'should not enable at boot Service[openvpn]' do should contain_service('openvpn').with_enable('false') end
  end

  describe 'Test decommissioning - disableboot' do
    let(:params) { {:disableboot => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }
  
    it { should contain_package('openvpn').with_ensure('present') }
    it { should_not contain_service('openvpn').with_ensure('present') }
    it { should_not contain_service('openvpn').with_ensure('absent') }
    it 'should not enable at boot Service[openvpn]' do should contain_service('openvpn').with_enable('false') end
  end 

  describe 'Test customizations - template' do
    let(:params) { {:template => "openvpn/spec.erb" , :options => { 'opt_a' => 'value_a' } } }

    it 'should generate a valid template' do
      content = catalogue.resource('file', 'openvpn.conf').send(:parameters)[:content]
      content.should match "fqdn: rspec.example42.com"
    end
    it 'should generate a template that uses custom options' do
      content = catalogue.resource('file', 'openvpn.conf').send(:parameters)[:content]
      content.should match "value_a"
    end

  end

  describe 'Test customizations - source' do
    let(:params) { {:source => "puppet://modules/openvpn/spec" , :source_dir => "puppet://modules/openvpn/dir/spec" , :source_dir_purge => true } }

    it 'should request a valid source ' do
      content = catalogue.resource('file', 'openvpn.conf').send(:parameters)[:source]
      content.should == "puppet://modules/openvpn/spec"
    end
    it 'should request a valid source dir' do
      content = catalogue.resource('file', 'openvpn.dir').send(:parameters)[:source]
      content.should == "puppet://modules/openvpn/dir/spec"
    end
    it 'should purge source dir if source_dir_purge is true' do
      content = catalogue.resource('file', 'openvpn.dir').send(:parameters)[:purge]
      content.should == true
    end
  end

  describe 'Test service autorestart', :broken => true do
    it 'should automatically restart the service, by default' do
      content = catalogue.resource('file', 'openvpn.conf').send(:parameters)[:notify]
      content.should == 'Service[openvpn]{:name=>"openvpn"}'
    end
  end

  describe 'Test service autorestart' do
    let(:params) { {:service_autorestart => "no" , :source => 'real' } }

    it 'should not automatically restart the service, when service_autorestart => false' do
      content = catalogue.resource('file', 'openvpn.conf').send(:parameters)[:notify]
      content.should be_nil
    end
  end

  describe 'Test Puppi Integration' do
    let(:params) { {:puppi => true, :puppi_helper => "myhelper"} }

    it 'should generate a puppi::ze define' do
      content = catalogue.resource('puppi::ze', 'openvpn').send(:parameters)[:helper]
      content.should == "myhelper"
    end
  end

end

