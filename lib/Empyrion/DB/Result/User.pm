package Empyrion::DB::Result::User;
# ABSTRACT: 

use Moo;
extends 'DBIx::Class::Core';

use DBIx::Class::Candy;

table 'users';

primary_column id => {
  data_type => "integer",
  is_nullable => 0,
  is_auto_increment => 1
};

unique_column login => {
  data_type => 'text',
  is_nullable => 0,
};

column password => {
  data_type => 'text',
  is_nullable => 0,
};

column admin => {
  data_type => 'integer',
  is_nullable => 0,
  default_value => 0,
};

1;