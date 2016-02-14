package Empyrion::DB::Result::System;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'system';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

# Used in interfaces not in game
column name => {
  data_type => 'text',
  is_nullable => 0,
};

# Imported systems are not editable or saveable, but will be put into Sectors.yaml
column read_only => {
  data_type => 'integer', # Bool
  is_nullable => 0,
  default_value => 1,
};

# game parameter

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

column notes => {
  data_type => 'text',
  is_nullable => 1,
};

has_many system_playfields => 'Empyrion::DB::Result::SystemPlayfield', 'system_id', {
  cascade_delete => 1,
};

1;