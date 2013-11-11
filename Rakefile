require 'yaml'

desc 'initial deployment ot the puppetmaster from local clone'
task :deploy, [:api_key, :secret_key, :puppet_repo, :hiera_repo] => [
  'puppetmaster:bootstrap',
  'puppetmaster:deploy_skeleton',
  'puppetmaster:update_skeleton',
] do |t, args|
end

namespace 'puppetmaster' do
  desc 'bootstrap a puppetmaster from the local clone'
  task :bootstrap do
    sh 'git submodule update --init --recursive'
    Dir.chdir('modules/swisstxt') do
      sh 'git submodule update --init'
    end
    sh "echo include platform_services_puppet::master | puppet apply manifests/site.pp --modulepath modules/swisstxt/"
  end

  desc 'deploy the swisstxt skeleton or a specified repository'
  task :deploy_skeleton do 
    puppet_repo = ENV.has_key?('puppet_repo') ? ENV['puppet_repo'] : '-b $(git rev-parse --abbrev-ref HEAD) https://bitbucket.org/swisstxt/puppet-platform-services-skeleton.git'
    hiera_repo = ENV.has_key?('hiera_repo') ? ENV['hiera_repo'] : 'https://bitbucket.org/swisstxt/platform-services-hiera-skeleton.git'
  
    sh "test -e /etc/puppet/environments/production || git clone #{puppet_repo} /etc/puppet/environments/production"
    sh "test -e /etc/puppet/hieradata || git clone #{hiera_repo} /etc/puppet/hieradata"
  end

  desc 'update the skeleton and it\'s submodules'
  task :update_skeleton do
    Dir.chdir('/etc/puppet/environments/production') do
      sh 'git submodule update --init --recursive'
    end
    Dir.chdir('/etc/puppet/environments/production/modules/swisstxt') do
     sh 'git submodule update --init'
    end
    print "Now it is time to configure hiera before running 'rake puppetmaster:run'\n"
  end

  desc 'perform a full puppet run'
  task :run do
    sh 'puppet agent --test --server $(hostname -f)'
  end
end
