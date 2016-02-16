package Empyrion::DB::Result::PlayfieldRandomDroneBase;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'playfield_random_drone_base';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column playfield_id => {
  data_type => 'integer',
  is_nullable => 0,
};

column prefab => {
  data_type => 'text',
  is_nullable => 0,
};

column defence_drone_min => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 1,
};

column defence_drone_max => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 2,
};

column defence_drone_reserve => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 3,
};

column defence_probability => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 3,
};

column notes => {
  data_type => 'text',
  is_nullable => 1,
};

column difficulty => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 1,
};

column preset_style => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 1,
};

unique_constraint [ qw/playfield_id prefab/ ];

belongs_to playfield => "Empyrion::DB::Result::Playfield", 'playfield_id';

1;