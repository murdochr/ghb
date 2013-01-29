if (obj.status == 750) {
    # Wrapper for "error 301" statements. Redirects to another location.
    set obj.status = 301;
    set obj.http.Location = obj.response;
    return (deliver);
}

if (obj.status == 751) {
    # Wrapper for failed Basic Auth challenges internal to Varnish.
    set obj.status = 401;
    set obj.response = "Unauthorized";
    set obj.http.Content-Type = "text/html; charset=utf-8";
    set obj.http.WWW-Authenticate = "Basic realm=Secured";

    synthetic {"<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <title>401 Unauthorized</title>
  </head>
  <body>
    <h1>Error 401 Unauthorized</h1>
  </body>
</html>
"};
    return (deliver);
}
