# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Stat-Acc.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 5;
BEGIN { use_ok('Stat::Acc2') };

#########################

binmode $_, ":utf8" foreach \*STDOUT, \*STDERR;

my $acc2 = Stat::Acc2->new();
ok($acc2);

my $m = 3;
my $q = 2;
my @X = (-9..9);
my @DATA = map { ($_, $_ * $m + $q) } @X;

$acc2->add(@DATA);
is($acc2->n, scalar @X);
is($acc2->slope, $m);
is($acc2->intercept, $q);

