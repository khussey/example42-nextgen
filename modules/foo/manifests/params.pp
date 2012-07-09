# Class: foo::params
#
# This class defines default parameters used by the main module class foo
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to foo class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class foo::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'foo',
  }

  $service = $::operatingsystem ? {
    default => 'foo',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'foo',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'foo',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/foo',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/foo/foo.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/foo',
    default                   => '/etc/sysconfig/foo',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/foo.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/foo',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/foo',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/foo/foo.log',
  }

  $port = '42'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = 'false'
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
