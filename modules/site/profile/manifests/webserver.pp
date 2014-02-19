class profile::webserver {
  include ::apache
 
  file { '/srv/sochi_api':
    ensure => 'directory',
  } ->
  file { '/srv/sochi_api/index.html':
    content => tempalte('profile/webserver/sochi_api.html'),
  } ->
  file{'/etc/httpd/conf.d/sochi_api.conf':
    content => template('profile/webserver/sochi_api.conf.erb'),
    require => Class['apache::install'],
    notify  => Class['apache::service'],
  }
} 
