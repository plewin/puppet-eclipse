class eclipse::base {
  $ensure            = present
  $version           = '4.2.1'
  $extract_directory = '/opt'
  $download_mirror   = 'http://eclipse.ialto.com/eclipse/downloads/' 
  $download_timeout   = 720

  $eclipse_system = $::kernel ? {
    'windows' => 'win32',
    default   => 'linux',
  }

  $eclipse_architecture = $eclipse_system ? {
    'linux' => $::architecture ? {
        'amd64'  => 'x86_64',
        default  => '',
      },
    default => '',
  }

  $eclipse_window_manager = $eclipse_system ? {
    'linux' => 'gtk',
    default => '',
  }
}