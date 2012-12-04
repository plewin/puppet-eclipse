class eclipse (
  $ensure            = $eclipse::base::ensure,
  $version           = $eclipse::base::version,
  $download_mirror   = $eclipse::base::download_mirror,
  $download_timeout  = $eclipse::base::download_timeout,
  $extract_directory = $eclipse::base::extract_directory,

  $eclipse_system         = $eclipse::base::eclipse_system,
  $eclipse_architecture   = $eclipse::base::eclipse_architecture,
  $eclipse_window_manager = $eclipse::base::eclipse_window_manager,
) inherits eclipse::base {
  if $eclipse_architecture == '' {
    if $eclipse_window_manager == '' {
      $package = "eclipse-platform-${version}-${eclipse_system}"
    } else {
      $package = "eclipse-platform-${version}-${eclipse_system}-${eclipse_window_manager}"
    }
  } else {
    if $eclipse_window_manager == '' {
      $package = "eclipse-platform-${version}-${eclipse_system}-${eclipse_architecture}"
    } else {
      $package = "eclipse-platform-${version}-${eclipse_system}-${eclipse_window_manager}-${eclipse_architecture}"
    }
  }
  $file = "${package}.tar.gz"

  $download_drop = $version ? {
    '3.7.2'  => 'drops/R-3.7.2-201202080800/',
    '3.8'    => 'drops/R-3.8-201206081200/',
    '3.8.1'  => 'drops/R-3.8.1-201209141540/',
    '4.1.2'  => 'drops4/R-4.1.2-201202230900/',
    '4.2'    => 'drops4/R-4.2-201206081400/',
    '4.2.1'  => 'drops4/R-4.2.1-201209141800/',
    default  => 'drops4/R-4.2.1-201209141800/',
  }

  $url = "${download_mirror}${$download_drop}${file}"

  Exec { path => ['/bin', '/usr/bin/'] }

  archive::download { $file:
    ensure   => $ensure,
    url      => $url,
    timeout  => 720,
    checksum => false,
  }

  archive::extract { $package:
    ensure  => $ensure,
    target  => $extract_directory,
    require => Archive::Download[$file],
  }
} 