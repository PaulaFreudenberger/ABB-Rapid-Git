MODULE modDummy
    
        !***********************************************************!
    !                           Punkte                          !
    !***********************************************************!

    ! position before dummy tray
    PERS robtarget posPreDummy:=[[245.61,-95.36,-654.56],[0.273127,0.649156,0.656078,0.27122],[1,-1,-4,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    ! Dummy position 1
    PERS robtarget posDummy1:=[[391.05,-226.33,-563.68],[0.273472,0.648907,0.656086,0.271448],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy1Above:=[[391.04,-226.32,-550.24],[0.273428,0.648903,0.656122,0.271415],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy1InFront:=[[319.21,-226.31,-550.24],[0.27341,0.64893,0.656106,0.271408],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    ! Dummy position 2
    PERS robtarget posDummy2:=[[391.25,-156.11,-563.97],[0.273305,0.648976,0.65613,0.271345],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy2Above:=[[391.22,-156.10,-551.01],[0.273196,0.64903,0.656139,0.271303],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy2InFront:=[[333.41,-156.09,-551.01],[0.273177,0.649031,0.656148,0.271299],[1,-1,-4,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    ! Dummy position 3
    PERS robtarget posDummy3:=[[391.35,-85.75,-564.15],[0.273182,0.649108,0.656081,0.271271],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy3Above:=[[391.34,-85.75,-550.60],[0.273147,0.649122,0.656096,0.271239],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy3InFront:=[[362.34,-85.73,-550.58],[0.27315,0.649146,0.656074,0.271229],[1,-1,-4,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    ! Dummy position 4
    PERS robtarget posDummy4:=[[391.99,-226.89,-743.40],[0.273153,0.649142,0.656082,0.271215],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy4Above:=[[391.99,-226.89,-730.45],[0.273148,0.649142,0.656093,0.271194],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy4InFront:=[[342.31,-226.88,-730.45],[0.273134,0.649151,0.656094,0.271185],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    ! Dummy position 5
    PERS robtarget posDummy5:=[[392.16,-156.64,-743.80],[0.273036,0.649144,0.656159,0.271144],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy5Above:=[[392.15,-156.63,-731.16],[0.273039,0.649153,0.656138,0.271169],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy5InFront:=[[332.16,-156.62,-731.16],[0.27302,0.649191,0.656111,0.271165],[1,-1,-4,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    ! Dummy position 6 
    PERS robtarget posDummy6:=[[392.25,-86.21,-743.92],[0.272906,0.649212,0.656142,0.271154],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy6Above:=[[392.24,-86.21,-731.08],[0.272899,0.649208,0.656156,0.271136],[1,-1,-3,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    PERS robtarget posDummy6InFront:=[[334.39,-86.21,-731.08],[0.272926,0.649193,0.656148,0.271165],[1,-1,-4,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
            
    !***********************************************************!
    !                       Variablen                           !
    !***********************************************************!
    
    VAR wzstationary wzStDummy;           !working area dummy tray
    
    local var robtarget posTemp;
    
    ! stores all dummy positions
    local vAR robtarget arrDummy{6};
    !stores all dummy positions above
    local vAR robtarget arrDummyAbove{6};
    ! stores all dummy positions in front of
    local vAR robtarget arrDummyInFront{6};

    !***********************************************************!
    !                       Konstanten                          !
    !***********************************************************!   
    
    
    !***********************************************************!
    !       Wird beim PowerUp des Roboters ausgefuehrt          !
    !***********************************************************!
    PROC procDummyPowerUp()
        
       !box dummy
        procBoxDummy wzStDummy;

    ENDPROC

        
    !***********************************************************!
    !                 Modul initialisieren                      !
    !***********************************************************!
    PROC procInitDummy()
                                
        ! store all dummy positions in array
        arrDummy{1}:=posDummy1;
        arrDummy{2}:=posDummy2;
        arrDummy{3}:=posDummy3;
        arrDummy{4}:=posDummy4;
        arrDummy{5}:=posDummy5;
        arrDummy{6}:=posDummy6;

        ! store all dummy positions above
        arrDummyAbove{1}:=posDummy1Above;
        arrDummyAbove{2}:=posDummy2Above;
        arrDummyAbove{3}:=posDummy3Above;
        arrDummyAbove{4}:=posDummy4Above;
        arrDummyAbove{5}:=posDummy5Above;
        arrDummyAbove{6}:=posDummy6Above;

        ! store all dummy positions above
        arrDummyInFront{1}:=posDummy1InFront;
        arrDummyInFront{2}:=posDummy2InFront;
        arrDummyInFront{3}:=posDummy3InFront;
        arrDummyInFront{4}:=posDummy4InFront;
        arrDummyInFront{5}:=posDummy5InFront;
        arrDummyInFront{6}:=posDummy6InFront;
        
    ENDPROC

    
    !***********************************************************!
    !                   Check actual Dummy                     !
    !***********************************************************!
    FUNC bool CheckDummy(inout num nDummyNo,inout num nSide)
    
        vAR bool arrDummyPositions{6};

        arrDummyPositions{1}:= (I_diDummyPos1=1);
        arrDummyPositions{2}:= (I_diDummyPos2=1);
        arrDummyPositions{3}:= (I_diDummyPos3=1);
        arrDummyPositions{4}:= (I_diDummyPos4=1);
        arrDummyPositions{5}:= (I_diDummyPos5=1);
        arrDummyPositions{6}:= (I_diDummyPos6=1);

        ! init values
        nSide:=0;
        nDummyNo:=0;
        
        ! check actual dummy no
        If ( I_diRTRdyToPick_A  = 1) and (I_diDummyA=1) AND (I_giDummyCodeA>=1) AND (I_giDummyCodeA<=6) THEN 
        
            ! check if dummy pos is free
            IF  (arrDummyPositions{I_giDummyCodeA}=false) THEN
                nSide:=1;
                nDummyNo:=I_giDummyCodeA;
                RETURN TRUE;
            endif

        ENDIF        

                ! check actual dummy no
        If ( I_diRTRdyToPick_B  = 1) and (I_diDummyB=1) AND (I_giDummyCodeB>=1) AND (I_giDummyCodeB<=6) THEN 
        
            ! check if dummy pos is free
            IF  (arrDummyPositions{I_giDummyCodeB}=false) THEN
                nSide:=2;
                nDummyNo:=I_giDummyCodeB;            
                RETURN TRUE;
            endif

        ENDIF        

        RETURN FALSE;
        
    ENDfunc

    !***********************************************************!
    !       set part from dummy position to rotary table        !
    !***********************************************************!
    PROC procPickPlaceDummy()
        var bool bResult;
        VAR num nSide;
        VAR num nDummyNo;
        
        ! check dummy ready for picking
        bResult:=CheckDummy( nDummyNo,nSide);
        
        ! Bereit zum Feder montieren
        IF (bPartInGripper = FALSE)
        AND bResult
        and ( I_diRTMechanicalFree = 1) 
        and ( I_diDummyMechanicalFree = 1) THEN
                        
            ! drive homereturn
            HomeReturn;
                                                          
                ! select the active RT position
                IF (nSide=1) THEN
        
                    ! above rt
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                    MoveJ posOverRT,Speed,z150, tool0;

                    ! drive in pre position
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                    MoveJ posInFronPickRT_A ,Speed,z10, tool0;

                    ! drive in pre position
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                    MoveL posAbovePickRT_A ,Speed,z1, tool0;

                    ! drive in position
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed*0.2;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed*0.2;
                    MoveL posPickRT_A ,Speed,fine, tool0;
                    WaitRob \InPos;
                    
                    ! close gripper
                    Set O_doGrip;
                    
                    ! wait time till gripper closed
                    WaitTime 0.1;

                    bPartInGripper := true;

                    ! drive in pre position
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed*0.1;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed*0.1;
                    MoveL posAbovePickRT_A ,Speed,z1, tool0;

                    ! drive in pre position
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                    MoveL posInFronPickRT_A ,Speed,z10, tool0;

                    ! above rt
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                    MoveJ \Conc, posOverRT,Speed,z150, tool0;
                    
                    ! HS Station
                    Set O_doRTPicked_A;
                    WaitDI I_diRTRdyToPick_A , 0;
                    Reset O_doRTPicked_A;

                ! pick B position    
                ELSE
           
                    ! drive in pre position
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                    MoveJ posInFrontPickRT_B ,Speed,z5, tool0;

                    ! drive in pre position
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                    MoveL posAbovePickRT_B ,Speed,z1, tool0;

                    ! drive in position
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed*0.1;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed*0.1;
                    MoveL posPickRT_B ,Speed,fine, tool0;
                    WaitRob \InPos;
                    
                    ! close gripper
                    Set O_doGrip;
                    
                    ! wait time till gripper closed
                    WaitTime 0.1;

                    bPartInGripper := true;

                    ! drive in pre position
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed*0.1;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed*0.1;
                    MoveL posAbovePickRT_B ,Speed,z1, tool0;

                    ! drive in pre position
                    Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                    Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                    MoveL \Conc, posInFrontPickRT_B ,Speed,z20, tool0;
                    
                    ! HS Station
                    Set O_doRTPicked_B;
                    WaitDI I_diRTRdyToPick_B , 0;
                    Reset O_doRTPicked_B;
                    
                endif                    
                
            !   Auf Position Home fahren
            Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
            Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
            MoveJ Home,Speed,z50,tool0;

            ! drive on pre position
            Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
            Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
            MoveJ posPreDummy ,Speed,z30,tool0;
            
            ! drive in front of dummy
            Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
            Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
            MoveL arrDummyInFront{nDummyNo} ,Speed,z30,tool0;
                
                ! drive above dummy
                Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed*0.1;
                Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed*0.1;
                MoveL arrDummyAbove{nDummyNo}, Speed , z10, tool0;

                ! drive in dummy position
                Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed*0.1;
                Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed*0.1;
                MoveL arrDummy{nDummyNo}, Speed , fine, tool0;
                WaitRob \InPos;

                ! open gripper
                Reset O_doGrip;
                WaitTime 0.1;
                bPartInGripper := false;
                
                ! drive above dummy
                Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed*0.1;
                Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed*0.1;
                MoveL arrDummyAbove{nDummyNo}, Speed , z10, tool0;

                ! drive in front of dummy
                Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                MoveL arrDummyInFront{nDummyNo} ,Speed,z30,tool0;
    
                ! drive on pre position
                Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                MoveL posPreDummy ,Speed,z30,tool0;

                !   Auf Position Home fahren
                Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                MoveJ Home,Speed,z50,tool0;
     
        ENDIF
                
    ENDPROC

        !***********************************************************!
        !               box around dummy tray                    !
        !***********************************************************!
    PROC procBoxDummy(INOUT wzstationary wzService)
        VAR shapedata volume;
        VAR pos LowPoint;
        VAR pos HighPoint;

        !   Ecken der Box berechnen
        LowPoint:=[-9999,-9999,-9999];
        HighPoint:=[9999,65,9999];

        !   Box definieren ausserhalb des Bereichs
        WZBoxDef \Outside, volume,LowPoint ,HighPoint ;

        !   Ausgang setzen wenn Ausserhalb der Box
        WZDOSet \Stat,  wzService  \Inside, volume, O_doDummyMechanicalFree , 1;

    ENDPROC
    
ENDMODULE