#
# recv.vcl is included after this has executed, do nothing in here but touch
# headers... do *NOT* pass() a request
#

#
# If we don't have an XFP, then we must be dealing with a direct http request,
# in which case add the header as we're probably working local and haven't come
# through a higher load balancer.
#
if (!req.http.X-Forwarded-Proto) {
  set req.http.X-Forwarded-Proto = "http";
  set req.http.X-Forwarded-Port = "80";
}
