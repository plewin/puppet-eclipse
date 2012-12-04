class {'eclipse':
  version => '3.8.1',
}

$repositories = [
  'http://download.cloudsmith.com/geppetto/updates',
  'http://download.eclipse.org/eclipse/updates/3.8',
  'http://download.eclipse.org/releases/indigo',
]

$plugins = [
  'org.eclipse.egit.feature.group',
  'org.cloudsmith.geppetto.feature.group',
]

eclipse::plugin { $::plugins:
  ensure       => present,
  repositories => $::repositories,
}
