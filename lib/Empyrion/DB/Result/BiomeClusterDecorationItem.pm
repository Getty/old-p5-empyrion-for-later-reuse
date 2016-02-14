package Empyrion::DB::Result::BiomeClusterDecorationItem;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'biome_cluster_decoration_item';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1,
};

column biome_cluster_id => {
  data_type => 'integer',
  is_nullable => 0,
};

column name => {
  data_type => 'text',
  is_nullable => 0,
};

column density => {
  data_type => 'real',
  is_nullable => 0,
};

column scale => {
  data_type => 'real',
  is_nullable => 0,
};

belongs_to biome_cluster => "Empyrion::DB::Result::BiomeCluster", 'biome_cluster_id';

1;