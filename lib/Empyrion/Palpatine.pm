package Empyrion::Palpatine;
# ABSTRACT: Empyrion - Palpatine Server & Content Manager 

use MooX qw(
  Options
);

use POE qw(
  Component::Server::HTTPServer
  Component::Server::HTTPServer::Handler
  Component::Server::TCP
  Filter::JSONMaybeXS
  Filter::Line
  Filter::Stackable
  Wheel::FollowTail
);
# Component::Server::PSGI

use Protocol::WebSocket::Handshake::Server;
use Protocol::WebSocket::Frame;

use POE::Component::Server::HTTPServer::Handler;
use Scalar::Util qw( blessed );
use File::ShareDir::ProjectDistDir;
use Path::Tiny;
use JSON::MaybeXS;
use HTTP::Status;
use Data::Dumper;
use HTTP::Message::PSGI;
use File::HomeDir;

use File::Path;

use Empyrion::Palpatine::Web;
use Empyrion::DB;

our $VERSION = $Empyrion::VERSION || '0.000';

option ws_port => (
  is => 'ro',
  format => 'i',
  lazy => 1,
  default => sub { 33334 },
);

option port => (
  is => 'ro',
  format => 'i',
  lazy => 1,
  default => sub { 33333 },
);

option default_admin => (
  is => 'ro',
  format => 's',
  lazy => 1,
  default => sub { 'admin' },
);

option default_password => (
  is => 'ro',
  format => 's',
  lazy => 1,
  default => sub { 'fortheempire' },
);

option workdir => (
  is => 'ro',
  format => 's',
  lazy => 1,
  default => sub {
    my $workdir = File::HomeDir->my_home
      ? path(File::HomeDir->my_home,'.p5-empyrion')->absolute
      : path('.','.p5-empyrion')->absolute;
    path($workdir)->mkpath unless -d $workdir;
    return $workdir;
  },
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

has web_app => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    return Empyrion::Palpatine::Web->new( palpatine => $self )->to_psgi_app;
  },
);

has web_server => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    my $http_server = POE::Component::Server::HTTPServer->new;
    $http_server->port($self->port);
    $http_server->handlers([
      '/' => sub {
        my $context = shift;
        $context->{response} = res_from_psgi($self->web_app->(req_to_psgi($context->{request})));
        return H_FINAL;
      },
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

sub v0_db { path($_[0]->workdir,$_[0]->v0_db_filename)->absolute }
sub current_db { path($_[0]->workdir,$_[0]->v0_db_filename)->absolute }

has db => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    return Empyrion::DB->connect('dbi:SQLite:dbname='.$self->current_db, '', '', {
      AutoCommit => 1,
      RaiseError => 1,
      quote_char => '"',
      name_sep   => '.',
    });
  },
);

has setup => (
  is => 'rw',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    my %setup;
    my @entries = $self->db->resultset('Setup')->search_rs({
      users_id => undef,
    })->all;
    for (@entries) {
      $setup{$_->key} = $_->value if defined $_->value;
    }
    return { %setup };
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
  print " - Using work directory: ".$self->workdir."...\n";
  my $dbexist = -f $self->current_db;
  if ($dbexist) {
    print " - Opening database at ".$self->current_db."... ";
    $self->db;
    print "done\n";
  } else {
    print " - Deploying database to ".$self->current_db."... ";
    $self->db->deploy;
    print "done\n";
    if ($self->default_admin) {
      print "   Installing admin user '".$self->default_admin."' with password '".$self->default_password."'... ";
      $self->db->resultset('User')->create({
        login => $self->default_admin,
        password => $self->default_password,
        admin => 1,
      });      
      print "done\n";
    }
  }
  print " - Starting websocket server on port ".$self->ws_port."... ";
  $self->ws_server;
  print "done\n";
  print " - Starting web server on port ".$self->port."... ";
  $self->web_server;
  print "done\n";
  $self->autostart_gameservers;
  print <<'__EOF__'
                                  ___,_   _ 
 Ready to control the galaxy... [:t_:::;t"t"+
                                `=_ "`[ j.:\=\
       FOR THE EMPIRE!           _,:-.| -"_:\=\
                            _,-=":.:%.."+"+|:\=\
                   _ _____,:,,;,==.==+nnnpppppppt
                _.;-^-._-:._::.'';nn;::m;:%%%%%%%\
              .;-'_::-:_"--;_:. ((888:(@) ,,;::^%%%,
           __='::_:"`::::::::"-;_`YPP::; (d8B((@b."%\
        __,-:-:::::::::`::`::::::"--;_(@' 88P':^" ;nn:,
       ;-':::::`%%%\::---:::-:_::::::_"-;_.::((@,(88J::\
      """"""""""""""`------`.__.-:::::;___;;::`^__;;;:..7
                                            """"
__EOF__
}

sub autostart_gameservers {
  my ( $self ) = @_;
  my @servers = $self->db->resultset('InstallationGameServer')->search_rs({
    autostart => 1,
  },{
    order_by => { -desc => 'id' },
  })->all;
  my $count = scalar @servers;
  if ($count) {
    print " - Found ".$count." game server for autostart\n";
    for my $server (@servers) {
      print "   Starting ".$server->name." on port ".$server->port."...";
      $server->start;
      print "done\n";
    }
  } else {
    print " - No autostart game server...\n";
  }
}

sub run {
  $_[0]->new_with_options unless blessed $_[0];
  POE::Kernel->run;
}

1;