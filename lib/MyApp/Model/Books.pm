package MyApp::Model::Books;

use strict;
use warnings;
use Data::Dumper;
use Mojo::Util 'secure_compare';

sub booklist {
    my $dbh = shift;
    my $sth = $dbh->prepare("select * from books");
    $sth->execute();
    return $sth;
}

sub get_book {
    my ( $self, $dbh, $id ) = @_;
    my $sth = $dbh->prepare("SELECT * FROM books WHERE id=?");
    $sth->execute($id);
    return $sth->fetchrow_hashref();
}

sub update {
    my ( $self, $dbh, $id, $name ) = @_;
    $dbh->do( "UPDATE books SET name=? WHERE id=?", undef, $name, $id );
}

sub delete {
    my ( $self, $dbh, $id ) = @_;
    $dbh->do( "DELETE FROM books WHERE id=?", undef, $id );
}

sub insert {
    my ( $self, $dbh, $name ) = @_;
    $dbh->do( "INSERT INTO books (name) VALUES(?)", undef, $name );
}

sub new { bless {}, shift }

1;
