/*
 * Module Main
 * Overrides Default Varnish Module!
 */
 
include "module.d/mod_main_acl.vcl";
include "module.d/mod_main_lib.vcl";

########[ RECV ]################################################################
sub vcl_recv {
    #call banIfAllowed;
    #call normalizeUserAgent;
    call normalizeAcceptEncoding;
    
    call setClientIPOnRestart;
    #call setClientIPOverride;
    call setClientIPAppend;
    
    call pipeIfNonRFC2616;
    call passIfNonIdempotent;
    call passPipeIfAuthorized;
    
    #call removeCookiesFromAll;
    call removeCookiesFromStaticsRx;
    
    call cacheAlwaysWWW;
    call cacheAlwaysScripts;
    call cacheAlwaysImages;
    call cacheAlwaysMultimedia;
    call cacheAlwaysXML;
    
    return (lookup);
}

########[ HIT ]#################################################################
sub vcl_hit {
    return (deliver);
}

########[ MISS ]################################################################
sub vcl_miss {
    return (fetch);
}

########[ FETCH ]###############################################################
sub vcl_fetch {
    if (beresp.ttl <= 0s ||
        beresp.http.Set-Cookie ||
        beresp.http.Vary == "*") {
        /*
        * Mark as "Hit-For-Pass" for the next 2 minutes
        */
        set beresp.ttl = 120 s;
        return (hit_for_pass);
    }
    call removeCookiesFromStaticsTx;

    #call saintModeOnAny;
    call saintModeOnServerInternalError;
    call saintModeOnServiceUnavailable;
    
    return (deliver);
}

########[ DELIVER ]#############################################################
sub vcl_deliver {
    return (deliver);
}

########[ PASS ]################################################################
sub vcl_pass {
    return (pass);
}

########[ PIPE ]################################################################
sub vcl_pipe {
    # Note that only the first request to the backend will have
    # X-Forwarded-For set.  If you use X-Forwarded-For and want to
    # have it set for all requests, make sure to have:
    # set bereq.http.connection = "close";
    # here.  It is not set by default as it might break some broken web
    # applications, like IIS with NTLM authentication.
    
    return (pipe);
}

########[ HASH ]################################################################
sub vcl_hash {
    hash_data(req.url);
    if (req.http.host) {
        hash_data(req.http.host);
    } else {
        hash_data(server.ip);
    }
    call hashCookieAuth;
    call hashCompressClients;

    return (hash);
}

