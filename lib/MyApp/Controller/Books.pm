package MyApp::Controller::Books;
use Mojo::Base 'Mojolicious::Controller';
use MyApp::Model::Books;
use Data::Dumper;

sub index {
    my $self = shift;
    my $sth  = $self->db->prepare("SELECT * FROM books");
    $sth->execute();
    $self->stash( booksdata => $sth );
    $self->render( template => "/books/index" );
}

sub edit {
    my $self    = shift;
    my $books   = $self->books;                              # модель
    my $book_id = $self->param("id");
    my $book    = $books->get_book( $self->db, $book_id );
    $self->stash( book => $book );
    $self->render();
}

sub newform {
}

sub insert {
    my $self = shift;
    $self->books->insert( $self->db, $self->param("name") );
    $self->redirect_to( $self->url_for('books') );
}

sub update {
    my $self = shift;
    $self->books->update( $self->db, $self->param("id"), $self->param("name") );
    $self->redirect_to( $self->url_for('books') );
}

sub delete {
    my $self = shift;
    $self->books->delete( $self->db, $self->param("id") );
    $self->redirect_to( $self->url_for('books') );
}

1;
