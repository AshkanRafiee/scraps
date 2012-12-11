# Requires convmv, unzip 6.00 (UTF support)
# TODO: Honor all original unzip options as well

usage()
{
cat << EOF
Usage: $0 [<options> ...] <filename>

Extract files honoring filename encodings, then convert them to UTF-8.
You can set the default behaviour within the script.

OPTIONS:
   -h              Show this message
   -d <directory>  Target directory
   -l <locale>     Language environment
   -f <codepage>   Source filename encoding
EOF
}

FILENAME=
TARGETDIR=.
LANGENV=ja_JP
FROMENCODE=shiftjis

TMPDIR=$(mktemp -d $(basename $0).XXXXXX)

while getopts “hd:l:f:v” OPTION
do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
        d)
         	TARGETDIR=$OPTARG
             ;;
        l)
            LANGENV=$OPTARG
            ;;
        f)
            FROMENCODE=$OPTARG
            ;;
        v)
            VERBOSE=1
            ;;
        ?)
            usage
            exit
            ;;
    esac
done

# The remaining argument is treated as the operand <filename>

shift $((OPTIND-1))

# now do something with $@
# check if multiple arguments (it's probably more sane to only do one filename at a time) -> help
# check if empty -> help
FILENAME=$@

if [[ -z $TARGETDIR ]] || [[ -z $LANGENV ]] || [[ -z $FROMENCODE ]]
then
    usage
    exit 1
fi

echo $FILENAME
echo $TARGETDIR
echo $LANGENV
echo $FROMENCODE
echo $TMPDIR

#LANG=$LANGENV unzip $FILENAME -d $TMPDIR/$TARGETDIR
#convmv --notest -r -f $FROMENCODE -t uft8 $TMPDIR/
#mv $TMPDIR/* $TMPDIR/.* .
rmdir $TMPDIR