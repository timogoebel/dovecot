class dovecot::config::augeas {
  file { "/usr/share/augeas/lenses/dist/dovecot.aug":
    ensure => present,
    source => 'puppet:///modules/dovecot/dovecot.aug',
  }

  file { "/usr/share/augeas/lenses/dist/build.aug":
    ensure => present,
    source => 'puppet:///modules/dovecot/build.aug',
  }

  file { "/usr/share/augeas/lenses/dist/util.aug":
    ensure => present,
    source => 'puppet:///modules/dovecot/util.aug',
  }
}