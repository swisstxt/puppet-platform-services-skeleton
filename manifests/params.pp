$domain_serv    = "${::mpc_zone}.serv.${::mpc_project}.${::mpc_bu}.mpc"
$domain_stor    = "${::mpc_zone}.stor.${::mpc_project}.${::mpc_bu}.mpc"
$domain_sync    = "${::mpc_zone}.sync.${::mpc_project}.${::mpc_bu}.mpc"

$puppetmaster     = "puppet-${::mpc_zone}-01.${domain_serv}"
