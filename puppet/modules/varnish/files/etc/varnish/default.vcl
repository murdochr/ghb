include "/etc/varnish/conf.d/acl.vcl";
include "/etc/varnish/conf.d/backend.vcl";

#
# Handles receiving a request and deciding what to do with it before
# dispatching the request to a backend server or re-directing or
# something
#
sub vcl_recv {
  #
  # This *MUST* be included first as it sets a req.http.X-Yell-Client-IP header
  # that is used below.
  #
  include "/etc/varnish/conf.d/recv_headers.vcl";
  include "/etc/varnish/conf.d/recv.vcl";
}

sub vcl_pipe {
  #
  # Note that only the first request to the backend will have
  # X-Forwarded-For set.  If you use X-Forwarded-For and want to
  # have it set for all requests, make sure to have:

  set req.http.connection = "close";

  # here.  It is not set by default as it might break some broken web
  # applications, like IIS with NTLM authentication.
  #

  include "/etc/varnish/conf.d/pipe.vcl";
}

sub vcl_hash {
  include "/etc/varnish/conf.d/hash.vcl";
}

sub vcl_fetch {
  include "/etc/varnish/conf.d/fetch_headers.vcl";
  include "/etc/varnish/conf.d/fetch.vcl";
}

sub vcl_hit {
  include "/etc/varnish/conf.d/hit.vcl";
}

sub vcl_miss {
  include "/etc/varnish/conf.d/miss.vcl";
}

sub vcl_pass {
  include "/etc/varnish/conf.d/pass.vcl";
}

sub vcl_deliver {
  include "/etc/varnish/conf.d/deliver.vcl";
}

sub vcl_error {
  include "/etc/varnish/conf.d/error_default.vcl";
  include "/etc/varnish/conf.d/error.vcl";

  return (deliver);
}
