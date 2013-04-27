/*
 * Module Pipe Short Circuit
 */

########[ RECV ]################################################################
sub vcl_recv {
    return (pipe);
}

########[ HIT ]#################################################################
sub vcl_hit {
    
}

########[ MISS ]################################################################
sub vcl_miss {
    
}

########[ FETCH ]###############################################################
sub vcl_fetch {
    
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
    return (deliver);
}

########[ PASS ]################################################################
sub vcl_pass {
    
}

########[ PIPE ]################################################################
sub vcl_pipe {
    return (pipe);
}

########[ HASH ]################################################################
sub vcl_hash {
    
}

sub vcl_error {
    set obj.http.Content-Type = "text/html; charset=utf-8";
    synthetic {"
        <!DOCTYPE html>
        <html>
            <head>
                <title>"} + obj.status + " " + obj.response + {"</title>
            </head>
        <body>
            <h1>Error "} + obj.status + " " + obj.response + {"</h1>
            <p>"} + obj.response + {"</p>
            <h3>Guru Meditation:</h3>
            <p>XID: "} + req.xid + {"</p>
            <hr>
            <p>Varnish cache server</p>
        </body>
        </html>
    "};
    
    return (deliver);
}