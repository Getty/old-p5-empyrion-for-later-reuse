package Empyrion::DB::Result::PlayfieldBiome;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'playfield_biome';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column playfield_id => {
  data_type => 'integer',
  is_nullable => 0,
};

column biome_id => {
  data_type => 'integer',
  is_nullable => 0,
};

unique_constraint [ qw/playfield_id biome_id/ ];

belongs_to playfield => "Empyrion::DB::Result::Playfield", 'playfield_id';
belongs_to biome => "Empyrion::DB::Result::Biome", 'biome_id';

1;