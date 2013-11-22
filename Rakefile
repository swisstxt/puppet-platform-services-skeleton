require 'yaml'

REMOTE_PLATFORM_SERVICES = 'https://bitbucket.org/swisstxt/puppet-platform-services.git'
REMOTE_SKELETON = 'https://bitbucket.org/swisstxt/puppet-platform-services-skeleton.git'
REMOTE_HIERA_SKELETON = 'https://bitbucket.org/swisstxt/puppet-platform-services-hiera-skeleton.git'

LOCAL_SKELETON = '/etc/puppet/environments/production'
LOCAL_HIERA_SKELETON = '/etc/puppet/hieradata'

unless ENV.has_key?('commit')
  ENV['commit'] = `git ls-remote --tags #{REMOTE_PLATFORM_SERVICES} | grep 'tags/v' | cut -f 2 | sort -rV | head -1`
end

desc 'initial deployment ot the puppetmaster from local clone'
task :deploy => [
  'puppetmaster:bootstrap',
  'puppetmaster:deploy_skeletons',
  'puppetmaster:upgrade',
] do |t, args|
end

namespace 'puppetmaster' do
  desc 'bootstrap a puppetmaster from the local clone'
  task :bootstrap do
    sh 'git submodule update --init'
    Dir.chdir 'modules/swisstxt' do
      sh "git checkout #{ENV['commit']}"
      sh 'git reset --hard'
      sh 'git clean -f -d'
      sh 'git submodule sync'
      sh 'git submodule update --init'
    end
    sh 'echo include platform_services_puppet::master | puppet apply manifests/site.pp --modulepath modules/swisstxt'
  end

  desc 'deploy the platform-services and hieradata skeletons'
  task :deploy_skeletons do
    unless File.exists? LOCAL_SKELETON
      sh "git clone #{REMOTE_SKELETON} #{LOCAL_SKELETON}"
    end
    unless File.exists? LOCAL_HIERA_SKELETON
      sh "git clone #{REMOTE_HIERA_SKELETON} #{LOCAL_HIERA_SKELETON}"
    end
  end

  desc 'update platform-services'
  task :upgrade do
    Dir.chdir File.join(LOCAL_SKELETON, 'modules/swisstxt') do
      sh "git checkout #{ENV['commit']}"
      sh 'git reset --hard'
      sh 'git clean -f -d'
      sh 'git submodule sync'
      sh 'git submodule update --init'
    end
  end

  desc 'perform a full puppet run'
  task :run do
    sh 'puppet agent --test --server $(hostname -f)'
  end
end
