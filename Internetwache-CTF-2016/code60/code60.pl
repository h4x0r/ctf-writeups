use IO::Socket::INET;
use Math::Prime::Util ':all';

$| = 1;

my $socket = new IO::Socket::INET (
  PeerHost => '188.166.133.53',
  PeerPort => '11059',
  Proto => 'tcp',
);
die "cannot connect to the server $!\n" unless $socket;

my $response = "";

$socket->recv($response, 1024);
print "$response";

my $n;
while (1) {
  $socket->recv($response, 1024);
  print "$response";

  chomp($response);
  $response =~ s/.*after //;
  $response =~ s/:.*//;

  $n = next_prime($response);

  $socket->send($n);
  $socket->flush;

  $socket->recv($response, 1024);
  print "$response";
}
