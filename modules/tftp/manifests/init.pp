# = Class: tftp
#
# This is the main tftp class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, tftp class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $tftp_myclass
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, tftp main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $tftp_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $tftp_options
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $tftp_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $tftp_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $tftp_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $tftp_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for tftp checks
#   Can be defined also by the (top scope) variables $tftp_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $tftp_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $tftp_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $tftp_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $tftp_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for tftp port(s)
#   Can be defined also by the (top scope) variables $tftp_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling tftp. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $tftp_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $tftp_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $tftp_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $tftp_audit_only
#   and $audit_only
#
# Default class params - As defined in tftp::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of tftp package
#
# [*process*]
#   The name of tftp process
#
# [*process_args*]
#   The name of tftp arguments. Used by puppi and monitor.
#   Used only in case the tftp process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user tftp runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $tftp_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $tftp_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include tftp"
# - Call tftp as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class tftp (
  $my_class            = params_lookup( 'my_class' ),
  $template            = params_lookup( 'template' ),
  $options             = params_lookup( 'options' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits tftp::params {

  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $tftp::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $tftp::bool_disableboot ? {
    true    => false,
    default => $tftp::bool_disable ? {
      true    => false,
      default => $tftp::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_file = $tftp::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $tftp::bool_absent == true or $tftp::bool_disable == true or $tftp::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $tftp::bool_absent == true or $tftp::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $tftp::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $tftp::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_content = $tftp::template ? {
    ''        => undef,
    default   => template($tftp::template),
  }

  ### We require Xinetd (also on Debian/Ubuntu)
  # require Class['xinetd']

  ### Managed resources
  package { 'tftp':
    ensure => $tftp::manage_package,
    name   => $tftp::package,
  }

  file { 'tftp.conf':
    ensure  => $tftp::manage_file,
    path    => $tftp::config_file,
    mode    => $tftp::config_file_mode,
    owner   => $tftp::config_file_owner,
    group   => $tftp::config_file_group,
    require => Package['tftp'],
    content => $tftp::manage_file_content,
    replace => $tftp::manage_file_replace,
    audit   => $tftp::manage_audit,
  }

  file { 'tftp.data':
    ensure  => directory,
    path    => $tftp::data_dir,
    mode    => '0755',
    owner   => $tftp::config_file_owner,
    group   => $tftp::config_file_group,
    require => Package['tftp'],
  }

  ### Include custom class if $my_class is set
  if $tftp::my_class {
    include $tftp::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $tftp::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'tftp':
      ensure    => $tftp::manage_file,
      variables => $classvars,
      helper    => $tftp::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $tftp::bool_monitor == true {
    monitor::port { "tftp_${tftp::protocol}_${tftp::port}":
      protocol => $tftp::protocol,
      port     => $tftp::port,
      target   => $tftp::monitor_target,
      tool     => $tftp::monitor_tool,
      enable   => $tftp::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $tftp::bool_firewall == true {
    firewall { "tftp_${tftp::protocol}_${tftp::port}":
      source      => $tftp::firewall_src,
      destination => $tftp::firewall_dst,
      protocol    => $tftp::protocol,
      port        => $tftp::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $tftp::firewall_tool,
      enable      => $tftp::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $tftp::bool_debug == true {
    file { 'debug_tftp':
      ensure  => $tftp::manage_file,
      path    => "${settings::vardir}/debug-tftp",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
