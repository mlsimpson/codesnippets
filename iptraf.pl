#!/usr/bin/perl

use strict;
#use warnings;

use POSIX qw(strftime);
use Time::HiRes qw(gettimeofday usleep);

my $dev = @ARGV ? shift : 'eth0';
my $dir = "/sys/class/net/$dev/statistics";
my $maxrx = "0";
my $maxtx = "0";
my %stats = do {
	opendir +(my $dh), $dir;
	local @_ = readdir $dh;
	closedir $dh;
	map +($_, []), grep !/^\.\.?$/, @_;
};

sub BytesToReadableString($) {
  my $c = shift;
  $c >= 1073741824 ? sprintf("%0.2fGB", $c/1073741824)
    : $c >= 1048576 ? sprintf("%0.2fMB", $c/1048576)
    : $c >= 1024 ? sprintf("%0.2fKB", $c/1024)
    : $c . "B";
}

if (-t STDOUT) {
	while (&keystroke != 1) {
		print "\033[H\033[J", run();
		my ($time, $us) = gettimeofday();
		my ($sec, $min, $hour) = localtime $time;
		{
			local $| = 1;
			printf '%-31.31s: %02d:%02d:%02d.%06d%11s%12s%12s%12s',
			       $dev, $hour, $min, $sec, $us, qw(1s 5s 15s 60s);
			print "\n";
			printf 'Max RX:  %s/s :: Max TX:  %s/s', BytesToReadableString($maxrx), BytesToReadableString($maxtx);
			printf "\n\nPress 'Enter' to quit";
		}
		usleep($us ? 1000000 - $us : 1000000);
	}
}
else {print run()}

sub run {
	map {
		my $line;
		my $num;
		chomp (my ($stat) = slurp("$dir/$_"));
    if($_ eq 'rx_bytes' || $_ eq 'tx_bytes'){
      $line = sprintf '%-31.31s:%16.16s', $_, BytesToReadableString($stat);
      if (@{$stats{$_}} > 0) {
        $num = (int (($stat - $stats{$_}->[0]) / 1));
        $line .= sprintf '%10.10s%s', BytesToReadableString($num), "/s";
      }
      if (@{$stats{$_}} > 4) {
        $line .= sprintf '%10.10s%s', BytesToReadableString(int (($stat - $stats{$_}->[4]) / 5)), "/s";
      }
      if (@{$stats{$_}} > 14) {
        $line .= sprintf '%10.10s%s', BytesToReadableString(int (($stat - $stats{$_}->[14]) / 15)), "/s";
      }
      if (@{$stats{$_}} > 59) {
        $line .= sprintf '%10.10s%s', BytesToReadableString(int (($stat - $stats{$_}->[59]) / 60)), "/s";
      }
    } else {
      $line = sprintf '%-31.31s:%16.16s', $_, NumToMagnitute($stat);
      if (@{$stats{$_}} > 0) {
        $num = (int (($stat - $stats{$_}->[0]) / 1));
        $line .= sprintf '%10.10s%s', NumToMagnitute($num), "/s";
      }
      if (@{$stats{$_}} > 4) {
        $line .= sprintf '%10.10s%s', NumToMagnitute(int (($stat - $stats{$_}->[4]) / 5)), "/s";
      }
      if (@{$stats{$_}} > 14) {
        $line .= sprintf '%10.10s%s', NumToMagnitute(int (($stat - $stats{$_}->[14]) / 15)), "/s";
      }
      if (@{$stats{$_}} > 59) {
        $line .= sprintf '%10.10s%s', NumToMagnitute(int (($stat - $stats{$_}->[59]) / 60)), "/s";
      }
    }
		if ($_ eq 'rx_bytes'){
			if($num > $maxrx){
				$maxrx = $num;
			}
		}
		if ($_ eq 'tx_bytes'){
			if($num > $maxtx){
				$maxtx = $num;
			}
		}
		unshift @{$stats{$_}}, $stat;
		pop @{$stats{$_}} if @{$stats{$_}} > 60;
		"$line\n";
	} sort keys %stats;
}

sub slurp {
	local @ARGV = @_;
	local @_ = <>;
	@_;
}

sub NumToMagnitute($) {
  my $c = shift;
  $c >= 1000000000 ? sprintf("%0.2fG", $c/1000000000)
    : $c >= 1000000 ? sprintf("%02.fM", $c/1000000)
    : $c >= 1000 ? sprintf("%0.2fK", $c/1000)
    : $c;
}

sub keystroke {
	my $i = '';
	vec($i, fileno(STDIN), 1) = 1;
	my $j = select ($i, undef, undef, 0);
}
