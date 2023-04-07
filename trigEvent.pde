int delayTimeToTrig4; //ms
float signalToSplit4;
String positionMov;

void trigEventWithAbletonSignal() {  // change de sens de propagagtion.   ATTENTION dans ce reglage le signalToSplit de propgation est UP continue de 0 à TWO_PI

    lfoPhase[1] = (frameCount / 10.0 * cos (1000 / 500.0)*-1)%TWO_PI;  // continue 0 to TWO_PI;
    lfoPhase[3] = map ((((cos  (frameCount / 30.0))*-1) %2), -1, 1, -TWO_PI, TWO_PI);  // sinusoidale lente
    lfoPhase[2] = map ((((cos  (frameCount / 100.0))*-1) %2), -1, 1, -TWO_PI, TWO_PI); // sinusoidale rapide
    
   
   // println (" forme d'onde lfoPhase[1] ", lfoPhase[1], "lfoPhase[2] ", lfoPhase[2], "lfoPhase[3]= signalTosplit ", lfoPhase[3]); 

    oldSignalToSplit=signalToSplit;
    
 //   signalToSplit = map ( signal[5], 0, 1, -TWO_PI, TWO_PI);
 
 
  if (oldSignalToSplit> signalToSplit ) {
  //  key = 'q' ; // when signal goes down --> propagation FRONT SIDE
 // doZ=true;
  //*** timeLfo= map (signalToSplit, TWO_PI, -TWO_PI, 0, 1000);  //  if we have an oscillation as  lfoPhase[3]
    }
  else if (oldSignalToSplit< signalToSplit ) { // on est dans cette configuration avec  signalToSplit= lfoPhase[1]
//   key = 'z';  //  when signal goes down --> propagation BEHIND SIDE 
//   key = 'q' ;  // propagation in on the same way
 // doZ=false;
   timeLfo= map (signalToSplit, -TWO_PI, TWO_PI, 0, 1000);  // manage only upSignal
 //**   timeLfo= map (signalToSplit, 0, TWO_PI, 0, 1000);  // if we have a continuois from 0 to TWO_PI 
 //   timeLfo= map (signalToSplit, 0, 1, 0, 1000); //  if we have a continuois from 0 to TWO_PI from an other software
 
   }

     splitTimeLfo= int  (timeLfo%1000); 
    //  text (" splittimeLfo "  +  splitTimeLfo +   " oldSplitTimeLfo " + oldSplitTimeLfo, 300, -300);
     textSize (75);
     text ( 
       " Data[5] " + DataToDueCircularVirtualPosition[5] + " Data[0] " + DataToDueCircularVirtualPosition[0] + " propagationLevel "  +  propagationLevel + " timeLfoTrigEvent" + delayTimeToTrig + " oscillatorBlocked " + oscillatorBlocked , width-width/4, -300);

 
     text (" oldOscillatorChange " + oldOscillatorChange + " oscillatorChange " + oscillatorChange + " j " + nf (phaseKeptAtChange[oscillatorChange]/TWO_PI*360%360, 0, 2), -width-200, -height- 400 );
     text (" oscillatorChangingPropagation " +  oscillatorChangingPropagation  +  nf (phaseKeptAtChange[oldOscillatorChange]/TWO_PI*360%360, 0, 2), -width-200, -height- 300 );

 
     text (" blocked "  + oscillatorBlocked, width-width/8, -height/4);

     signalToSplit = map ( signal[5], 0, 1, 0, 1);
     signalToSplit4 = map ( signal[4], 0, 1, 0, 1);

     delayTimeToTrig=120; //ms
     delayTimeToTrig4=120;
         
          if (measure==1 && beatTrigged==true){
           delayTimeToTrig4=120;    
          }


          if (beatPrecised==1  && beatPrecisedTrigged==false){
           formerKeyMetro = '$';
          }
     
          if (beatPrecised==2 && measure==1 && beatPrecisedTrigged==true){
           keyCode= CONTROL;
          }
          
          if (measure==17 && beatTrigged==true ){
          // formerKeyMetro = '*';
         //  keyCode= CONTROL;
           delayTimeToTrig4=100;
           key = '0';
          }

          if (measure==41 && beatPrecised == 3 && beatPrecisedTrigged==true ){
           delayTimeToTrig4=100;
           delayTimeToTrig=140;
        //  key= '='; keyReleased();
           key = 'ç';
          }
  
          if (measure==42 && beatPrecised == 1 && beatPrecisedTrigged==true){
           key = '0';
           formerKeyMetro = '*';
           delayTimeToTrig4=140;     
          }

         if (measure < 58 ){
           positionMov = " premierePartie ";
          }

        else if (measure >= 58  && measure <=68) { positionMov = " seconde " ; }
        else if (measure >= 69 ) { positionMov = " troisieme " ; }

              
      if (  positionMov == " premierePartie "){
       if (measure<41 || measure>=42 ){
        if (beatPrecised%2==0 && beatPrecisedTrigged==true  ){ // signalToSplit>0.5 && // && millis()> timeToTrig+delayTimeToTrig
      oscillatorBlocked=5;
     // timeToTrig=millis();
      propagationLevel=1;
      oscillatorChangingPropagation=true;
         if (measure<17){ 
        key = 'i'; keyReleased();
       }
       }
      if (measure<41){ 
        if (beatTrigged==true){ 
      oscillatorBlocked=0;
      propagationLevel=1;
      oscillatorChangingPropagation=true;
        key = 'F'; keyReleased();
         }
       }
      if (measure>16){ 
        if (beatPrecised%4==0 && beatPrecisedTrigged==true){ 
      oscillatorBlocked=0;
      propagationLevel=1;
      oscillatorChangingPropagation=true;
        key = 'D';
         }
       }
      if (measure>16){ 
        if ((beatPrecised+2)%4==0 && beatPrecisedTrigged==true){ 
      oscillatorBlocked=0;
      propagationLevel=1;
      oscillatorChangingPropagation=true;
       key = 'F';
         }
       }
      if (measure>=41 && measure<=50 ){ 
      //    oscillatorBlocked=oscillatorBlocked+1;
      //  key = 'D'; // D
       key = 'd'; keyReleased();
       }   
       oscillatorBlocked=oscillatorBlocked%networkSize;
      }

    // addPropragation ou alt A 

      }
     

       if (positionMov == " seconde " ){     
      
      if (beatPrecised%2==0 && beatPrecisedTrigged==true  ){ // signalToSplit>0.5 && // && millis()> timeToTrig+delayTimeToTrig

      oscillatorBlocked=0;
      timeToTrig=millis();
      propagationLevel=1;
      oscillatorChangingPropagation=true;
       key = 'D'; keyReleased();
       }   


       if (signalToSplit4>0.5 && millis()> timeToTrig+delayTimeToTrig4+80 ){  // 
          oscillatorBlocked=0;

       timeToTrig=millis();
       oscillatorChangingPropagation=true;
       key = 'd';
           
        oscillatorBlocked=oscillatorBlocked%networkSize; 
       }
        
       if (measure > 57)  {
          key = 'F';
       }
       
      
      if (measure == 58 && beatPrecised == 6 && beatPrecisedTrigged==true ){
          formerKeyMetro = '*';
      
       //   key= '='; keyReleased();
        }

      if (measure == 58 && beatPrecised == 7 && beatPrecisedTrigged==true ){
            positionMov = " seconde ";
         key = '0'; keyReleased();
        }
         
         int formerFrameTrigging;
         formerFrameTrigging=frameCount;
         
      if (measure == 58 && beatPrecised == 8 && beatPrecisedTrigged==true ){ // && frameCount>formerFrameTrigging+1
            key = 'y';   
            key = 'y';  
            key = 'y';   
            key = 'y';    
        }
       } // end second partie

      if ( positionMov == " troisieme "  ){  
    if (measure == 66 && beatPrecised == 1 && beatPrecisedTrigged==true){ // && frameCount>formerFrameTrigging+1
          key= 0;
      
      }
     if (measure == 66 && beatPrecised == 2 && beatPrecisedTrigged==true ){ // && frameCount>formerFrameTrigging+1
          key = 'y';   
             key = 'y';   
                key = 'y';   
                   key = 'y';   
      }
    if (measure == 66 && beatPrecised == 3 && beatPrecisedTrigged==true ){ // && frameCount>formerFrameTrigging+1
          key = 'y';   
             key = 'y';   
                key = 'y';   
                   key = 'y';   
      }

           if (signalToSplit>0.5 && millis()> timeToTrig+delayTimeToTrig ){  // 
        //    oscillatorBlocked=0;
      timeToTrig=millis();
      propagationLevel=1;
      oscillatorChangingPropagation=true;
              }


         if (signalToSplit4>0.5 && millis()> timeToTrig+delayTimeToTrig4 ){  // 
        //  oscillatorBlocked=5;

       timeToTrig=millis();
       oscillatorChangingPropagation=true;
      //   key = 'r';
          
        oscillatorBlocked=oscillatorBlocked%networkSize; 
       }
       }

     

       textSize (50);
 
  
     text ( " positionMov " + positionMov +  " Data[3] " + DataToDueCircularVirtualPosition[3] + " key " + key , width-width, -400);

    text  ( "  beginMeasure " +  beginMeasure +  " beatTrigged " + beatTrigged + " measure " +  measure, 300, 100);
    text  ( " trigEffect " + trigEffect + " enco " +  abs ((int)map (encodeur[0], 0, 800, 0, 127)), 300, 200);
    text  ( " encodeur[1]" + encodeur[1] +  " trigEffectBis " + trigEffectBis +  " encO " +  abs ((int)map (oldEncodeur[0], 0, 800, 0, 127)), 300, 300);

   

      for (int i = 0; i < networkSize; i++) {
      //  text ( "metro" + metroPhase[i] + " actual Other" + i + " " + ActualVirtualPositionFromOtherMode[i] + " PendularVirtualPosition " + i + " " + PendularVirtualPosition[i] + " virtual " + i + " " + VirtualPosition[i] + " actual " + i + " " + ActualVirtualPosition[i] + " data " + i + " " + DataToDueCircularVirtualPosition[i], 800, 1600- 100*i );
       }

    
      textSize (75);
     text ( " signal3 " + signal[3] , 300, 800);
     text ( " signal4 " + signal[4] , 300, 900);
     text ( " signal5 " + signal[5] , 300, 1000);
     text ( " measure  " + measure + "beatPrecised  " + beatPrecised + " key " + key + " " + keyCode, 300, 1100);



 

     phasePattern();
     oldSplitTimeLfo = splitTimeLfo; 
} 

  


             
    /*
        if (formerKeyMetro == '$' && key == '='){
       for (int i = 0; i < networkSize; i=+1 ){
         AlternativeVirtualPositionFromOtherMode[i]=DataToDueCircularVirtualPosition[i]- ActualVirtualPositionFromOtherMode[i];
         text ( "   AlternativeVirtualPositionFromOtherMode[i] " + i + " " +  ActualVirtualPositionFromOtherMode[i] , -800, 800-10*i );
       } 
    } 
    */



     /* 
    if (oldSplitTimeLfo-splitTimeLfo>150){  // if previous signal is upper of 15%
      oscillatorChangingPropagation=true;
      oldOscillatorChange=oscillatorChange;
      oscillatorChange=oscillatorChange+1;
      }
     else  oscillatorChangingPropagation=false;
      oscillatorChange=oscillatorChange%networkSize;
     if (oscillatorChange<=0) {
      oldOscillatorChange=networkSize-1;
     }

    if (splitTimeLfo-oldSplitTimeLfo>150){  // if previous signal is downer of 15%
      oscillatorChangingPropagation=true;
      oldOscillatorChange=oscillatorChange;
      oscillatorChange=oscillatorChange+1;
      }
     else  oscillatorChangingPropagation=false;
      oscillatorChange=oscillatorChange%networkSize;
     if (oscillatorChange<=0) {
      oldOscillatorChange=networkSize-1;
     } 
  */

    /*
     if (splitTimeLfo-oldSplitTimeLfo>150){ // if previous signal is upper of 15%
      oscillatorChangingPropagation=true;
      oldOscillatorChange=oscillatorChange;
      oscillatorChange=oscillatorChange-1;
     } 
      if (oscillatorChange<=-1) {
      oldOscillatorChange=0;
      oscillatorChange=networkSize-1;
    }
    */