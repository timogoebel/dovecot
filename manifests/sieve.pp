# 90-plugin.conf *or*
# 90-sieve.conf
class dovecot::sieve (
  $username  = 'vmail',
  $groupname = 'vmail',
  $sieve = '~/.dovecot.sieve',
  $sieve_dir = '~/sieve',
  $sieve_global_path = '/var/lib/dovecot/sieve/default.sieve',
  $sieve_global_dir = '/var/lib/dovecot/sieve/',
  ) {
  include dovecot

  file { '/var/lib/dovecot/sieve':
    ensure  => directory,
    owner   => $username,
    group   => $groupname,
    mode    => '0755',
    require => Package['dovecot-sieve'],
  }

  $package_name = $::osfamily ? {
    'Debian' => 'dovecot-sieve',
    'Redhat' => 'dovecot-pigeonhole',
    default  => 'dovecot-sieve',
  }
  $mailpackages = $::osfamily ? {
    default  => ['dovecot-imapd', 'dovecot-pop3d'],
    'Debian' => ['dovecot-imapd', 'dovecot-pop3d'],
    'Redhat' => ['dovecot',]
  }

  package { $package_name :
      ensure  => installed,
      before  => Exec['dovecot'],
      require => Package[$mailpackages],
      alias   => 'dovecot-sieve',
  }

  dovecot::config::dovecotcfmulti { 'plugin':
    config_file => 'conf.d/90-plugin.conf',
    changes     => [
      "set plugin/sieve '${sieve}'",
      "set plugin/sieve_dir '${sieve_dir}'",
      "set plugin/sieve_global_path '${sieve_global_path}'",
      "set plugin/sieve_global_dir '${sieve_global_dir}'",
      ],
  }
}
