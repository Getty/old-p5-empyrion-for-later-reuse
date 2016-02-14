package Empyrion::DB::Result::PlayfieldFixedResource;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'playfield_fixed_resource';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column playfield_id => {
  data_type => 'integer',
  is_nullable => 0,
};

column resource => {
  data_type => 'text',
  is_nullable => 0,
};

column coords_x => {
  data_type => 'integer',
  is_nullable => 0,
};
column coords_y => {
  data_type => 'integer',
  is_nullable => 0,
};
column coords_z => {
  data_type => 'integer',
  is_nullable => 0,
};
sub coords {
  my ( $self ) = @_;
  return [ $self->coords_x, $self->coords_y, $self->coords_z ];
}

column radius => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 5,
};

column notes => {
  data_type => 'text',
  is_nullable => 1,
};

belongs_to playfield => "Empyrion::DB::Result::Playfield", 'playfield_id';

1;