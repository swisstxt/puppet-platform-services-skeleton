GIT_REPO='https://bitbucket.org/swisstxt/puppet-platform-services-skeleton.git'


task :puppetmaster do
  puppet_includes =  [
    'platform_services',
    'platform_services_puppet::master',
    'platform_services_yum::repo::platform_services::server',
    'platform_services_cloudstack::controller',
    'platform_services::base'
  ]
  puppet_manifest = './manifests/site.pp'
  puppet_modules = './modules/swisstxt/'

  sh 'git submodule update --init --recursive'
  sh "echo \"include #{puppet_includes.join(', ')}\" | puppet apply #{puppet_manifest} --modulepath #{puppet_modules}"
  sh "git clone #{GIT_REPO} /etc/puppet/environments/production"
  sh 'cd /etc/puppet/environments/production'
  sh 'git submodule update --init --recursive'
  sh 'ln -s /etc/puppet/environments/production /etc/puppet/environments/development'

end
