Will download, repackage and install snort for CentOS/RHEL...

If the install fails then the repackaging is broken so that serves as integration test...

To install the generated package you still to install the LibDNet package over EPEL and install the DAQ manually before installing Snort.

include_recipe 'yum-epel'
yum_package 'libdnet'

