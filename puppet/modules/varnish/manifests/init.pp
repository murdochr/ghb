class varnish {
    include ::varnish::package
    include ::varnish::config
    include ::varnish::firewall
    include ::varnish::service

    include ::varnish::reload
}
