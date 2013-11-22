class profile::haprox::dummy {
  platform_services_haproxy::service{'dummy-www':
    ipaddress       => '127.0.0.1',
    ports           => [80, 443],
    options         => {
      'balance' => [
        'uri',
      ],
      'mode' => [
        'http',
      ],
    },
  }
}
