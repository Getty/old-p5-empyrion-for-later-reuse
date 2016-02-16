package Empyrion::DB::Result::InstallationSector;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'installation_sector';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column installation_id => {
  data_type => "integer",
  is_nullable => 0,
};

column sector_id => {
  data_type => "integer",
  is_nullable => 0,
};

unique_constraint [ qw/installation_id sector_id/ ];

belongs_to installation => "Empyrion::DB::Result::Installation", 'installation_id';
belongs_to sector => "Empyrion::DB::Result::Sector", 'sector_id';

1;