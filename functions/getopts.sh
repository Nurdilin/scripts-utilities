function _usage {

    echo ""
    echo "USAGE: "
    echo "    getopts.sh [-b] [--longoption] [-f] [-d <seconds>]"
    echo ""
    echo "OPTIONS:"
    echo "    -b            bar"
    echo "    -d            delay. Default: 120"
    echo "    -f            foo"
    echo "    --longoption  non-gnu-supported-long-option"
    echo ""
    echo "EXAMPLE:"
    echo "    getopts.sh -f --longoption -d 10"
    echo ""
    # Exit and explain usage, if no argument(s) given.
    exit $E_OPTERROR
}

bad=0
delay=0

# Get options
# Note that getopts is not able to parse
# GNU-style long options (--myoption) or
# XF86-style long options (-myoption)!

#OPTIND
# Holds the index to the next argument to be processed.
# This is how getopts "remembers" its own status between invocations.
# Also useful to shift the positional parameters after processing with getopts.
# OPTIND is initially set to 1, and needs to be re-set to 1 if you want to parse anything again with getopts

#OPTARG
#This variable is set to any argument for an option found by getopts.
#It also contains the option flag of an unknown option.

#OPTERR	(Values 0 or 1)
# Indicates if Bash should display error messages generated by the getopts builtin
# The value is initialized to 1 on every shell startup - so be sure to always set it to 0 if you don't want to see annoying messages!
# OPTERR is not specified by POSIX for the getopts builtin utility — only for the C getopt() function in unistd.h (opterr).
# OPTERR is bash-specific and not supported by shells such as ksh93, mksh, zsh, or dash.


# The option-string tells getopts which options to expect and which of them must have an argument.
# The syntax is very simple — every option character is simply named as is, this example-string would tell getopts to look for -f, -A and -x:
#                getopts fAx VARNAME
# When you want getopts to expect an argument for an option, just place a : (colon) after the proper option flag.
# If you want -A to expect an argument (i.e. to become -A SOMETHING) just do:
#                getopts fA:x VARNAME

while getopts d:bf-: opt ;
do
    case $opt in
        d) delay=$OPTARG ;;
        b) echo "bar"    ;;
        f) echo "foo"    ;;
        -)  # long options support
            case $OPTARG in
                longoption) echo "longoption selected" ;;
                *)          bad=1; echo "Illegal option --$OPTARG" >&2 ;;
            esac ;;
        \?) bad=1 ;;
    esac
done

if [[ $bad -eq 1 ]] ; then
    _usage
fi

sleep $delay
echo "exiting"
