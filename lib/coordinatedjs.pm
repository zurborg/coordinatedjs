use strict;
use warnings;
package coordinatedjs;
# ABSTRACT: coordinatedjs
use Dancer ':syntax';
use Time::HiRes qw(gettimeofday);

# VERSION

my $nowminjs = 'lib/now.min.js';
if (open my $fh, '<', $nowminjs) {
    $nowminjs = join '' => <$fh>;
} else {
    die "$nowminjs: $!\n";
}

sub nowjs {
    content_type 'text/javascript';
    local $_ = "$nowminjs";
    my $expr = quotemeta '%UNIXTIME%';
    my $time = sprintf '%0.06f' => Time::HiRes::time;
    s{$expr}{$time}e;
    $_;
};

sub unixtime {
    content_type 'text/javascript';
    header 'Timing-Allow-Origin' => '*';
    sprintf '%s(%0.06f)' => param('callback'), Time::HiRes::time;
}

sub nowphp {
    content_type 'application/php';
    local $_ = "$nowminjs";
    my $expr = quotemeta '%UNIXTIME%';
    my $repl = '<?php printf("%0.03f", microtime(true)); ?>';
    s{$expr}{$repl}e;
    $_;
}

my $momentminjs = 'moment/min/moment.min.js';
if (open my $fh, '<', $momentminjs) {
    $momentminjs = join '' => <$fh>;
} else {
    die "$momentminjs: $!\n";
}

sub fulljs {
    $momentminjs.nowjs();
};

my $momentlocalejs = 'moment/min/moment-with-locales.min.js';
if (open my $fh, '<', $momentlocalejs) {
    $momentlocalejs = join '' => <$fh>;
} else {
    die "$momentlocalejs: $!\n";
}

sub full_with_localesjs {
    $momentlocalejs.nowjs();
};

get '/now.js' => \&nowjs;
get '/now.php' => \&nowphp;
get '/full.js' => \&fulljs;
get '/full-with-locales.js' => \&full_with_localesjs;
get '/unixtime' => \&unixtime;
get '/' => sub { template 'index' };

true;
