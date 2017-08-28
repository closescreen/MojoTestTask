use Test::More;
use Test::Mojo;

# Load application class
my $t = Test::Mojo->new('MyApp');
$t->ua->max_redirects(1);

$t->post_ok( '/' => form => { user => 'sebastian', pass => 'secr3t' } )
    ->status_is(200)->text_like( 'html body' => qr/sebastian/ );

$t->get_ok('/books/new')->status_is(200)
    ->element_exists('form input[name="name"]')
    ->element_exists('form input[type="submit"]');

$t->get_ok( '/books/insert' => form => { name => 'Superbook' } )
    ->status_is(200)->content_like(qr/Superbook/);

$t->get_ok('/books/edit/2')->status_is(200)->text_like( 'a' => qr/Logout/ );

done_testing();
