package MyApp;
use Mojo::Base 'Mojolicious';
use MyApp::Model::Users;

sub startup {
  my $self = shift;

  my $database = "/home/dima/App-reg-ru/Mojo-apps/myapp/db/mydatabase.sqlite";
  use DBI;
  my $dbh = DBI->connect("dbi:SQLite:$database","","") or die "Could not connect";
  my $sth = $dbh->prepare("select * from books");
  $self->helper(db => sub { $dbh });

  $self->secrets(['Mojolicious rocks']);
  $self->helper(users => sub { state $users = MyApp::Model::Users->new });

  my $r = $self->routes;
  $r->any('/')->to('login#index')->name('index');

  my $logged_in = $r->under('/')->to('login#logged_in');
  $logged_in->get('/protected')->to('login#protected');

  $r->get('/logout')->to('login#logout');

  $r->get('/books')->to('books#index');
}

1;