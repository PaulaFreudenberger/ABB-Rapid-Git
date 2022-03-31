MODULE modMain
        
    !***********************************************************!
    !                           Punkte                          !
    !***********************************************************!
    !   Parkposition des Roboters
    pers robtarget Home:=[[231.96,103.06,-637.69],[0.1988,-0.703524,0.656951,-0.184251],[0,0,-1,5],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    PERS robtarget posBeforePark:=[[291.47,169.422,-650.949],[0.273592,-0.649567,0.654463,-0.273656],[0,-2,-3,4],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];   !Position bevor geparkt wurde
    
    !***********************************************************!
    !                       Variablen                           !
    !***********************************************************!
    
    VAR wzStationary wzStHome;      !Arbeitsbereich Home
    VAR speeddata Speed;         !Geschwindigkeit
    VAR bool bPartInGripper;     !Teil in Greifer
    VAR bool bStartup;           !StartUp wird durchgeführt
        
    !***********************************************************!
    !                       Konstanten                          !
    !***********************************************************!
    !   Gewicht Greifer
    pers loaddata EmptyGripper := [ 1, [0, 0, 100], [1, 0, 0, 0], 0, 0, 0]; 
    PERS tooldata ToolGripper:=[TRUE,[[0,0,0],[0.923879,0.382683,0,0]],[0.5,[0,0,0],[1,0,0,0],0,0,0]];

    CONST num nLimZ:=-650;
    
    !***********************************************************!
    !                     Wird permanent ausgefuehrt            !
    !***********************************************************!
    PROC Main()
        !   Roboter initialisieren
        procStartUp;
        
        WHILE true do
                                              
            !parken?
            IF Park() THEN
            ELSE
                
                !pick part from RT and place it in carrier
                procPickPlace;
                
                ! pick part from RT and place it in dummy tray
                procPickPlaceDummy;
                
            ENDIF
              
        ENDWHILE
        
    ENDPROC
           
    !***********************************************************!
    !       Wird beim PowerUp des Roboters ausgefuehrt          !
    !***********************************************************!
    PROC procMainPowerUp()
        
        ! robot in the near of home position
        procBoxHome 10,wzStHome;
                
        ! workzone carrier and rotary table
        procPickPlacePowerUp;
        
        ! workzone dummy tray
        procDummyPowerUp;
                
    ENDPROC
    
    !***********************************************************!
    !                  Initialisiert den Roboter                !
    !***********************************************************!
    PROC procStartUp()
        
        bStartup := TRUE;
          
        ! limitiert den Ruck bei den Bewegungen
        PathAccLim FALSE \AccMax := 4, FALSE \DecelMax := 4;
                
        ! Keine Last mehr am Greifer
        GripLoad EmptyGripper;
        
        ! Greifer auf
        Reset O_doGrip;
        bPartInGripper := FALSE;
        
        ! Roboter auf Home stellen
        procGoToParkPos;
        WaitRob \InPos;
                
        ! Handshake Signale loeschen
        Reset O_doParked;
                
        ! initialize pich and place module
        procInitPickPlace;
        
        ! initialize dummy module
        procInitDummy;
        
        bStartup := FALSE;
                
    ENDPROC
    
    !***********************************************************!
    !               Arbeitsbereich Scara Roboter                !
    !***********************************************************!
    PROC procBoxHome(num nOffset,INOUT wzStationary wzService)
        VAR shapedata volume;
        VAR pos LowPoint;
        VAR pos HighPoint;

        !   Ecken der Box berechnen
        LowPoint:=[Home.trans.x-nOffset,Home.trans.y-nOffset,Home.trans.z-nOffset];
        HighPoint:=[Home.trans.x+nOffset,Home.trans.y+nOffset,Home.trans.z+nOffset];

        !   Box definieren Innerhalb des Bereichs
        WZBoxDef \Inside, volume,LowPoint ,HighPoint ;

        !   Ausgang setzen wenn Innerhalb der Box
        WZDOSet \Stat,  wzService  \Inside, volume, O_doIsHome, 1;

    ENDPROC
    
    !***********************************************************!
    !               Arbeitsbereich ueber Handlings              !
    !***********************************************************!
    FUNC bool InBoxAbove()
        VAR robtarget rtActPos;

        !   aktuelle Position vom Roboter auslesen
        rtActPos:=CRobT();

        !   Pruefen ob Roboter in Box steht
        IF (rtActPos.trans.Z > nLimZ) THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        endif
        
    ENDFUNC

    !***********************************************************!
    !               Arbeitsbereich WT                          !
    !***********************************************************!
    FUNC bool InBoxCarrier()
        VAR robtarget rtActPos;

        !   aktuelle Position vom Roboter auslesen
        rtActPos:=CRobT();

        !   Pruefen ob Roboter in Box steht
        IF ((rtActPos.trans.X > 150) and (rtActPos.trans.X < 450)) AND ((rtActPos.trans.Y > 0) and (rtActPos.trans.Y < 300)) AND ((rtActPos.trans.Z > -9999) and (rtActPos.trans.Z < -710)) THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        endif
        
    ENDFUNC

    !***********************************************************!
    !               workzone rotary table                       !
    !***********************************************************!
    FUNC bool InBoxRT()
        VAR robtarget rtActPos;

        !   aktuelle Position vom Roboter auslesen
        rtActPos:=CRobT();

        !   Pruefen ob Roboter in Box steht
        IF ((rtActPos.trans.X > -9999) and (rtActPos.trans.X < -50)) AND ((rtActPos.trans.Y > -9999) and (rtActPos.trans.Y < 9999)) THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        endif
        
    ENDFUNC
    
    !***********************************************************!
    !        Zieht die Z-Achse auf den absoluten Wert ein       !
    !***********************************************************!
    PROC Depart(num Zabsolute, \bool linear)
        VAR robtarget posTempPos;
        
        ! aktuelle Position speichern
        posTempPos:=CRobT(\Tool:=tool0);
        
        ! Z-Wert manipulieren
        posTempPos.trans.z:=Zabsolute;
        
       !Z-Achse einziehen
       Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
       Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
      
        IF Present(linear) then
            IF linear THEN
                MoveL \Conc, posTempPos, Speed,z10,tool0;
            ELSE
               MoveJ \Conc, posTempPos, Speed,z10,tool0;             
            ENDIF       
        ELSE
           MoveJ \Conc, posTempPos, Speed,z10,tool0;             
        ENDIF    
                        
    ENDPROC
    
        !***********************************************************!
    !               Fuehrt einen Heimlauf aus                   !
    !***********************************************************!
    PROC HomeReturn()
        VAR robtarget nActPos;
        
        WaitRob \InPos;
        
        !Z-Achse einziehen
        Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
        Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;

        !   Aktuelle Position speichern
        nActPos:=CRobT();
                
        !   Nur wenn der Roboter noch nicht auf Home steht -> auf Home stellen
        IF (O_doIsHome=0) then
                    
                !   Wenn er auf/ueber dem Band steht -> Nach Oben fahren
                IF InBoxCarrier() and (InBoxAbove()=FALSE) THEN
                    WaitRob \InPos;
                    Depart(nLimZ);
                    ! in box RT position A  
                elseIF InBoxRT() and (InBoxAbove()=FALSE)   and (nActPos.trans.x < -200) THEN
                    Reset O_doGrip;
                    WaitTime 0.5;

                    ! drive in front carrier position
                    MoveL \Conc, posInFronPickRT_A,Speed,z5,tool0;
                    
                    WaitRob \InPos;
                    Depart(nLimZ);
                    
                    ! drive over RT
                    MoveJ \Conc, posOverRT,Speed,z50,tool0;
                    
                    ! Above box RT position A  
                elseIF InBoxRT() and InBoxAbove()  and (nActPos.trans.x < -200) THEN
                    Reset O_doGrip;
                    WaitTime 0.5;

                    ! drive over RT
                    MoveJ \Conc, posOverRT,Speed,z50,tool0;
                    
                    ! in box RT position B  
                elseIF InBoxRT() and (InBoxAbove()=FALSE) and (nActPos.trans.x > -200) THEN
                    Reset O_doGrip;
                    WaitTime 0.5;

                    ! drive in front carrier position
                    MoveL \Conc, posInFrontPickRT_B ,Speed,z5,tool0;
                    
                    WaitRob \InPos;
                    Depart(nLimZ);
                    
        !   Wenn er sonstwo steht -> Nach Oben fahren
        ELSeif (nActPos.trans.z <nLimZ) THEN
                    WaitRob \InPos;
                    Depart(nLimZ);
                ENDIF
                           
            !   Auf Position Home fahren
            MoveJ \Conc, Home,Speed,z20,tool0;

        ENDIF

    ENDPROC
    
ENDMODULE