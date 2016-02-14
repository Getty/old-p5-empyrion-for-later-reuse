package Empyrion::DB::Result::PlayfieldRandomPOI;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'playfield_random_poi';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column playfield_id => {
  data_type => 'integer',
  is_nullable => 0,
};

column poi => {
  data_type => 'text',
  is_nullable => 0,
};

column amount_min => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 1,
};

column amount_max => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 1,
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

unique_constraint [ qw/playfield_id poi/ ];

belongs_to playfield => "Empyrion::DB::Result::Playfield", 'playfield_id';

1;