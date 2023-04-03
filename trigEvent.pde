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
 
     text ( 
       " ActualVirtualPosition[3] " + ActualVirtualPosition[3] + " propagationLevel "  +  propagationLevel + " timeLfoTrigEvent" + delayTimeToTrig + " oscillatorBlocked " + oscillatorBlocked , width-width/4, -300);

 



   text (" oldOscillatorChange " + oldOscillatorChange + " oscillatorChange " + oscillatorChange + " j " + nf (phaseKeptAtChange[oscillatorChange]/TWO_PI*360%360, 0, 2), -width-200, -height- 400 );
   text (" oscillatorChangingPropagation " +  oscillatorChangingPropagation  +  nf (phaseKeptAtChange[oldOscillatorChange]/TWO_PI*360%360, 0, 2), -width-200, -height- 300 );

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
      text (" blocked "  + oscillatorBlocked, width-width/8, -height/4);

     signalToSplit = map ( signal[5], 0, 1, 0, 1);
     signalToSplit4 = map ( signal[4], 0, 1, 0, 1);

     delayTimeToTrig=140; //ms
     delayTimeToTrig4=70;
     
         if (beatPrecised==2 && measure==1){
           formerKeyMetro = '$';
          }
        
        
         if (measure==16 ){
          // formerKeyMetro = '*';
           key = '0';
         }

        if (measure==1){
           delayTimeToTrig4=70;
          
         }
           if (measure==41 && beatPrecised == 3 ){
           delayTimeToTrig4=140;
             delayTimeToTrig=100;
        //  key= '='; keyReleased();
          key = 'ç';
          }
  
         if (measure==42){
           key = '0';
           formerKeyMetro = '*';
           delayTimeToTrig4=140;     
          }
           if (measure < 58 ){
           positionMov = " premierePartie ";
         }
         else { positionMov = " dernierePartie " ; }

         if (measure == 58 && beatPrecised == 6  ){
          formerKeyMetro = '*';
      
          key= '='; keyReleased();
        }
        if (measure == 58 && beatPrecised == 7  ){
            positionMov = " dernierePartie ";
         key = '0'; keyReleased();
           }
         
         int formerFrameTrigging;
         formerFrameTrigging=frameCount;
         
         if (measure == 58 && beatPrecised == 8 ){ // && frameCount>formerFrameTrigging+1
         //   key = 'y'; keyReleased();
        key = 'Y';   
      }
        
      if (  positionMov == " premierePartie "){
      //   positionMov = " premierePartie ";
       if (measure<41 || measure>=42 ){

      if (signalToSplit>0.5 && millis()> timeToTrig+delayTimeToTrig ){  // 
            oscillatorBlocked=0;
      timeToTrig=millis();
      propagationLevel=1;
      oscillatorChangingPropagation=true;
      if (measure<41){ 
      //    oscillatorBlocked=oscillatorBlocked+1;
        key = 'd';
         }
     
      if (measure>=41 && measure<=50 ){ 
      //    oscillatorBlocked=oscillatorBlocked+1;
      //  key = 'D'; // D
       
         }
      
       oscillatorBlocked=oscillatorBlocked%networkSize;
      }

         if (signalToSplit4>0.5 && millis()> timeToTrig+delayTimeToTrig4 ){  // 
          oscillatorBlocked=0;

      timeToTrig=millis();
      propagationLevel=2;
      oscillatorChangingPropagation=true;
        if (measure<41){ 
        //  oscillatorBlocked=oscillatorBlocked+1;
          key = 'f';
         }
        if (measure>=41){ 
     //***     key = 'F'; //f
           }
      oscillatorBlocked=oscillatorBlocked%networkSize;
   
      }
     
    
      if (signalToSplit<0.5 && millis()> 0 && measure>1 && measure<600){  //  timeToTrig+delayTimeToTrig
       oscillatorBlocked=5;
        timeToTrig=millis();
      propagationLevel=0;
      oscillatorChangingPropagation=false;
     // oscillatorBlocked=oscillatorBlocked-1;
      if (oscillatorBlocked<=0) {
      oscillatorBlocked=networkSize-1;
      }
      if (measure > 41)  {
          key = 'f';
         }
       else  key = 'f';
      }
     }
       }

         if ( positionMov == " dernierePartie "  ){     
      
       if (signalToSplit>0.5 && millis()> timeToTrig+delayTimeToTrig ){  // 
            oscillatorBlocked=0;
      timeToTrig=millis();
      propagationLevel=1;
      oscillatorChangingPropagation=true;
       key = 'F';
         }   


       if (signalToSplit4>0.5 && millis()> timeToTrig+delayTimeToTrig4+80 ){  // 
          oscillatorBlocked=0;

       timeToTrig=millis();
       oscillatorChangingPropagation=true;
      
        if (measure>=41){ 
      // key = 'd';
           }
        oscillatorBlocked=oscillatorBlocked%networkSize; 
       }
        
      if (signalToSplit<0.5 && millis()> 0 && measure>1 && measure<600){  //  timeToTrig+delayTimeToTrig
       oscillatorBlocked=5;
        timeToTrig=millis();
      propagationLevel=0;
      oscillatorChangingPropagation=false;
     // oscillatorBlocked=oscillatorBlocked-1;
      if (oscillatorBlocked<=0) {
      oscillatorBlocked=networkSize-1;
      }
      if (measure > 57)  {
      //    key = 'F';
         }
      }
      }

        text ( " positionMov " + positionMov +  " DataToDueCircularVirtualPosition[3] " + DataToDueCircularVirtualPosition[3] + " key " + key  
       , width-width/4, -400);

    // keyPressed();
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