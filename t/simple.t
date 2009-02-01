#!perl
use strict;
use warnings;
use Test::More tests => 6;
use LWP;
use LWP::ConnCache::MaxKeepAliveRequests;

my $ua = LWP::UserAgent->new;
$ua->conn_cache(
    LWP::ConnCache::MaxKeepAliveRequests->new(
        total_capacity          => 10,
        max_keep_alive_requests => 2,
    )
);

my $response = $ua->get('http://search.cpan.org/');
is( $response->header('Content-Type'), 'text/html; charset=iso-8859-1' );
is( $response->header('Client-Response-Num'), 1 );

$response = $ua->get('http://search.cpan.org/');
is( $response->header('Content-Type'), 'text/html; charset=iso-8859-1' );
is( $response->header('Client-Response-Num'), 2 );

$response = $ua->get('http://search.cpan.org/');
is( $response->header('Content-Type'), 'text/html; charset=iso-8859-1' );
is( $response->header('Client-Response-Num'), 1 );

