package Empyrion::DB::Result::Playfield;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'playfield';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

# Used in interfaces not in game
column name => {
  data_type => 'text',
  is_nullable => 0,
};

# Not filled normally for custom, but filled for imported
column directory => {
  data_type => 'text',
  is_nullable => 1,
};

# Imported playfields are not editable or saveable, they will not be generated from here
column read_only => {
  data_type => 'integer', # Bool
  is_nullable => 0,
  default_value => 0,
};

#
# game parameter
#
######################

## always required as it seems

column gravity => {
  data_type => 'real',
  is_nullable => 0,
};

column atmosphere_enabled => {
  data_type => 'integer', # Bool
  is_nullable => 0,
};

column pvp => {
  data_type => 'integer', # Bool
  is_nullable => 0,
};

column difficulty => {
  data_type => 'integer', # Between 2 and 5
  is_nullable => 0,
};

column planet_type => {
  data_type => 'text',
  is_nullable => 0,
};

column playfield_type => {
  data_type => 'text',
  is_nullable => 0,
};

########

column atmosphere_breathable => {
  data_type => 'integer', # Bool
  is_nullable => 1,
};

column atmosphere_density => {
  data_type => 'real',
  is_nullable => 1,
};

column atmosphere_color => {
  data_type => 'text', # Color
  is_nullable => 1,
};

column sky_color => {
  data_type => 'text', # Color
  is_nullable => 1,
};

column emissive => {
  data_type => 'integer', # Bool
  is_nullable => 1,
};

column biome => {
  data_type => 'text',
  is_nullable => 1,
};

column wind_speed => {
  data_type => 'integer', # Between 0 and 10
  is_nullable => 1,
};

column moons => {
  data_type => 'integer',
  is_nullable => 1,
};

column sun_flare => {
  data_type => 'text',
  is_nullable => 1,
};

column water_block => {
  data_type => 'text',
  is_nullable => 1,
};

column day_light_intensity => {
  data_type => 'real',
  is_nullable => 1,
};

column night_light_intensity => {
  data_type => 'real',
  is_nullable => 1,
};

column atmosphere_fog => {
  data_type => 'real',
  is_nullable => 1,
};

column fog_cloud_intensity => {
  data_type => 'real',
  is_nullable => 1,
};

column fog_intensity => {
  data_type => 'real',
  is_nullable => 1,
};

column fog_start_distance => {
  data_type => 'integer',
  is_nullable => 1,
};

column fog_start_distance => {
  data_type => 'integer',
  is_nullable => 1,
};

column ground_fog_intensity => {
  data_type => 'real',
  is_nullable => 1,
};

column ground_fog_height => {
  data_type => 'integer',
  is_nullable => 1,
};

column clouds_density => {
  data_type => 'real',
  is_nullable => 1,
};

column clouds_sharpness => {
  data_type => 'real',
  is_nullable => 1,
};

column clouds_brightness => {
  data_type => 'real',
  is_nullable => 1,
};

column description => {
  data_type => 'text',
  is_nullable => 1,
};

column notes => {
  data_type => 'text',
  is_nullable => 1,
};

has_many playfield_random_resources => 'Empyrion::DB::Result::PlayfieldRandomResource', 'playfield_id', {
  cascade_delete => 1,
};

has_many playfield_fixed_resources => 'Empyrion::DB::Result::PlayfieldFixedResource', 'playfield_id', {
  cascade_delete => 1,
};

has_many playfield_random_pois => 'Empyrion::DB::Result::PlayfieldRandomPOI', 'playfield_id', {
  cascade_delete => 1,
};

has_many playfield_biomes => 'Empyrion::DB::Result::PlayfieldBiome', 'playfield_id', {
  cascade_delete => 1,
};

has_many sector_playfields => 'Empyrion::DB::Result::SectorPlayfield', 'playfield_id', {
  cascade_delete => 1,
};

1;