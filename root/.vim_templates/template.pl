#!/usr/bin/env perl

# ============================================================================
use strict;
use warnings;
use utf8;

# ============================================================================
use Data::Dumper;
use Try::Tiny;
use Getopt::Long;
use Pod::Usage;

# ============================================================================
our $VERSION = '0.1';
my $VERBOSE = 0;
my $DEBUG   = 0;

# ============================================================================
main(@ARGV) unless caller();

# ============================================================================
=pod

=head1 NAME

<FILENAME>

=head1 SYNOPSIS

<FILENAME> --help

=head1 OPTIONS

=item B<help, h>

Print a brief help message and exits.

=head1 AUTHOR

<AUTHOR> - <EMAIL>

=head1 COPYRIGHT AND DISCLAIMER

=cut

# ============================================================================
sub main {

	GetOptions(
		'help|h'	   => sub { pod2usage(0); },
		'verbose|v+' => \$VERBOSE,
		'debug|d'	   => sub { $VERBOSE = 1; $DEBUG = 1; }
	) or pod2usage(2);

	# implementation here
	return;

}

# ============================================================================
1;
