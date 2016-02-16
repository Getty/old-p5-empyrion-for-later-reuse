package Empyrion::DB::Result::Player;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'player';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column steam_name => {
  data_type => 'text',
  is_nullable => 0,
};

column steam_id => {
  data_type => 'text',
  is_nullable => 0,
};

has_many player_sector_playfields => 'Empyrion::DB::Result::PlayerSectorPlayfield', 'player_id', {
  cascade_delete => 1,
};

has_many installation_game_players => 'Empyrion::DB::Result::InstallationGamePlayer', 'player_id', {
  cascade_delete => 1,
};

1;