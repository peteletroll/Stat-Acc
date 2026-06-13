# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Stat-Acc.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 7;
BEGIN { use_ok('Stat::Acc') };

#########################

binmode $_, ":utf8" foreach \*STDOUT, \*STDERR;

my $acc = Stat::Acc->new();
ok($acc);
is($acc->avg, undef);
is($acc->dev, undef);

binmode $_, ":utf8" foreach \*STDOUT, \*STDERR;

my @X = (0..9);
$acc->add(@X);
is($acc->n, scalar @X);
is($acc->avg, 4.5);
is($acc->dev, 2.87228132326901);

