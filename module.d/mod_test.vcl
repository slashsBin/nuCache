/*
 * Module Test
 * Just for Develop & Testing Purposes
 *
 * Keep Clean after tests
 *
 * Depends on Standard VMod
 */

#import std;

########[ RECV ]################################################################
sub vcl_recv {

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
	if( req.http.X-nuCache-Debug ) {                                            
        set resp.http.X-nuCache-Debug-Mod-Test = "Enabled";
    }
}

########[ PASS ]################################################################
sub vcl_pass {

}

########[ PIPE ]################################################################
sub vcl_pipe {

}

########[ HASH ]################################################################
sub vcl_hash {

}

########[ ERROR ]###############################################################
sub vcl_error {

}

