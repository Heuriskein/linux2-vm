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

describe 'linux-vm::users' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node, server|
      server.create_data_bag('users', {'rmills' => rmills_data})
    end.converge(described_recipe)
  end

  before do
    stub_command('which sudo').and_return('/bin/sudo')
    stub_command("grep -q 'GRUB_TIMEOUT=0' /etc/default/grub").and_return(0)
    stub_command("grep CHEF_NO_OVERWRITE /etc/default/locale").and_return(0)
  end

  it 'grants rmills sudo' do
    expect(chef_run).to install_sudo({'user'=>'rmills', 'nopasswd'=>true})
    expect(chef_run).to install_sudo('vagrant')
  end

  it 'removes rmills password' do
    expect(chef_run).to run_execute('sudo passwd -d rmills')
    expect(chef_run).to run_execute('sudo passwd -d vagrant')
  end
end