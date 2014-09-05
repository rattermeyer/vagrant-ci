class role_nexus_server {

  # puppetlabs-java
  # NOTE: Nexus requires
  class{ '::java': }

  class{ '::nexus':
    version    => '2.9.0',
    revision   => '04',
    nexus_root => '/srv', # All directories and files will be relative to this
  }

  Class['::java'] ->
  Class['::nexus']
  Package['wget']->Class['::nexus']
}

include role_nexus_server

package { 'git' : }

user { 'git' : 
	ensure => present,
	managehome => true,
	password => '$6$v3oenNbI$8uuFf5wew2b6E.8tqk997tHRvOJ4MqrmU7be/2BxuSukVpNBabezT.GETqrGIGqoRcj9fK58b6WN09rKYeZfU.'
}