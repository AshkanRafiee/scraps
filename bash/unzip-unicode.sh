# Requires convmv, unzip 6.00 (UTF support)
# TODO: Honor all original unzip options as well

################################################################################

#
# Set defaults here
#

SOURCE_LOCALE=ja_JP
SOURCE_CODEPAGE=shiftjis

BIN_UNZIP=/usr/bin/unzip
BIN_CONVMV=/usr/bin/convmv

################################################################################

#
# Don't change things beyond this point unless you know what you are doing!
#

SOURCE_FILENAME=
TARGET_DIRECTORY=.
TEMP_DIRECTORY=$(mktemp -d $(basename $0).XXXXXX)

cleanup()
{
rm -rf $TEMP_DIRECTORY
}

usage()
{
cleanup

cat <<EOF
Usage: $0 [<options> ...] <filename>

Extract files honoring filename encodings, then convert them to UTF-8.
You can set the default behaviour within the script.

OPTIONS:
   -h              Show this message
   -d <directory>  Target directory
   -l <locale>     Source locale (e.g. ja_JP)
   -c <codepage>   Source codepage (e.g. shiftjis)
EOF
}

# Parse arguments

while getopts “hd:l:c:v” OPTION
do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
        d)
         	TARGET_DIRECTORY=$OPTARG
             ;;
        l)
            SOURCE_LOCALE=$OPTARG
            ;;
        c)
            SOURCE_CODEPAGE=$OPTARG
            ;;
        v)
            VERBOSE=1
            ;;
        ?)
            echo Try \`$0 -h\` for more information.
            exit
            ;;
    esac
done

if [[ -z $TARGET_DIRECTORY ]] || [[ -z $SOURCE_LOCALE ]] || [[ -z $SOURCE_CODEPAGE ]]; then
    echo $0: option requires an argument
    echo Try \`$0 -h\` for more information.
    exit 1
fi

# The remaining argument is treated as the operand <filename>

shift $((OPTIND-1))

if [ $# = 1 ]; then
    SOURCE_FILENAME=$@
else
    echo $0: requires one file operand
    echo Try \`$0 -h\` for more information.
    exit 1
fi

LANG=$SOURCE_LOCALE $BIN_UNZIP $SOURCE_FILENAME -d $TEMP_DIRECTORY
$BIN_CONVMV -r -f $SOURCE_CODEPAGE -t uft8 $TEMP_DIRECTORY
read -p "Does this look right to you?? " -n 1
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    cleanup
    exit 1
fi

$BIN_CONVMV --notest -r -f $SOURCE_CODEPAGE -t uft8 $TEMP_DIRECTORY

mv $TEMP_DIRECTORY/* $TEMP_DIRECTORY/.* $TARGET_DIRECTORY

cleanup
