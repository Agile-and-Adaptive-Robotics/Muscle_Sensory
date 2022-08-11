function [diameter,lengths,lo,li,l620,kink,testnum] = choosedata(diameter,lengths,test)
    if diameter == 10
         if lengths == 13
            lo = 12;
            li = [12 11.6 11.2 10.8]; 
            l620 = 10; 
            diameter = 10;
            lengths = 13;
            kink = [0 4 8 12];
            testnum = test;
         elseif lengths == 23
            lo = 22;
            li = [22 20.5 18.9]; 
            l620 = 18.5; 
            diameter = 10;
            lengths = 23;
            kink = [0 14 30];  
            testnum = test;
         elseif lengths == 27
            lo = 25.7; 
            li = [25.7 25 24.2 22.6];
            l620 = 21.8; 
            diameter = 10;
            lengths = 27;
            kink = [0 7 15 31];
            testnum = test;
         elseif lengths == 29
            lo = 28.1;
            li = [28.1 26.4 25.3 24]; 
            l620 = 23.5; 
            diameter = 10;
            lengths = 29;
            kink = [0 17 28 41];
            testnum = test;
         elseif lengths ==30
            lo = 28.1;
            li = [28.1 26.9 25.9 24.8];
            l620 = 24;
            diameter = 10;
            lengths = 30;
            kink = [0 12 22 33];
            testnum = test;
         end
         
      elseif diameter == 20
          if lengths == 10
            lo = 9.8;
            li = [9.8, 8.5,7.8];
            l620 = 7.6,
            diameter = 20;
            lengths = 10;
            kink = [0 13 20];
            testnum = test;
          elseif lengths == 12
            lo = 12;
            li = [12 11 10]; 
            l620 = 9.1 ; 
            diameter = 20;
            lengths =12;
            kink = [0 10 20];
            testnum = test;
          elseif lengths == 23
            lo = 22.5
            li = [22.5 21.9 20.9]; 
            l620 = 17;
            diameter =20 ;
            lengths = 23;
            kink = [0 9 19];
            testnum = test;
          elseif lengths == 30
            lo = 27.4; 
            li = [27.4 26.1 25.2 24.1]; 
            l620 = 20.7; 
            diameter =20 ;
            lengths =30;
            kink = [0 14 23 34];
            testnum = test;
            
          elseif lengths == 40
            lo = 39.8; 
            li = [39.8 36.2 35.1 32.8]; 
            l620 = 29.9; 
            diameter =20 ;
            lengths =40;
            kink = [0 35 46 69];
            testnum = test;
          end
           
    end

end