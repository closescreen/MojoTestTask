package MyApp;
use Mojo::Base 'Mojolicious';
use MyApp::Model::Users;
use DBI;

sub startup {
    my $self     = shift;
    my $database = "/home/belyaev/MojoTestTask/db/mydatabase.sqlite";
    my $dbh      = DBI->connect( "dbi:SQLite:$database", "", "" )
      or die "Could not connect";
    $self->helper( db => sub { $dbh } );
    $self->secrets( ['Mojolicious rocks'] );

    $self->helper( users => sub { state $users = MyApp::Model::Users->new } );
    $self->helper( books => sub { state $books = MyApp::Model::Books->new } );

    my $r = $self->routes;

    $r->any('/')->to('login#index')->name('index');

    my $logged_in = $r->under('/')->to('login#logged_in');

    #  $logged_in->get('/protected')->to('login#protected');
    $r->get('/logout')->to('login#logout');
    $logged_in->get('/books')->to('books#index')->name('books');
    $logged_in->any('/books/edit/update')->to('books#update');
    $logged_in->get('/books/edit/:id')->to('books#edit')
      ->name('book_edit_by_id');
    $logged_in->get('/books/delete/:id')->to('books#delete')
      ->name('book_delete_by_id');
    $logged_in->get('/books/new')->to('books#newform')->name('book_newform');
    $logged_in->get('/books/insert')->to('books#insert')->name('book_insert');
}

1;
