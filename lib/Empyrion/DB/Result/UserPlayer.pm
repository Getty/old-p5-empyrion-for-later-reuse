package Empyrion::DB::Result::UserPlayer;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'user_player';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column users_id => {
  data_type => 'integer',
  is_nullable => 0,
};

column player_id => {
  data_type => 'integer',
  is_nullable => 0,
};

belongs_to player => "Empyrion::DB::Result::Player", 'player_id';
belongs_to user => "Empyrion::DB::Result::User", 'users_id';

1;