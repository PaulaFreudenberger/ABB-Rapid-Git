MODULE modPickPlace
    !***********************************************************!
    !                           Punkte                          !
    !***********************************************************!
    ! place part in carrier
    PERS robtarget posPlaceCarrier:=[[291.55,169.48,-803.35],[0.273603,-0.649601,0.654423,-0.273659],[0,-2,-4,4],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    !  Above the middle of the RT
    PERS robtarget posOverRT:=[[-361.34,251.46,-504.38],[0.614524,-0.694621,-0.183338,0.32596],[-1,0,-1,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];     
    !  In RT position A
    PERS robtarget posPickRT_A:=[[-362.82,7.63,-699.15],[0.231848,0.562911,0.732908,0.303684],[-2,-1,-2,4],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];    
    !  In RT position B
    PERS robtarget posPickRT_B:=[[-146.08,64.78,-700.29],[0.306839,0.728476,-0.564869,-0.236845],[-1,-1,0,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];     
    !  in front of RT position A
    PERS robtarget posInFronPickRT_A:=[[-409.32,-5.18,-684.87],[0.231863,0.562916,0.732904,0.303672],[-2,-1,-2,4],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];   
    !  in front of RT position B
    PERS robtarget posInFrontPickRT_B:=[[-67.83,85.11,-686.63],[0.306892,0.728538,-0.564782,-0.236793],[-1,-1,0,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];  
    !  above RT position A
    PERS robtarget posAbovePickRT_A:=[[-362.52,7.37,-684.91],[0.23188,0.562926,0.732878,0.303705],[-2,-1,-2,4],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];    
    !  above RT position B
    PERS robtarget posAbovePickRT_B:=[[-146.24,64.90,-685.76],[0.306871,0.728495,-0.564833,-0.236832],[-1,-1,0,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];   
    
    !***********************************************************!
    !                       Variablen                           !
    !***********************************************************!
    
    VAR wzstationary wzStCarrier;       !working area carrier
    VAR wzstationary wzStRotaryTable;   !working area rotary table
    VAR robtarget posTemp;
    
    
    !***********************************************************!
    !                       Konstanten                          !
    !***********************************************************!   
    
    
    !***********************************************************!
    !       Wird beim PowerUp des Roboters ausgefuehrt          !
    !***********************************************************!
    PROC procPickPlacePowerUp()
        
         !working area carrier
        procBoxCarrier  wzStCarrier;

        !working area rotary table
        procBoxRT  wzStRotaryTable;
               
    ENDPROC

        
    !***********************************************************!
    !                 Modul initialisieren                      !
    !***********************************************************!
    PROC procInitPickPlace()
                        
        ! Handshake Signale loeschen
        Reset O_doRTPicked_A;
        Reset O_doRTPicked_B;
        Reset O_doCarrierPlaced;
                
    ENDPROC
               
    !***********************************************************!
    !             pick part from RT and place in carrier        !
    !***********************************************************!
    PROC procPickPlace()
        var bool temp;
        
        ! Bereit zum Feder montieren
        IF (bPartInGripper = FALSE)
        and ((( I_diRTRdyToPick_A  = 1) and (I_diDummyA=0)) OR (( I_diRTRdyToPick_B  = 1) and (I_diDummyB=0)))
        and ( I_diRTMechanicalFree = 1) THEN
            
            ! drive homereturn
            HomeReturn;
                                                          
                ! select the active RT position
                IF ((I_diRTRdyToPick_A=1) and (I_diDummyA=0)) THEN
                    
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

                ! drive above carrier
                Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                MoveJ Offs( posPlaceCarrier ,0,0, 100),Speed,z10,tool0;

                ! wait until carrier is ready
                WHILE ((I_diCarrierRdyToPlace = 0) or (I_diCarrierMechanicalFree = 0)) DO
                   temp:=Park();
                ENDWHILE

                ! drive above carrier
                Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                MoveJ Offs( posPlaceCarrier ,0,0, 30),Speed,z10,tool0;

                ! drive in carrier
                Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed*0.3;
                Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed*0.3;
                MoveL posPlaceCarrier, Speed, z0, tool0;
                WaitRob \InPos;
                
                ! open gripper
                Reset O_doGrip;
                WaitTime 0.1;
                bPartInGripper := false;
                
                ! drive above carrier
                Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
                Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
                MoveJ \Conc, Offs(posPlaceCarrier,0,0, 100),Speed,z30,tool0;
                
                ! HS carrier
                Set O_doCarrierPlaced;
                WaitDI I_diCarrierRdyToPlace , 0;
                Reset O_doCarrierPlaced;
                
            !   Auf Position Home fahren
            MoveJ \Conc, Home,Speed,z50,tool0;
            
        ENDIF
        
    ENDPROC
          
    !***********************************************************!
    !               box around carrier                          !
    !***********************************************************!
    PROC procBoxCarrier( INOUT wzstationary wzService)
        VAR shapedata volume;
        VAR pos LowPoint;
        VAR pos HighPoint;

        !   Ecken der Box berechnen
        LowPoint:=[100,-100,-9999];
        HighPoint:=[500,400,-750];

        !   Box definieren ausserhalb des Bereichs
        WZBoxDef \Outside, volume,LowPoint ,HighPoint ;

        !   Ausgang setzen wenn Ausserhalb der Box
        WZDOSet \Stat,  wzService  \Inside, volume, O_doCarrierMechanicalFree , 1;

    ENDPROC

        !***********************************************************!
        !               box around rotary table                     !
        !***********************************************************!
    PROC procBoxRT( INOUT wzstationary wzService)
        VAR shapedata volume;
        VAR pos LowPoint;
        VAR pos HighPoint;

        !   Ecken der Box berechnen
        LowPoint:=[-9999,-9999,-9999];
        HighPoint:=[20,9999,-560];

        !   Box definieren ausserhalb des Bereichs
        WZBoxDef \Outside, volume,LowPoint ,HighPoint ;

        !   Ausgang setzen wenn Ausserhalb der Box
        WZDOSet \Stat,  wzService  \Inside, volume, O_doRTMechanicalFree , 1;

    ENDPROC

ENDMODULE