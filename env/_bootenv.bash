# for bash boot env(mainly for windows only)

# add this line to .bashrc:
#       export BOOTED=0
#       alias bootcm='source env/_bootenv.bash'

if [ $BOOTED == "1" ]; then
    echo "Already booted, plz use boot_clear to reset boot."
else
    export BOOTED=1

    PROJECT_ROOT=`pwd`
    export PROJECT_ROOT=`realpath $PROJECT_ROOT`
    alias go="cd $PROJECT_ROOT"
    alias bc="boot_clear"

    export PROJECT='gem5'

    export PATH="$PROJECT_ROOT/util:$PROJECT_ROOT/flows:$PATH"
    
    CUSTOM_SCR=$PROJECT_ROOT/.bootcm.bash
    if [ -e $CUSTOM_SCR ]; then
        echo "Sourcing custom script: $CUSTOM_SCR"
        source $CUSTOM_SCR
    fi

    echo "Booted to project $PROJECT"
fi
