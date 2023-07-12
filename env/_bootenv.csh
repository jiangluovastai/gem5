# for bash boot env(mainly for windows only)

# add this line to .bashrc:
#       setenv BOOTED=0
#       alias bootcm='source env/_bootenv.bash'

if ( $BOOTED == 1 ) then
    echo "Already booted, plz use boot_clear to reset boot."
else
    setenv BOOTED 1

    set PROJECT_ROOT = `pwd`
    setenv PROJECT_ROOT `realpath $PROJECT_ROOT`
    alias go "cd $PROJECT_ROOT"

    setenv PROJECT 'oakss'

    #setenv PATH "$PROJECT_ROOT/util:$PROJECT_ROOT/flows:$PATH"
    
    set CUSTOM_SCR = $PROJECT_ROOT/.bootcm.csh
    if ( -f $CUSTOM_SCR ) then
        echo "Sourcing custom script: $CUSTOM_SCR"
        source $CUSTOM_SCR
    endif 

    echo "Booted to project $PROJECT"
endif
