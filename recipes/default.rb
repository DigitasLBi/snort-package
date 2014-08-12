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
  source "https://www.snort.org/downloads/snort/daq-#{node['daq_version']}.x86_64.rpm"
end

yum_package "daq" do
	source daq_path
    action :install
end

yum_package 'zlib'
yum_package 'zlib-devel'

snort_path = "#{Chef::Config[:file_cache_path]}/snort.src.rpm"

remote_file snort_path do
	source "https://www.snort.org/downloads/snort/snort-#{node['snort_version']}.src.rpm"
end

execute "rpmbuild --rebuild #{snort_path}"

yum_package "snort" do
 	source "/home/#{node['current_user']}/rpmbuild/RPMS/x86_64/snort-#{node['snort_version']}.x86_64.rpm"
end