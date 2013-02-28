# include disable class for supplied modules
define disabled::module() {
  include "${name}::disable"
}

# disable service without using a module
define disabled::service() {
  service{$name:
    ensure => stopped,
  }
}
