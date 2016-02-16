package Empyrion::DB::Result::PlayerSectorPlayfield;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'player_sector_playfield';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column sector_playfield_id => {
  data_type => 'integer',
  is_nullable => 0,
};

column player_id => {
  data_type => 'integer',
  is_nullable => 0,
};

# 0 = Owner
# 1 = Manager
# 2 = Invited
# 3 = Seen
column status => {
  data_type => 'integer',
  is_nullable => 0,
};

unique_constraint [ qw/sector_playfield_id player_id/ ];

belongs_to sector_playfield => "Empyrion::DB::Result::SectorPlayfield", 'sector_playfield_id';
belongs_to player => "Empyrion::DB::Result::Player", 'player_id';

1;