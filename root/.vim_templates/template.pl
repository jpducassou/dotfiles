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

=over

=item B<help, h>

Print a brief help message and exits.

=back

=head1 AUTHOR

<AUTHOR> - L<<EMAIL>>

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=head1 NO WARRANTY

This software is provided "as-is," without any express or implied warranty.
In no event shall the author be held liable for any damages arising from the use of the software.

=cut

# ============================================================================
sub main {

	GetOptions(
		'help|h'     => sub { pod2usage(0); },
		'verbose|v+' => \$VERBOSE,
		'debug|d'    => sub { $VERBOSE = 1; $DEBUG = 1; }
	) or pod2usage(2);

	# implementation here
	return;

}

# ============================================================================
1;
