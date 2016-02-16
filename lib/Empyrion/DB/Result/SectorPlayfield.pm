package Empyrion::DB::Result::SectorPlayfield;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'sector_playfield';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column sector_id => {
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
belongs_to sector => "Empyrion::DB::Result::Sector", 'sector_id';

has_many player_sector_playfields => 'Empyrion::DB::Result::PlayerSectorPlayfield', 'sector_playfield_id', {
  cascade_delete => 1,
};

1;