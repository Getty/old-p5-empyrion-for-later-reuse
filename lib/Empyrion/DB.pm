package Empyrion::DB;

use Moo;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces();

$ENV{DBIC_NULLABLE_KEY_NOWARN} = 1;

sub format_datetime { shift->storage->datetime_parser->format_datetime(shift) }
sub rs { shift->resultset(@_) }

1;
