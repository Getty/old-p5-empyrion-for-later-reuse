package Empyrion::DB::Result::SystemPlayfield;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'system_playfield';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column system_id => {
  data_type => 'integer',
  is_nullable => 0,
};

column playfield_id => {
  data_type => 'integer',
  is_nullable => 0,
};

# Name in game and interface
column name => {
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

column starter => {
  data_type => 'integer', # Bool
  is_nullable => 0,
  default_value => 0,
};

column notes => {
  data_type => 'text',
  is_nullable => 1,
};

belongs_to playfield => "Empyrion::DB::Result::Playfield", 'playfield_id';
belongs_to system => "Empyrion::DB::Result::System", 'system_id';

has_many player_system_playfields => 'Empyrion::DB::Result::PlayerSystemPlayfield', 'system_playfield_id', {
  cascade_delete => 1,
};

1;