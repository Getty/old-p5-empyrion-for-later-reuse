#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

for (qw(
  Empyrion
  Empyrion::DB
  Empyrion::DB::Result::Biome
  Empyrion::DB::Result::BiomeCluster
  Empyrion::DB::Result::BiomeClusterDecorationItem
  Empyrion::DB::Result::Installation
  Empyrion::DB::Result::InstallationGame
  Empyrion::DB::Result::InstallationGamePlayer
  Empyrion::DB::Result::InstallationGameServer
  Empyrion::DB::Result::InstallationSector
  Empyrion::DB::Result::Player
  Empyrion::DB::Result::PlayerSectorPlayfield
  Empyrion::DB::Result::Playfield
  Empyrion::DB::Result::PlayfieldBiome
  Empyrion::DB::Result::PlayfieldFixedResource
  Empyrion::DB::Result::PlayfieldRandomDroneBase
  Empyrion::DB::Result::PlayfieldRandomPOI
  Empyrion::DB::Result::PlayfieldRandomResource
  Empyrion::DB::Result::Sector
  Empyrion::DB::Result::SectorPlayfield
  Empyrion::DB::Result::Setup
  Empyrion::DB::Result::User
  Empyrion::DB::Result::UserPlayer
  Empyrion::Palpatine
  Empyrion::Palpatine::Web
)) {
  use_ok($_);
}

done_testing;

