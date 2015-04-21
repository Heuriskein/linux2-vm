require_relative '../spec_helper'

rmills_data = {
  "id" => "rmills",
  "shell" => "/bin/bash",
  "comment" => "Ryan Mills",
  "desktop-autologin" => "true",
  "disable-screensaver" => "true",
  "dotfiles-repo" => "https://github.com/Heuriskein/dotfiles",
  "groups" => ["sysadmin"],
   "ssh_keys" => [
     "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIpCwf716VX8Lp2KRgcHALD3l9zv+yC3iVgvVy5p0WOPRze7Prb+yoXev9CywfNkcecTIgJldI3vhB6NHADOWNMUiO4aCKaels2CAuc7Y+n+IkC/Lez5tz8WBG0s6tbP4FqZf0nPM7Wu6/1HYCvJ7ouAlxP7Gtr69tLr7ETWwmdURW6IrdNkMwxi/9JWrmQIsY91bLH6AAvVZXQF+OXzRmekzD9lJoLGDL3gsf2TIqqo1pft9PhdeogE0MTE6+NvA7vSMSxi4XWYyGQaRfCYDXXucwKUK7hLStEnP/JgQCnYOf/eT7Xm3WAz82n4yX0HBYYVdNZUNiCcJ/VaVjTwXj hrakarth@bitbucket.org"
   ],
}

describe 'linux-vm::desktop' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node, server|
      server.create_data_bag('users', {'rmills' => rmills_data})
    end.converge(described_recipe)
  end

  it 'installs packages' do
    expect(chef_run).to install_package('openjdk-7-jre')
    expect(chef_run).to install_package('openjdk-7-jdk')
    expect(chef_run).to install_package('firefox')
    expect(chef_run).to install_package('xsel')
    expect(chef_run).to install_package('git')
    expect(chef_run).to install_package('wget')
  end

  it 'installs idea' do
    expect(chef_run).to include_recipe('idea::default')
  end

  it 'creates idea directory' do
    expect(chef_run).to create_directory('/opt/idea')
  end

end