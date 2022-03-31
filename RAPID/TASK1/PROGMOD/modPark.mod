MODULE modPark

    !***********************************************************!
    !            Faehrt den Roboter auf die Home Position       !
    !***********************************************************!    
     FUNC bool Park()
        
        !   Parken fahren wenn Parken angefordert wird
        if (I_diPark = 1) THEN
            procGoToParkPos;
            WaitRob \InPos;
            Set O_doParked;
            Stop;     
            
            Reset O_doParked;
            ! Wenn StartUp beendet, auf vorherige Pos zurück
            IF bStartup = FALSE THEN
                procGoToLastPos;
            endif
            RETURN TRUE;
        !   Roboter nicht parken
        ELSE
            RETURN FALSE;
        ENDIF
        
    ENDFunc

    !***********************************************************!
    !               Fuehrt einen Heimlauf aus                   !
    !***********************************************************!
    PROC procGoToParkPos()
        VAR robtarget posTempPos;
        
        !   Warten bis roboter steht
        WaitRob \InPos;
        
        !   Aktuelle Position speichern
        posBeforePark := CRobT(\Tool:=tool0);
        posTempPos:=CRobT(\Tool:=tool0);
    
        ! Heimlauf
        HomeReturn;

    ENDPROC

    !***********************************************************!
    !      Fährt zurük auf Position vor dem Heimlauf            !
    !***********************************************************!
    PROC procGoToLastPos()
        
        !   Warten bis roboter steht
        WaitRob \InPos;
        
        ! Über Zielpunkt fahren
        Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
        Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
        MoveJ OFFS(posBeforePark,0,0,50),Speed,z5,tool0;
    
        ! Auf Zielpunkt fahren
        Speed.v_tcp := MaxRobSpeed()/100  * I_giSpeed;
        Speed.v_ori := MaxRobReorientSpeed()/100 * I_giSpeed;
        MoveL posBeforePark,Speed,z5,tool0;
                        
    ENDPROC
    
ENDMODULE