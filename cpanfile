
requires 'DBD::SQLite', '0';
requires 'DBIx::Class', '0';
requires 'DBIx::Class::Candy', '0';
requires 'File::ShareDir::ProjectDistDir', '0';
requires 'Moo', '0';
requires 'MooX', '0';
requires 'MooX::Options', '0';
requires 'Path::Tiny', '0';
requires 'Plack', '0';
requires 'Plack::Middleware::Session', '0';
requires 'POE::Component::Client::TCP', '0';
requires 'POE::Component::Server::HTTPServer', '0';
requires 'POE::Filter::JSONMaybeXS', '0';
requires 'POE::Wheel::FollowTail', '0';
requires 'Protocol::WebSocket', '0';
requires 'Web::Simple', '0';
requires 'YAML::XS', '0';

on test => sub {
  requires 'Test::More', '0.96';
};
