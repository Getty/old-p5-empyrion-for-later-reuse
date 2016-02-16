package Empyrion::DB::Result::InstallationGame;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'installation_game';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column installation_id => {
  data_type => "integer",
  is_nullable => 0,
};

column path => {
  data_type => 'text',
  is_nullable => 0,
};

column indexed => {
  data_type => "integer",
  is_nullable => 0,
};

column last_used => {
  data_type => "integer",
  is_nullable => 1,
};

unique_constraint [ qw/installation_id path/ ];

belongs_to installation => "Empyrion::DB::Result::Installation", 'installation_id';

has_many installation_game_players => 'Empyrion::DB::Result::InstallationGamePlayer', 'installation_game_id', {
  cascade_delete => 1,
};

1;