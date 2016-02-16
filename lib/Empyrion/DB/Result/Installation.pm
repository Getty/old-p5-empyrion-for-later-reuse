package Empyrion::DB::Result::Installation;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'installation';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

unique_column path => {
  data_type => 'text',
  is_nullable => 0,
};

column version => {
  data_type => 'text',
  is_nullable => 1,
};

column indexed => {
  data_type => "integer",
  is_nullable => 0,
};

column last_used => {
  data_type => "integer",
  is_nullable => 1,
};

has_many installation_games => 'Empyrion::DB::Result::InstallationGame', 'installation_id', {
  cascade_delete => 1,
};

has_many installation_sectors => 'Empyrion::DB::Result::InstallationSector', 'installation_id', {
  cascade_delete => 1,
};

1;