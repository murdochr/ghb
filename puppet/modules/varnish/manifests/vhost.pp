# Define: varnish::vhost
#
# Create a route for an HTTP/1.1 virtual host in Varnish. The resource $name
# is treated as the primary hostname of the vhost.
#
# Params:
#
#   - backend:
#       Name of the varnish::director resource to send requests to.
#
#   - order:
#       Order that the rule will appear in recv.vcl. Defaults to 60.
#
#   - aliases:
#       Other hostnames to treat as equivalent to this vhost.
#
#   - nocache:
#       An array of URI regexes that caching will be disabled for. It is
#       important that you anchor these with a caret.
#
#   - extra:
#       An array of raw VCL lines that will be inserted into this condition.
#       Any significant or repeated use of this probably warrants a new
#       param being added.
#
#   - auth:
#       An array of base64'ed user:pass string literals with which to secure
#       all requests to this resource.
#
#   - https_only:
#       Whether the vhost should only be available over HTTPS according to
#       the header X-Forwarded-Proto. Defaults to false which will do
#       nothing. When set to true HTTP requests will be redirect back to the
#       root of the HTTPS site.
#
#   - esi:
#       Whether ESI processing should be enabled. Default to false.
#
define varnish::vhost (
    $backend,
    $order = 60,
    $aliases = '',
    $nocache = '',
    $extra = '',
    $auth = '',
    $https_only = false,
    $esi = false
) {
    $conf_recv = '/etc/varnish/conf.d/recv.vcl'
    $conf_fetch = '/etc/varnish/conf.d/fetch.vcl'

    common::concat::fragment { "${conf_recv}-${name}":
        target  => $conf_recv,
        content => template("${module_name}${conf_recv}.vhost.erb"),
        order   => $order,
        require => Varnish::Director[$backend],
    }
    if ($esi == true) or ($nocache) {
        common::concat::fragment { "${conf_fetch}-${name}":
            target  => $conf_fetch,
            content => template("${module_name}${conf_fetch}.vhost.erb"),
        }
    }
}
