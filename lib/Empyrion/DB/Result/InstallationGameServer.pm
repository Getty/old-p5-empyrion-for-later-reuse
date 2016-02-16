package Empyrion::DB::Result::InstallationGameServer;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'installation_game_server';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

# process id if running
column running => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 0,
};

column autostart => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 0,
};

column installation_game_id => {
  data_type => "integer",
  is_nullable => 0,
};

column port => {
  data_type => "integer",
  is_nullable => 0,
};

column name => {
  data_type => "text",
  is_nullable => 0,
};

column password => {
  data_type => "text",
  is_nullable => 1,
};

column max_players => {
  data_type => "integer",
  is_nullable => 1,
};

column description => {
  data_type => "text",
  is_nullable => 1,
};

column reserve_playfields => {
  data_type => "integer",
  is_nullable => 1,
};

column telnet_port => {
  data_type => "integer",
  is_nullable => 1,
};

column telnet_password => {
  data_type => "text",
  is_nullable => 1,
};

column mode => {
  data_type => "integer",
  is_nullable => 0,
  default_value => 0,
};

column seed => {
  data_type => "integer",
  is_nullable => 0,
  default_value => 2411979,
};

column decay_time => {
  data_type => "integer",
  is_nullable => 0,
  default_value => 24,
};

column max_structures => {
  data_type => "integer",
  is_nullable => 0,
  default_value => 64,
};

column anti_grief_distance => {
  data_type => "integer",
  is_nullable => 0,
  default_value => 30,
};

column last_started => {
  data_type => "integer",
  is_nullable => 1,
};

belongs_to installation_game => "Empyrion::DB::Result::InstallationGame", 'installation_game_id';

1;