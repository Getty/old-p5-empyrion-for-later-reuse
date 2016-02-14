package Empyrion::DB::Result::PlayfieldRandomResource;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'playfield_random_resource';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1,
};

column playfield_id => {
  data_type => 'integer',
  is_nullable => 0,
};

column resource => {
  data_type => 'text',
  is_nullable => 0,
};

column amount_min => {
  data_type => 'integer',
  is_nullable => 0,
};

column amount_max => {
  data_type => 'integer',
  is_nullable => 0,
};

column size_min => {
  data_type => 'integer',
  is_nullable => 0,
};

column size_max => {
  data_type => 'integer',
  is_nullable => 0,
};

column depth_min => {
  data_type => 'integer',
  is_nullable => 0,
};

column depth_max => {
  data_type => 'integer',
  is_nullable => 0,
};

column defence_probability => {
  data_type => 'integer',
  is_nullable => 0,
};

column defence_drone_max => {
  data_type => 'integer',
  is_nullable => 0,
};

column notes => {
  data_type => 'text',
  is_nullable => 1,
};

unique_constraint [ qw/playfield_id resource/ ];

belongs_to playfield => "Empyrion::DB::Result::Playfield", 'playfield_id';

1;