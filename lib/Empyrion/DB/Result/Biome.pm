package Empyrion::DB::Result::Biome;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'biome';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column altitude_min => {
  data_type => 'integer',
  is_nullable => 0,
};

column altitude_max => {
  data_type => 'integer',
  is_nullable => 0,
};

column slope_min => {
  data_type => 'integer',
  is_nullable => 0,
};

column slope_max => {
  data_type => 'integer',
  is_nullable => 0,
};

has_many biome_clusters => 'Empyrion::DB::Result::BiomeCluster', 'biome_id', {
  cascade_delete => 1,
};

1;