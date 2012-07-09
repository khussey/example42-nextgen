# Define: openvpn::tunnel
#
# Manages openvpn tunnels creating an openvpn .conf file
#
# Parameters:
#
# [*mode*]
#   Sets general openvpn mode: client or server. Default: server
#
# [*remote*]
#   Sets remote host/IP. Needed in client mode. Default blank
#
# [*port*]
#   Default is 1194, change with multiple tunnels
#
# [*proto*]
#   Transport protocol: tcp or udp. Default: udp
#
# [*auth_type*]
#   Authentication method: key, tls-server, tls-client
#
# [*auth_key*]
#   Source of the key file (Used when auth_type = key)
#   Used as: source => $auth_key
#   So it should be something like:
#   puppet:///modules/example42/openvpn/mykey
#   Can be also an array
#
# [*dev*]
#   Device: tun for Ip routing , tap for bridging mode
#   Default: tun
#
# [*server*]
#   Server parameter. (in server mode)
#
# [*route*]
#   Route parameter
#
# [*push*]
#   Push parameter
#
# [*template*]
#   Template to be used for the tunnel configuration.
#   Default is openvpn/tunnel.conf.erb
#   File: openvpn/templates/tunnel.conf.erb
#
# [*enable*]
#   If the tunnel is enabled or not.
#
define openvpn::tunnel (
  $auth_type    = 'tls-server',
  $mode         = 'server',
  $remote       = '',
  $port         = '1194',
  $auth_key     = '',
  $proto        = 'tcp',
  $dev          = 'tun',
  $server       = '10.8.0.0 255.255.255.0',
  $route        = '',
  $push         = '',
  $template     = '',
  $enable       = true ) {

  include openvpn

  $bool_enable=any2bool($enable)

  $manage_file = $bool_enable ? {
    true    => 'present',
    default => 'absent',
  }

  $real_proto = $proto ? {
    udp => 'udp',
    tcp => $mode ? {
      'server' => 'tcp-server',
      'client' => 'tcp-client',
    },
  }

  $real_template = $template ? {
    ''      => $mode ? {
      'server' => 'openvpn/server.conf.erb',
      'client' => 'openvpn/client.conf.erb',
    },
    default => $template,
  }

  file { "openvpn_${name}.conf":
    ensure  => $manage_file,
    path    => "${openvpn::config_dir}/${name}.conf",
    mode    => $openvpn::config_file_mode,
    owner   => $openvpn::config_file_owner,
    group   => $openvpn::config_file_group,
    require => Package['openvpn'],
    notify  => Service['openvpn'],
    content => template($real_template),
  }

  if $auth_key != '' {
    file { "openvpn_${name}.key":
      ensure  => $manage_file,
      path    => "${openvpn::config_dir}/${name}.key",
      mode    => '0600',
      owner   => $openvpn::process_user,
      group   => $openvpn::process_user,
      require => Package['openvpn'],
      notify  => Service['openvpn'],
      source  => $auth_key,
    }
  }

# Automatic monitoring of port and service
  if $openvpn::bool_monitor == true {

    $target = $remote ? {
      ''      => $openvpn::monitor_target,
      default => $remote,
    }

    monitor::port { "openvpn_${name}_${proto}_${port}":
      enable   => $bool_enable,
      protocol => $proto,
      port     => $port,
      target   => $target,
      tool     => $openvpn::monitor_tool,
    }
    monitor::process { "openvpn_${name}_process":
      enable   => $bool_enable,
      process  => $openvpn::process,
      service  => $openvpn::service,
      pidfile  => "${openvpn::pid_file}/${name}.pid",
      user     => $openvpn::process_user,
      argument => "${name}.conf",
      tool     => $openvpn::monitor_tool,
    }
  }

# Automatic Firewalling
  if $openvpn::bool_firewall == true {
    firewall { "openvpn_${name}_${proto}_${port}":
      source      => $openvpn::firewall_source_real,
      destination => $openvpn::firewall_destination_real,
      protocol    => $proto,
      port        => $port,
      action      => 'allow',
      direction   => 'input',
      enable      => $bool_enable,
    }
  }

}
