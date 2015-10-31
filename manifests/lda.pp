# 15-lda.conf
class dovecot::lda (
  $postmaster_address = "root@${::fqdn}",
  $mail_plugins       = '$mail_plugins',
) {
  include dovecot

  dovecot::config::dovecotcfmulti { 'lda':
    config_file => 'conf.d/15-lda.conf',
    changes     => [
      "set postmaster_address '${postmaster_address}'",
      "set protocol[ . = 'lda']/mail_plugins \"${mail_plugins}\"",
    ],
  }
}
