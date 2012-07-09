# Class: libvirt::params
#
# This class defines default parameters used by the main module class libvirt
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to libvirt class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class libvirt::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'libvirt',
  }

  $service = $::operatingsystem ? {
    default => 'libvirtd',
  }

  $service_guests = $::operatingsystem ? {
    default => 'libvirt-guests',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'libvirtd',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'root',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/libvirt',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/libvirt/libvirtd.conf',
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
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/libvirt',
    default                   => '/etc/sysconfig/libvirt',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/libvirt/network/default.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/var/lib/libvirt',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/libvirt',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/libvirt/libvirtd.log',
  }

  $port = '5900'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = 'false'
  $template = ''
  $options = ''
  $service_autorestart = false
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = 'localhost'
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
