describe package('git') do
  it { should be_installed }
end

describe file('/usr/local/gitolite/.git/config') do
  its('content') { should match(%r{url = https://github.com/sitaramc/gitolite}) }
end

describe user('git') do
  it { should exist }
  its('home') { should eq '/var/lib/gitolite' }
  its('shell') { should eq '/bin/sh' }
  its('uid') { should be <= 1000 }
  its('gid') { should be <= 1000 }
end

describe directory('/var/lib/gitolite/bin') do
  its('owner') { should eq 'git' }
  its('group') { should eq 'git' }
  its('mode') { should cmp '0755' }
end

describe directory('/var/lib/gitolite/.gitolite') do
  its('owner') { should eq 'git' }
  its('group') { should eq 'git' }
  its('mode') { should cmp '0755' }
end

describe directory('/var/lib/gitolite/.gitolite/logs') do
  its('owner') { should eq 'git' }
  its('group') { should eq 'git' }
  its('mode') { should cmp '0755' }
end

describe file('/var/lib/gitolite/bin/gitolite') do
  its('link_path') { should eq '/usr/local/gitolite/src/gitolite' }
end
