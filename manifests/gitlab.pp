node gitlab {
  network_config { 'eth1':
    ensure  => 'present',
    family  => 'inet',
    method  => 'dhcp',
    onboot  => 'true',
    hotplug => 'false',
  }
}
