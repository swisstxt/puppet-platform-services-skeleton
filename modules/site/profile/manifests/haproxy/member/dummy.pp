class profile::haproxy::member::dummy(
  $front_ip,
  $options = 'check',
) {
  platform_services_haproxy::member { $::fqdn:
    service  => 'dummy',
    ports    => [ 80, 8080 ]
    front_ip => $front_ip,
    options  => $options,
  }
}
