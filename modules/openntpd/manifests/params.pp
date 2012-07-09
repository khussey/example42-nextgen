# Class: openntpd::params
#
# This class defines default parameters used by the main module class openntpd
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to openntpd class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class openntpd::params {

  ### Class specific variables

  # Template for init file
  $file_init_content = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'openntpd/openntpd_initd-redhat.erb',
    default                                => 'openntpd/openntpd_initd-debian.erb',
  }

  # Ntp servers to use
  $server = [ '0.pool.ntp.org' , '1.pool.ntp.org' ]

  # If local host must be an ntp server
  $server_local = false

  # Set the time immediately at startup if the local clock is off
  # by more than 180 seconds (option -s).
  $force_startup_sync = true


  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'openntpd',
  }

  $service = $::operatingsystem ? {
    default => 'openntpd',
  }

  $service_status = $::operatingsystem ? {
    default => false,
  }

  $process = $::operatingsystem ? {
    default => 'ntpd',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'openntpd',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/openntpd',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/openntpd/ntpd.conf',
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
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/openntpd',
    default                   => '/etc/sysconfig/openntpd',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/openntpd.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '',
  }

  $log_dir = $::operatingsystem ? {
    default => '',
  }

  $log_file = $::operatingsystem ? {
    default => '',
  }

  $port = '123'
  $protocol = 'udp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = ''
  $template = 'openntpd/ntpd.conf.erb'
  $options = ''
  $service_autorestart = true
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
