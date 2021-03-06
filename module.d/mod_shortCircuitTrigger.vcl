/*
 * Module Pipe Short Circuit on GET Trigger
 * 
 * Triggers:
 *     GET:
 *         NUCACHE_FUZE            (Case-InSensitive)
 */

########[ RECV ]################################################################
sub vcl_recv {
    if( req.url ~ "(?i)NUCACHE_FUZE" ) {
        return (pipe);
    }
}

########[ HIT ]#################################################################
sub vcl_hit {
    if( req.url ~ "(?i)NUCACHE_FUZE" ) {
        return (deliver);
    }
}

########[ MISS ]################################################################
sub vcl_miss {
    if( req.url ~ "(?i)NUCACHE_FUZE" ) {
        return (pass);
    }
}

########[ FETCH ]###############################################################
sub vcl_fetch {
    if( req.url ~ "(?i)NUCACHE_FUZE" ) {
        return (deliver);
    }
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
	if( req.http.X-nuCache-Debug ) {                                            
        set resp.http.X-nuCache-Debug-Mod-ShortCircuitTrigger = "Enabled";
    }

    if( req.url ~ "(?i)NUCACHE_FUZE" ) {
        return (deliver);
    }
}

########[ PASS ]################################################################
sub vcl_pass {
    if( req.url ~ "(?i)NUCACHE_FUZE" ) {
        return (pass);
    }
}

########[ PIPE ]################################################################
sub vcl_pipe {
    if( req.url ~ "(?i)NUCACHE_FUZE" ) {
        return (pipe);
    }
}

########[ HASH ]################################################################
sub vcl_hash {
    if( req.url ~ "(?i)NUCACHE_FUZE" ) {
        return (hash);
    }
}

