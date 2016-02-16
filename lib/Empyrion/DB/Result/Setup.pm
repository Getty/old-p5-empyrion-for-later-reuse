package Empyrion::DB::Result::Setup;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'setup';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

column users_id => {
  data_type => 'integer',
  is_nullable => 1,
};

column key => {
  data_type => 'text',
  is_nullable => 0,
};

column value => {
  data_type => 'text',
  is_nullable => 1,
};

unique_constraint [ qw/users_id key/ ];

1;