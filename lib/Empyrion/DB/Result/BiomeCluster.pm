package Empyrion::DB::Result::BiomeCluster;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'biome_cluster';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1,
};

column biome_id => {
  data_type => 'integer',
  is_nullable => 0,
};

column cluster_size => {
  data_type => 'integer',
  is_nullable => 0,
};

column nb_of_clusters => {
  data_type => 'integer',
  is_nullable => 0,
};

belongs_to biome => "Empyrion::DB::Result::Biome", 'biome_id';

has_many biome_cluster_decoration_items => 'Empyrion::DB::Result::BiomeClusterDecorationItem', 'biome_cluster_id', {
  cascade_delete => 1,
};

1;