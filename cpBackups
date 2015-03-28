#!/bin/bash
#
# cpBackups - Copy Time Machine backups with bypass command
# mvbackups - Move Time Machine backups with bypass command
# rmBackups - Remove Time Machine backups with bypass command
#
# Written 28-Mar-2015 by Ronald Joe Record <rr at ronrecord dot com>
#
# Depending on how this command is invoked (cpBackups, mvBackups, or rmBackups)
# or what arguments are supplied on the command-line, this will copy, move,
# or remove Time Machine backups using the bypass command
#
# A simple "mv ..." or even "sudo mv ..." wouldn't work on Time Machine
# backups as I got many many "operation not permitted" failures.
# Same for attempted copies and removal. Use of the bypass command avoids this.
#

OLD_BACKUP_DB="/Volumes/My_Book_Studio/Backups.backupdb"
NEW_BACKUP_DB="/Volumes/LaCie_8TB/Backups.backupdb"
BYPASS="/System/Library/Extensions/TMSafetyNet.kext/Contents/Helpers/bypass"
SHOWME=
SHOW_USAGE=
CMD=`basename $0`
COMMAND=
COMWORD=
CP_CMD="cp -a"
MV_CMD="mv"
RM_CMD="rm -rf"

usage() {
    printf "\nUsage: $CMD [-cmr] [-n] [-b path-to-bypass]\n"
    printf "\t[-s path-to-source-db] [-d path-to-destination-db] [-u]\n"
    printf "\nWhere:\n"
    printf "\t-c indicates to copy backup database\n"
    printf "\t-m indicates to move backup database\n"
    printf "\t-r indicates to remove backup database\n"
    printf "\t-n indicates no execution, just tell me what you would do\n"
    printf "\t-b path-to-bypass specifies the location of the bypass command\n"
    printf "\t-s path-to-source-db specifies the previous backup location\n"
    printf "\t-d path-to-destination-db specifies the new backup location\n"
    printf "\t-u prints this usage message and exits\n"
    printf "\nWith these arguments I would execute the following command:\n"
    printf "\nsudo ${BYPASS} ${COMMAND} ${OLD_BACKUP_DB} ${NEW_BACKUP_DB}\n\n"
    exit 1
}

while getopts b:cd:mrs:nu flag; do
    case $flag in
        b)
            BYPASS="$OPTARG";
            ;;
        c)
            [ "${COMMAND}" ] && {
                printf "\nYou can only specify one of -c, -m, and -r"
                printf "\nExiting.\n"
                usage
            }
            COMMAND="${CP_CMD}";
            COMWORD="copy"
            ;;
        d)
            NEW_BACKUP_DB="$OPTARG";
            ;;
        m)
            [ "${COMMAND}" ] && {
                printf "\nYou can only specify one of -c, -m, and -r"
                printf "\nExiting.\n"
                usage
            }
            COMMAND="${MV_CMD}";
            COMWORD="move"
            ;;
        r)
            [ "${COMMAND}" ] && {
                printf "\nYou can only specify one of -c, -m, and -r"
                printf "\nExiting.\n"
                usage
            }
            COMMAND="${RM_CMD}";
            COMWORD="remove"
            ;;
        s)
            OLD_BACKUP_DB="$OPTARG";
            ;;
        n)
            SHOWME=1;
            ;;
        u)
            SHOW_USAGE=1;
            ;;
    esac
done
shift $((OPTIND - 1));

[ "${COMMAND}" ] || {
    # Default to how we were invoked
    case $CMD in
        cpBackups)
            COMMAND="${CP_CMD}";
            COMWORD="copy"
            ;;
        mvBackups)
            COMMAND="${MV_CMD}";
            COMWORD="move"
            ;;
        rmBackups)
            COMMAND="${RM_CMD}";
            COMWORD="remove"
            ;;
    esac
}

[ "${COMMAND}" ] || {
    printf "\nMust be invoked as cpBackups, mvBackups, or rmBackups."
    printf "\nExiting.\n"
    usage
}

# Check location of bypass command
[ -x "${BYPASS}" ] || {
    # Uh oh, maybe Apple moved it again. Try to locate bypass.
    POSSIBLE=`locate /bypass | grep -v xml | grep -v html`
    [ -x "${POSSIBLE}" ] || {
        printf "\n\n$BYPASS does not exist or is not executable.\nExiting.\n"
        usage
    }
    BYPASS="${POSSIBLE}"
}

# Check location of backup directory to move
[ -d "${OLD_BACKUP_DB}" ] || {
    printf "\n\n$OLD_BACKUP_DB does not exist or is not a directory."
    printf "\nExiting.\n"
    usage
}

# Check location of backup directory destination (mv or cp only)
[ "${COMMAND}" = "${RM_CMD}" ] || {
    [ -d "${NEW_BACKUP_DB}" ] && {
        printf "\n\n$NEW_BACKUP_DB already exists."
        printf "\nExiting.\n"
        usage
    }
}

[ "${SHOW_USAGE}" ] && usage

printf "\nUsing ${BYPASS}\nto ${COMWORD} Time Machine backups at:"
printf "\n\t${OLD_BACKUP_DB}\n"
[ "${COMMAND}" = "${RM_CMD}" ] || {
    printf "to\n\t${NEW_BACKUP_DB}\n"
}

[ "$SHOWME" ] || {
    while true
    do
        read -p "Are you sure you want to proceed ? (y/n) " yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) printf "\nExiting.\n"; usage;;
                * ) echo "Please answer yes or no.";;
        esac
    done
}

[ "$SHOWME" ] && {
    printf "\n\nWould execute the following command:\n"
    printf "\nsudo ${BYPASS} ${COMMAND} ${OLD_BACKUP_DB} ${NEW_BACKUP_DB}\n\n"
    exit 0
}

printf "\nWill ${COMWORD} Time Machine backups at:"
printf "\n\t${OLD_BACKUP_DB}\n"
[ "${COMMAND}" = "${RM_CMD}" ] || {
    printf "to\n\t${NEW_BACKUP_DB}\n"
}
printf "\nThis make take a while.\n"
sudo ${BYPASS} ${COMMAND} "${OLD_BACKUP_DB}" "${NEW_BACKUP_DB}"
