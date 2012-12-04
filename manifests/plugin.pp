define eclipse::plugin (
  $iu = $name,
  $ensure = present,
  $target = '/opt/eclipse',
  $repositories = [],
) {
  include stdlib
  include eclipse

  Class['eclipse'] -> Eclipse::Plugin[$iu]

  $repositories_list = join($repositories, ',')

  case $ensure {
    present : {
      exec { "install iu ${iu}":
        command => "${target}/eclipse \
                    -nosplash \
                    -application org.eclipse.equinox.p2.director \
                    -installIU ${iu}\
                    -destination ${target} \
                    -r $repositories_list",
        unless  => "${target}/eclipse \
                    -nosplash \
                    -application org.eclipse.equinox.p2.director -lir |/bin/grep ${iu}",
      }
    }
    absent: {
      exec { "remove iu ${iu}":
        command => "${target}/eclipse \
                    -nosplash \
                    -application org.eclipse.equinox.p2.director \
                    -uninstallIU ${iu}\
                    -destination ${target} \
                    -r $repositories_list",
        onlyif  => "${target}/eclipse \
                    -nosplash \
                    -application org.eclipse.equinox.p2.director -lir |/bin/grep ${iu}",
      }
    }
    default: { fail("Only present and absent are valid values for ensure.") }
  }

}