# Define: varnish::route
#
# Create a route for a specific URI regardless of hostname. This is pretty
# hacky and doesn't lend itself well to multi-tenancy of sites. The resource
# $name is treated as the primary URI for this route. It will be used as a
# caret anchored regex - so it is important that it is as specific and
# long-matching as possible.
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
#       Other URIs to treat as equivalent to this route.
#
#   - nocache:
#       An array of URI regexes that caching will be disabled for. It is
#       important that you anchor these with a caret. Try to make them as
#       specific and long-matching as possible.
#
#   - auth:
#       An array of base64'ed user:pass string literals with which to secure
#       all requests to this resource.
#
#   - extra:
#       An array of raw VCL lines that will be inserted into this condition.
#       Any significant or repeated use of this probably warrants a new
#       param being added.
#
define varnish::route (
    $backend,
    $order = 40,
    $aliases = '',
    $nocache = '',
    $auth = '',
    $extra = ''
) {
    $conf_recv = '/etc/varnish/conf.d/recv.vcl'
    $conf_fetch = '/etc/varnish/conf.d/fetch.vcl'

    common::concat::fragment { "${conf_recv}-${name}":
        target  => $conf_recv,
        content => template("${module_name}${conf_recv}.route.erb"),
        order   => $order,
        require => Varnish::Director[$backend],
    }
    if ($nocache) {
        common::concat::fragment { "${conf_fetch}-${name}":
            target  => $conf_fetch,
            content => template("${module_name}${conf_fetch}.route.erb"),
        }
    }
}
