#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

for (qw(
  Empyrion
  Empyrion::DB
  Empyrion::DB::Result::Playfield
  Empyrion::DB::Result::PlayfieldRandomResource
  Empyrion::Palpatine
)) {
  use_ok($_);
}

done_testing;

