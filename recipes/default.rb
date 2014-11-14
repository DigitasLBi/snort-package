yum_package 'gcc'
yum_package 'make'
yum_package 'bison'
yum_package 'flex'
yum_package 'autoconf'
yum_package 'automake' 
yum_package 'rpm-build'

include_recipe 'yum-epel'

yum_package 'libpcap-devel'
yum_package 'libdnet'
yum_package 'libdnet-devel'
yum_package 'pcre'
yum_package 'pcre-devel'

daq_path = "#{Chef::Config[:file_cache_path]}/daq.x86_64.rpm"
remote_file daq_path do
  source "http://configurationmanagement:TNaF204XeQu08g8@nexus.helios.digitaslbi.co.uk/service/local/repositories/thirdparty/content/Snort/Snort-Daq/2.0.2-1/Snort-Daq-2.0.2-1.rpm"
end

yum_package "daq" do
	source daq_path
    action :install
end

yum_package 'zlib'
yum_package 'zlib-devel'

snort_path = "#{Chef::Config[:file_cache_path]}/snort.src.rpm"

remote_file snort_path do
	source "http://configurationmanagement:TNaF204XeQu08g8@nexus.helios.digitaslbi.co.uk/service/local/repositories/thirdparty/content/Snort/Snort/2.9.6.2-1/Snort-2.9.6.2-1.rpm"
end

execute "rpmbuild --rebuild #{snort_path}" do
  user "#{node['current_user']}"
  environment ({ "HOME" => "/home/#{node['current_user']}"})
end

yum_package "snort" do
 	source "/home/#{node['current_user']}/rpmbuild/RPMS/x86_64/snort-2.9.6.2-1.x86_64.rpm"
end