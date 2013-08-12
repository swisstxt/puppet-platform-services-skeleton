require 'yaml'

desc 'initial deployment ot the puppetmaster from local clone'
task :deploy, [:api_key, :secret_key, :puppet_repo, :hiera_repo] => [
  'puppetmaster:bootstrap',
  'puppetmaster:deploy_skeleton',
  'puppetmaster:update_skeleton',
  'puppetmaster:configure',
  'puppetmaster:run'
] do |t, args|
end



namespace 'puppetmaster' do

  desc 'bootstrap a puppetmaster from the local clone'
  task :bootstrap => [:update_platform_services, :apply] do
  end

  desc 'bootstrap a puppetmaster from the local clone via puppet apply'
  task :apply do
    puppet_includes =  [
      'platform_services_puppet::master',
    ]

    puppet_manifest = './manifests/site.pp'
    puppet_modules = './modules/swisstxt/'

    sh "echo \"include #{puppet_includes.join(', ')}\" | puppet apply #{puppet_manifest} --modulepath #{puppet_modules}"
  end

  desc 'update platform_services to latest stable version'
  task :update_platform_services do
    sh 'git submodule update --init --recursive'
    Dir.chdir('/etc/puppet/environments/production/modules/swisstxt') do
      sh 'git checkout `git describe --abbrev=0 --tags`'
      sh 'git submodule update --init'
    end
  end

  desc 'deploy the swisstxt skeleton or a specified repository'
  task :deploy_skeleton, [:puppet_repo, :hiera_repo] do |t, args|
    args.with_defaults(
      :puppet_repo => 'https://bitbucket.org/swisstxt/puppet-platform-services-skeleton.git',
      :hiera_repo  => 'https://bitbucket.org/swisstxt/platform-services-hiera-skeleton.git'  
    )
      
    puppet_repo = args[:puppet_repo]
    hiera_repo  = args[:hiera_repo]
  
    sh "git clone #{puppet_repo} /etc/puppet/environments/production"
    sh "git clone #{hiera_repo} /etc/puppet/hieradata"
    sh 'ln -s /etc/puppet/environments/production /etc/puppet/environments/development'
  end

  desc 'update the skeleton and it\'s submodules'
  task :update_skeleton do
    Dir.chdir('/etc/puppet/environments/production') do
      sh 'git submodule update --init --recursive'
    end
  end

  desc 'configure the skeleton in order for the puppetmaster to work'
  task :configure, [:api_key, :secret_key] do |t, args|
    args.with_defaults(:api_key => 'XXXXX', :secret_key => 'XXXXX')

    hiera_conf = '/etc/puppet/hieradata/global.yaml'

    global_conf = YAML.load_file(hiera_conf)
    puts global_conf

    global_conf['cloudstack_api_key']          = args.api_key
    global_conf['cloudstack_secret_key']       = args.secret_key
   
    File.open(hiera_conf, 'w+') do |f|
      f.write(global_conf.to_yaml)
    end
  end

  desc 'perform a full puppet run'
  task :run do
    sh 'puppet agent --test'
  end

end

