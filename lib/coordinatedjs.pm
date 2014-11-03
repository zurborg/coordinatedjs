package coordinatedjs;
use Dancer ':syntax';
use Time::HiRes qw(gettimeofday);

our $VERSION = '0.1';

my $nowminjs = 'src/now.min.js';
if (open my $fh, $nowminjs) {
    $nowminjs = join '' => <$fh>;
} else {
    die "$nowminjs: $!\n";
}

sub nowjs {
    content_type 'text/javascript';
    local $_ = "$nowminjs";
    my $expr = quotemeta '%UNIXTIME%';
    my $time = sprintf '%0.03f' => Time::HiRes::time;
    s{$expr}{$time}e;
    $_;
};

my $momentminjs = 'moment/min/moment.min.js';
if (open my $fh, $momentminjs) {
    $momentminjs = join '' => <$fh>;
} else {
    die "$momentminjs: $!\n";
}

sub fulljs {
    $momentminjs.nowjs();
};

my $momentlocalejs = 'moment/min/moment-with-locales.min.js';
if (open my $fh, $momentlocalejs) {
    $momentlocalejs = join '' => <$fh>;
} else {
    die "$momentlocalejs: $!\n";
}

sub full_with_localesjs {
    $momentlocalejs.nowjs();
};

get '/now.js' => \&nowjs;
get '/full.js' => \&fulljs;
get '/full-with-locales.js' => \&full_with_localesjs;
get '/' => sub { template 'index' };

true;
