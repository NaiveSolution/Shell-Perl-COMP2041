#!/usr/bin/perl

# Command Line Inputs:
# <filename.sh> x 1 .. n

# Description:
# Converts the shell script(s) <filename.sh> into a perl script called <filename.pl>.
# This perl script will loop through every line of shell script in <filename.sh>,
# save every line of the file into a perl array, and do processing on each
# line in the array to convert its contents to valid perl code. The whole file will be run through
# a series of modules, from start to finish, for each module. The first module does basic shell-perl conversion,
# while the later modules do stricter conversions.

# Written by Tariq

my $current_comment = "";
my $subroutine_flag = 0;

# Module: subset_zero
# Function: converts basic syntax of shell script to perl script, including 'echo', basic shell 
# assignment operations and external programs calls in shell to system calls in perl
sub subset_zero {
    # For the initial #!.. tag thing at the top of each script,
    # and for any other comments in the script.
    $_[0] =~ s/^#!.*/#!\/usr\/bin\/perl -w/;
    return if $_[0] =~ /^#[^!].*/;

    # Purge all comments from the current line, to be added in as the last step
    if ($_[0] =~ /\s+?#.*$/){
        $_[0] =~ s/(.+?)(\s+?#.*$)/$1/;
        $current_comment = $2;
    }

    # Convert && and || to "and" and "or"
    $_[0] =~ s/ && / and /g;
    $_[0] =~ s/ \|\| / or /g;

    # Shell has numerous assignment patterns which can take the forms:
    # x=y, x='y', x="y", x=$(command), x=$((y)), x=`y`, x=$y, x=y BOOLEAN y=z, x=($1|$2|$n), test x = y, x=$y$z$w
    #$_[0] =~ s/(test|\[) ['"]?(\S{0,10})['"]?\s*=\s*['"]?(\S{0,10})['"]?/('$1' eq '$2')/g;   # test x = y
    $_[0] =~ s/( *?)(\w{1,20})=(\d{1,20})$/$1\$$2 = $3;/g;             # x=digit
    $_[0] =~ s/( *?)(\w{1,20})=('|")+(.*)('|")+$/$1\$$2 = $3$4$5;/;  # x='y', x="y", x=''y'', x =""y"", x="$y $y"
    $_[0] =~ s/( *?)(\w{1,20})=(?!\$)(\S{1,20}\s*?)$/$1\$$2 = '$3';/g;       # x=y
    while ($_[0] =~ /(\$\w{1,20})(\$\w{1,20})/) {               # converts x=$y$z$w$... into x=$y.$z.$w.$...
        $_[0] =~ s/(\$\w{1,20})(\$\w{1,20})/$1.$2/;
    }
    $_[0] =~ s/( *?)(\w{1,10})=((\$\w{1,20})(\.\$?\w{1,20})?(\.\$?\w{1,20})?)/$1\$$2 = $3;/g;     # x=$y

    # replaces all x=$(y) and x=`y` with x = y, necessary for expr
    if ($_[0] =~ /^(\s*)(\w{1,10})=(\$\( *|`)(\b.*?)( *\)|`)/){
        $replacement = $4;
        $replacement =~ s/"|'|echo//g;             # removes all double quotes from the arguments
        $_[0] =~ s/^(\s*)(\w{1,10})=(\$\( *|`)echo (\b.*?)( *\)|`)/$1\$$2 = system "echo $replacement";/g;
        $_[0] =~ s/^(\s*)(\w{1,10})=(\$\( *|`)(?!expr)(\b.*?)( *\)|`)/$1\$$2 = system "$replacement";/g;
        $_[0] =~ s/^(\s*)(\w{1,10})=(\$\( *|`)expr (\S.*?)( *\)|`)/$1\$$2 = $replacement;/g;
        $_[0] =~ s/expr //g;
    }
    $_[0] =~ s/(\$\(|`)(\b.*?)(\)|`)/$2/g; # remove backticks
    # If an echo command has a double quote inside the outer single quotes, terminate
    # the inner double quote with a '\'. Echo may precede another command.
    if ($_[0] =~ /( |\t)*echo +(?!-n ).*$/ && $_[0] =~ /^((?!system).)*$/){
        if ($_[0] =~ /( |\t)*echo '.*/){
            $_[0] =~ s/"/\\"/g;
            $_[0] =~ s/( *\t*)echo ['"]?(.*\b[,\. ]?).?/$1print "$2\\n";/;
        } 
        if ($_[0] =~ /( |\t)*echo \$\(\( *(.*) *\)\)/){
            $_[0] =~ s/'|"//g;
            $_[0] =~ s/( *\t*)echo \$\(\( *(.*) *\)\)/$1print "$2";/g;
        }
        if ($_[0] =~ /( |\t)*echo `(.*)`/){
            $_[0] =~ s/'|"//g;
            $_[0] =~ s/( *\t*)echo `(.*)`/$1system "$2";/g;
        }
        if ($_[0] =~ /( *\t*)echo (.*)/){
            $_[0] =~ s/'|"//g;
            $_[0] =~ s/( *\t*)echo "?(.*[,\. ]*)"?/$1print "$2\\n";/;
        }
    }

    # Check if there are any external programs that are being run besides the ones in the assignment spec.
    # NOTE: I have removed some programs from the list as they are most likely not going to be used.
    if ($_[0] =~ /^((?!system).)*$/){
        if ($_[0] =~ /( *\t*)(basename|cat|chmod|cmp|cp|cut|date|df|diff|dirname|false|[fe]?grep|find|head|id|less|ln|ls|mkdir|more|mv|printf|pwd|realpath|rm|rmdir|sed|seq|sort|tac|tail|time|top|touch|tr|true|uniq|wc|which|who|xargs)(.*)$/){
            $r = $3;
            $r =~ s/"|'//g;
            # for system calls of the form "<call> <arguments>"
            $_[0] =~ s/^( *\t*)(basename|cat|chmod|cmp|cp|cut|date|df|diff|dirname|false|[fe]?grep|find|head|id|less|ln|ls|mkdir|more|mv|printf|pwd|realpath|rm|rmdir|sed|seq|sort|tac|tail|time|top|touch|tr|true|uniq|wc|which|who|xargs) (.*)\n?/$1system "$2 $r";\n/;
            # for system calls of the form "<statements> <call> <arguments>"
            $_[0] =~ s/( *\t*)(if|while|for|in) +(basename|cat|chmod|cmp|cp|cut|date|df|diff|dirname|false|[fe]?grep|find|head|id|less|ln|ls|mkdir|more|mv|printf|pwd|realpath|rm|rmdir|sed|seq|sort|tac|tail|time|top|touch|tr|true|uniq|wc|which|who|xargs) (.*)\n?/$1$2 (system "$3 $r")\n/;
            # for system calls of the form "<call>"
            $_[0] =~ s/^( *\t*)(basename|cat|chmod|cmp|cp|cut|date|df|diff|dirname|false|[fe]?grep|find|head|id|less|ln|ls|mkdir|more|mv|printf|pwd|realpath|rm|rmdir|sed|seq|sort|tac|tail|time|top|touch|tr|true|uniq|wc|which|who|xargs)$/$1system "$r";/;
        }
    }
}

# Module: subset_one
# Function: converts most of the test and [] functionality in shell to perl, and 
# converts shell for loops into perl for loops
sub subset_one {
    if ($_[0] =~ /print +.*$/){
        return;
    }

    # Check if the following programs are in the current line: exit, read, cd, test
    if ($_[0] =~ /( *\t*)(exit|read|cd|test|\[|!=|>=|<=|-eq|-lt|-ne|-gt|-le|-ge|<|>|=|-a|-o)\s\n?.*/){
        $_[0] =~ s/( *\t*)exit[\s]?(\d*)/$1exit $2;/;
        $_[0] =~ s/( *\t*)cd (.*)/$1chdir '$2';/;
        $_[0] =~ s/while +\t*read (\w{1,10})/while (my \$$1 = <>)/;
        $_[0] =~ s/( *\t*)read (\w{1,10})/$1\$$2 = <STDIN>;\n$1chomp \$$2;/;
        $_[0] =~ s/-o/||/g;
        $_[0] =~ s/-a/&&/g;

        # The following code is for all testing statements that use [ x = y ] 
        # such as: if [ "$1" != "-a" ] && [ '$2' != '-m' ] || [ a = b ]

        # for testing of:  ... [ $((<val>)) <op> <val> ] or test $((<val>)) <op> <val>
        $_[0] =~ s/(\[ |test )?(\$\(\(!? *\S{1,20} \S+ \S{1,20}\)\)) +-le +(\S{1,20}\b"?)( ?\])?/($2 <= $3)/g;
        $_[0] =~ s/(\[ |test )?(\$\(\(!? *\S{1,20} \S+ \S{1,20}\)\)) +-lt +(\S{1,20}\b"?)( ?\])?/($2 < $3)/g;
        $_[0] =~ s/(\[ |test )?(\$\(\(!? *\S{1,20} \S+ \S{1,20}\)\)) +-gt +(\S{1,20}\b"?)( ?\])?/($2 > $3)/g;
        $_[0] =~ s/(\[ |test )?(\$\(\(!? *\S{1,20} \S+ \S{1,20}\)\)) +-ge +(\S{1,20}\b"?)( ?\])?/($2 >= $3)/g;
        $_[0] =~ s/(\[ |test )?(\$\(\(!? *\S{1,20} \S+ \S{1,20}\)\)) +-eq +(\S{1,20}\b"?)( ?\])?/($2 == $3)/g;
        $_[0] =~ s/(\[ |test )?(\$\(\(!? *\S{1,20} \S+ \S{1,20}\)\)) +-ne +(\S{1,20}\b"?)( ?\])?/($2 != $3)/g;
        # for testing of:  ... [ <val> <op> <val> ] or test <val> <op> <val>
        $_[0] =~ s/(\[ |test )?(!? *\S{1,20}) +-le +(\S{1,20}\b"?)( ?\])?/($2 <= $3)/g;
        $_[0] =~ s/(\[ |test )?(!? *\S{1,20}) +-lt +(\S{1,20}\b"?)( ?\])?/($2 < $3)/g;
        $_[0] =~ s/(\[ |test )?(!? *\S{1,20}) +-gt +(\S{1,20}\b"?)( ?\])?/($2 > $3)/g;
        $_[0] =~ s/(\[ |test )?(!? *\S{1,20}) +-ge +(\S{1,20}\b"?)( ?\])?/($2 >= $3)/g;
        $_[0] =~ s/(\[ |test )?(!? *\S{1,20}) +-eq +(\S{1,20}\b"?)( ?\])?/($2 == $3)/g;
        $_[0] =~ s/(\[ |test )?(!? *\S{1,20}) +-ne +(\S{1,20}\b"?)( ?\])?/($2 != $3)/g;
        # I know i could have done these better, but i have been testing regexes for so long that it has
        # broken my will to live.

        # Simply adding single quotes around an operand for string equality will break the perl script
        # if the operand takes the form of $<variable>, so we have to account for that in the following code
        if ($_[0] =~ /(\[ |test )+(!? *\S{1,20} +!?= +\S{1,20}) ?\]?/){
            # remove " and ' from the variables, if they exist
            $_[0] =~ s/("|')//g;
            # if the first operand has a $ in front of it, then dont add ' quotes
            $_[0] =~ s/(\[ |test )+(!? *\$+\S{1,20}) += ((?<!\$)\w{1,20}) ?\]?/($2 eq '$3')/g;
            $_[0] =~ s/(\[ |test )+(!? *\$+\S{1,20}) +!= ((?<!\$)\w{1,20}) ?\]?/($2 ne '$3')/g;
            # if the second operand has $ in front of it
            $_[0] =~ s/(\[ |test )+(!? *(?<!\$)\w{1,20}) += (\$+\S{1,20}) ?\]?/('$2' eq $3)/g;
            $_[0] =~ s/(\[ |test )+(!? *(?<!\$)\w{1,20}) +!= (\$+\S{1,20}) ?\]?/('$2' ne $3)/g;
            # if both operands have a $ in front of them
            $_[0] =~ s/(\[ |test )+(!? *\$+\S{1,20}) += (\$+\S{1,20}) ?\]?/($2 eq $3)/g;
            $_[0] =~ s/(\[ |test )+(!? *\$+\S{1,20}) +!= (\$+\S{1,20}) ?\]?/($2 ne $3)/g;
            # no operand has a $ in front of it
            $_[0] =~ s/(\[ |test )+(!? *\w{1,20}) += (\w{1,20}) ?\]?/('$2' eq '$3')/g;
            $_[0] =~ s/(\[ |test )+(!? *\w{1,20}) +!= (\w{1,20}) ?\]?/('$2' ne '$3')/g;
        }

        # For all testing statements that use [ -option <target> ] or test -option <target>, or test <target> or [ <target> ]
        # such as: if [ -d /dev/null ] OR test -r somefile
        $_[0] =~ s/(\[|test) +(! |-r |-d |-e )?"?(\$\S{1,20}\b)"? ?\]?$/($2$3)/g;
        $_[0] =~ s/(\[|test) +(! |-r |-d |-e )?"?(\S{1,20}\b)"? ?\]?$/($2'$3')/g;
        # Combine statements that take the form (.*) && (.*) or (.*) || (.*)
        $_[0] =~ s/(\(.*)\)(\s*(\|\||&&)\s*)\((.*\))/$1 $3 $4/g;
    }
    
    # For loops can take the form: for x in y; do [OR] for x in y \n do \n 
    # The following is for the first case: for x in y; do
    if ($_[0] =~ /for +\t*(\w{1,10}) +\t*in +\t*(.*\S) ?; +\t*do\n/){
        if ($2 =~ /[\*\?\[]+/){ # if the for loop is for opening files
            $_[0] =~ s/for +\t*(\w{1,10}) +\t*in +\t*(.*); +\t*do\n/foreach \$$1 (glob("$2")) {\n/;
            return;
        }
        $replacement = $2;
        $replacement =~ s/ /','/g;
        $_[0] =~ s/for +\t*(\w{1,10}) +\t*in +\t*.*; +\t*do\n/foreach \$$1 ('$replacement') {\n/;
    }

    # The following is for the second case: for x in y \n do \n
    if ($_[0] =~ /for +\t*(\w{1,10}) +\t*in +\t*(.*)\n/){
        if ($2 =~ /[\*\?\[]+/){ # if the for loop is for opening files
            $_[0] =~ s/for +\t*(\w{1,10}) +\t*in +\t*(.*)\n/foreach \$$1 (glob("$2")) {\n/;
            return;
        }
        $replacement = $2;
        $replacement =~ s/ /','/g;
        $_[0] =~ s/for +\t*(\w{1,10}) +\t*in +\t*.*\n/foreach \$$1 ('$replacement') {\n/;
    }

    # Clean up the done's and do's that are on a line by themselves 
    $_[0] =~ s/( *|\t*)done *\t*$/$1}/;
    $_[0] =~ s/( *|\t*)do *\t*\n//;
}

# Module: subset_two
# Function: converts some of the special shell variables, shell if/elif/else statements and 
# shell while loops into perl special variables, perl if statements and perl while loops
sub subset_two {
    # Convert the shell special arguments into perl special arguments
    while ($_[0] =~ /"?\$([1-9])+"?(\n|\.)?/){
        $new_argv = $1 - 1;
        while ($_[0] =~ /"?\$([1-9])+"?(\w{1,20})/) {               # converts x=$y$z$w$... into x=$y.$z.$w.$...
            $_[0] =~ s/"?\$([1-9])+"?(\w{1,20})/\$ARGV\[$new_argv\].$2/;
        }
        if ($subroutine_flag){
            $_[0] =~ s/"?\$([1-9])+"?(\n|\.)?/\$_\[$new_argv\]$2/;
        } else {
            $_[0] =~ s/"?\$([1-9])+"?(\n|\.)?/\$ARGV\[$new_argv\]$2/;
        }
    }

    if ($_[0] =~ /print +.*$/){
        return;
    }

    # IF, ELIF, ELSE
    # if statements can take the form: if <statement>; then
    $_[0] =~ s/\bif\b (.*); then\n/if $1 {\n/g;
    # if statements can also take the form: if <statement> \n then \n
    $_[0] =~ s/\bif\b (.*)(?<!{)\n/if $1 {\n/g;
    # elif statements can take the form: elif <statement>; then
    $_[0] =~ s/\belif\b (.*); then\n/} elsif $1 {\n/g;
    # elif statements can also take the form: elif <statement> \n then \n
    $_[0] =~ s/\belif\b (.*)(?<!{)\n/} elsif $1 {\n/g;
    # else statements take the form: else\n
    $_[0] =~ s/\belse\b\n/} else {\n/g;

    # While takes the forms: while <statement>\n do \n OR while <statement>; do\n
    $_[0] =~ s/\bwhile\b (.*); do\n/while $1 {\n/g;
    $_[0] =~ s/\bwhile\b (.*)\n/while $1 {\n/g;
    $_[0] =~ s/\bwhile true/while (1)/g;
    # Clean up the fi's and then's that are on a line by themselves
    $_[0] =~ s/^(\s*)fi *\t*(?=$)/$1}/;
    $_[0] =~ s/^(\s*)then[\s]+//;
}

# Module: subset_three
# Function: converts more shell special variables, and takes into account if these special variables are in
# a function - all of which can have a drastic syntactic change in perl. Also converts the $() and $(()), and 
# some other keywords in shell such as echo -n, break, local.
sub subset_three {
    
    # Convert some more shell special arguments into perl special arguments
    $_[0] =~ s/"?\$@"?(\n\s)?/\@ARGV$1/g;
    $_[0] =~ s/"?\$#"?(\n\s)?/\$#ARGV + 1$1/g;
    $_[0] =~ s/"?\$\*"?(\n|\s)?(\\n")?/join(" ", \@ARGV)$1/g;
    $_[0] =~ s/^(.*)return[\s]?(\d)?/$1return $2;/;
    $_[0] =~ s/"?'?\@ARGV"?'?(\n\s)?/\@ARGV$1/g;
    if ($_[0] =~ /print +.*$/){
        return;
    }

    # Copied from subset 0
    if ($_[0] =~ /(\s*)echo -n .*/){
        if ($_[0] =~ /echo -n '.*/){
            $_[0] =~ s/"/\\"/g;
            $_[0] =~ s/(\s*)echo -n ['"]?(.*\b).?/$1print "$2";/;
        }
        if ($_[0] =~ /echo -n (.*)/){
            $_[0] =~ s/(\s*)echo -n ['"]?(.*\b).?/$1print "$2";/;
        }
    }

    # For the x=$((<expression>)) arithmetic operation
    if ($_[0] =~ /(\s?)(\S{1,20})=\$\(\((.*)\)\)/){
        $r = $3;
        $r =~ s/"|'//g;
        $r =~ s/(\b(?<!\$)[^\d\s\W]{1,20})/\$$1/g;
        $_[0] =~ s/(\s?)(\S{1,20})=\$\(\((.*)\)\)/$1\$$2 = $r;/g;
    }

    # For the $((<expression>)) arithmetic operation
    if ($_[0] =~ /\$\(\((.*)\)\)/){
        $r = $1;
        $r =~ s/("|')//g;
        $r =~ s/(\b(?<!\$)[^\d\s\W]{1,20})/\$$1/g;
        $_[0] =~ s/( |\t)?(\[ |test )?\$\(\((.*)\)\)/$1$r/g;
    }

    # Convert "local <arguments>" into "my <$arguments>"
    if ($_[0] =~ /( |\t*)local (.*)$/) {
        $r = $2;
        $r =~ s/\b(?<!\$)(\w.*?\b)/\$$1,/g;
        $r =~ s/(.*),/($1)/g;
        $_[0] =~ s/( |\t*)local (.*)$/$1my $r;/g;
    }

    # Convert subroutine signatures
    if ($_[0] =~ /(\w{1,20})\(\) ?{/){
        $_[0] =~ s/(\w{1,20})\(\) ?{/sub $1 {/g;
        $subroutine_flag = 1;
    }

    $_[0] =~ s/( |\t*)break *$/$1last;/g;
    # When the end of a subroutine is found, turn off the subroutine flag. This flag is used to determine
    # if $1, $2 ... $9 are converted to $ARGV[0] or $_[0]
    if ($_[0] =~ /( |\t)?}/){
        $subroutine_flag = 0;
    }
}

while ($line = <>){
    #print "original line: $line";
    subset_zero($line);
    #print "after subset 0: $line";
    subset_one($line);
    #print "after subset 1: $line";
    subset_two($line);
    #print "after subset 2: $line";
    subset_three($line);
    #print "after subset 3: $line";
    
    if ($current_comment ne ""){
        chomp $line;
        $line = $line . "$current_comment\n";
    }
    
    push @lines, $line;
    $current_comment = '';
}

print (@lines);
print "\n";