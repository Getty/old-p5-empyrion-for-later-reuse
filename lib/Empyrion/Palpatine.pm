package Empyrion::Palpatine;
# ABSTRACT: Empyrion - Palpatine Server & Content Manager 

use MooX qw(
  Options
);

use POE qw(
  Component::Server::HTTPServer
  Component::Server::HTTPServer::Handler
  Component::Server::HTTPServer::StaticHandler
  Component::Server::TCP
  Filter::JSONMaybeXS
  Filter::Line
  Filter::Stackable
  Wheel::FollowTail
);
# Component::Server::PSGI

use Protocol::WebSocket::Handshake::Server;
use Protocol::WebSocket::Frame;
use Plack::App::Directory;

use Scalar::Util qw( blessed );
use File::ShareDir::ProjectDistDir;
use Path::Tiny;
use JSON::MaybeXS;
use HTTP::Status;
use Data::Dumper;

use Empyrion::DB;

our $VERSION = '0.000';

has ws_port => (
  is => 'ro',
  lazy => 1,
  default => sub { 30008 },
);

has port => (
  is => 'ro',
  lazy => 1,
  default => sub { 33333 },
);

has _ws_conns => (
  is => 'rw',
  lazy => 1,
  default => sub {{}},
);

has ws_server => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    POE::Component::Server::TCP->new(
      Port            => $self->ws_port,
      ClientFilter    => 'POE::Filter::Stream',
      ClientConnected => sub {
        $self->_ws_conns->{$_[SESSION]->ID} = $_[HEAP]{client};
        $_[HEAP]{hs} = Protocol::WebSocket::Handshake::Server->new;
        $_[HEAP]{frame} = Protocol::WebSocket::Frame->new;
      },
      ClientDisconnected => sub {
        delete $self->_ws_conns->{$_[SESSION]->ID};
      },
      ClientInput     => sub {
        my $chunk = $_[ARG0];
        if (!$_[HEAP]{hs}->is_done) {
          $_[HEAP]{hs}->parse($chunk);
          if ($_[HEAP]{hs}->is_done) {
            $_[HEAP]{client}->put($_[HEAP]{hs}->to_string);
          }
          return;
        }
        $_[HEAP]{frame}->append($chunk);
        while (my $message = $_[HEAP]{frame}->next) {
          # do we care about input on websocket?
        }
      },
    );
  },
);

# has web_server => (
#   is => 'ro',
#   lazy => 1,
#   default => sub {
#     my ( $self ) = @_;
#     my $web_server = POE::Component::Server::PSGI->new(
#       port => $self->port,
#     );
#     $web_server->run($self->web_app);
#     return $web_server;
#   },
# );

# has web_app => (
#   is => 'ro',
#   lazy => 1,
#   default => sub {
#     my ( $self ) = @_;
#     Plack::App::Directory->new(root => $self->web_root)->to_app;
#   },
# );

has web_server => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    my $http_server = POE::Component::Server::HTTPServer->new;
    $http_server->port($self->port);
    $http_server->handlers([
      '/' => new_handler('StaticHandler',$self->web_root),
      # '/data.json' => sub { $self->data_handler(@_) },
    ]);
    $http_server->create_server();
  },
);

has web_root => (
  is => 'ro',
  lazy => 1,
  default => sub { path(dist_dir('Empyrion'),'palpatine') },
);

sub v0_db_filename { 'p5_empyrion_v0.sqlite' }
sub current_db_filename { shift->v0_db_filename }

has db => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    return Empyrion::DB->connect('dbi:SQLite:dbname='.$self->current_db_filename, '', '', {
      AutoCommit => 1,
      RaiseError => 1,
      quote_char => '"',
      name_sep   => '.',
    });
  },
);

sub BUILD {
  my ( $self ) = @_;
  print "  ____   _    _     ____   _  _____ ___ _   _ _____\n";
  print " |  _ \\ / \\  | |   |  _ \\ / \\|_   _|_ _| \\ | | ____|\n";
  print " | |_) / _ \\ | |   | |_) / _ \\ | |  | ||  \\| |  _|\n";
  print " |  __/ ___ \\| |___|  __/ ___ \\| |  | || |\\  | |___\n";
  print " |_| /_/   \\_\\_____|_| /_/   \\_\\_| |___|_| \\_|_____|\n";
  print "\n";
  print " ---- Empyrion Server & Content Manager v".$VERSION." ----\n";
  print "\n";
  my $dbexist = -f $self->current_db_filename;
  if ($dbexist) {
    print " - Opening database at ".$self->current_db_filename."... ";
    $self->db;
    print "done\n";
  } else {
    print " - Deploying database to ".$self->current_db_filename."... ";
    $self->db->deploy unless $dbexist;
    print "done\n";
  }
  print " - Starting websocket server on port ".$self->ws_port."... ";
  $self->ws_server;
  print "done\n";
  print " - Starting web server on port ".$self->port."... ";
  $self->web_server;
  print "done\n";
  print "\n";
  print "Ready to control the galaxy... FOR THE EMPIRE\n\n";
}

sub run {
  $_[0]->new_with_options unless blessed $_[0];
  POE::Kernel->run;
}

1;