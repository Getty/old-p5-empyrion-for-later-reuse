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

column joined => {
  data_type => "integer",
  is_nullable => 0,
};

column last_seen => {
  data_type => "integer",
  is_nullable => 0,
};

has_many player_system_playfields => 'Empyrion::DB::Result::PlayerSystemPlayfield', 'player_id', {
  cascade_delete => 1,
};

1;