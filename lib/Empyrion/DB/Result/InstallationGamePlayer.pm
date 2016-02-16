package Empyrion::DB::Result::InstallationGamePlayer;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'installation_game_player';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column installation_game_id => {
  data_type => "integer",
  is_nullable => 0,
};

column player_id => {
  data_type => "integer",
  is_nullable => 0,
};

column joined => {
  data_type => "integer",
  is_nullable => 0,
};

column last_seen => {
  data_type => "integer",
  is_nullable => 0,
};

belongs_to installation_game => "Empyrion::DB::Result::InstallationGame", 'installation_game_id';
belongs_to player => "Empyrion::DB::Result::Player", 'player_id';

1;