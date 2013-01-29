define varnish::director (
    $backend_hosts,
    $backend_port,
    $director_type = "round-robin",
    $probe_url = "/",
    $probe_window = '',     # Default: 8
    $probe_threshold = '',  # Default: 3
    $probe_interval = '',   # Default: 5s
    $probe_timeout = ''     # Default: 2s
) {
    $director_name = $name
    $conf_file = '/etc/varnish/conf.d/backend.vcl'

    # Sanity check probe values before we throw them at Varnish.
    if ($probe_threshold or $probe_window) {
        vcl_probe_syntax($probe_threshold, $probe_window)
    }

    common::concat::fragment { "${conf_file}-${name}":
        target  => $conf_file,
        content => template("${module_name}${conf_file}.director.erb"),
    }
}
