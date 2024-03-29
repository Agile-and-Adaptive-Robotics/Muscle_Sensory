%this function inputs the BPA parameters (lo,li,l620,kink,kmax,test#) based
%on chosen diameter and length. 
function [diameter,lengths,lo,li,l620,kink,E,kmax,Erel,testnum,State,B0,B1] = choosedata(diameter,lengths,test)
    if diameter == 10
         if lengths == 13
            lo = 12;
            li = [12 11.6 11.2 10.8]; 
            l620 = 10; 
            diameter = 10;
            lengths = 13;
            kink = [0 4 8 12];
            testnum = test;
            kmax = (12-10)/12;
            E = (lo-li)./(lo);
            Erel = (E./kmax);
            State = [1 0];
            B0 = [-59.0437, -130.7306,-194.8013,-231.3719;-52.0138,-106.2451,-165.6607,-161.695];
            B1 = [0.6412,0.6449,0.5884,0.536;0.6146,0.597,0.5528,0.4294];

         elseif lengths == 23
            lo = 22;
            li = [22 20.5 18.9]; 
            l620 = 18.5; 
            diameter = 10;
            lengths = 23;
            kink = [0 14 30]; 
            testnum = test;
            kmax = (22-18.5)/22;
            E = (lo-li)./(lo);
            Erel = (E./kmax);
            State = [1 0];
            B0 = [-58.1024,-269.3295,-336.8447;-48.6449,-222.5459,-223.6328];
            B1 = [0.6986,0.6772,0.5937;0.6593,0.6152,0.4256];
         elseif lengths == 27
            lo = 25.7; 
            li = [25.7 25 24.2 22.6];
            l620 = 21.8; 
            diameter = 10;
            lengths = 27;
            kink = [0 7 15 31];
            kmax = (25.7-21.8)/25.7;
                        E = (lo-li)./(lo);
            Erel = (E./kmax);
            testnum = test;
            State = [1 0];
            B0 = [-46.6251,-196.2748,-244.3358,-298.5304;-27.2358,-155.0716,-190.5357,-209.8406];
            B1 = [0.6893,0.7284,0.6899,0.5777;0.631,0.6666,0.6103,0.4444];

            
         elseif lengths == 29
            lo = 28.1;
            li = [28.1 26.4 25.3 24]; 
            l620 = 23.5; 
            diameter = 10;
            lengths = 29;
            kink = [0 17 28 41];
            kmax = (28.1-23.5)/28.1;
                        E = (lo-li)./(lo);
            Erel = (E./kmax);
            testnum = test;
            State = [1 0];

         elseif lengths ==30
            lo = 28.1;
            li = [28.1 26.9 25.9 24.8];
            l620 = 24;
            diameter = 10;
            lengths = 30;
            kink = [0 12 22 33];
            kmax = (28.1-24)/28.1;
                        E = (lo-li)./(lo);
            Erel = (E./kmax);
            testnum = test;
            State = [1 0];
            B0 =[-38.9889,-243.6489,-280.4179,-309.5261;-25.8164,-194.6311,-232.2979,-235.2483];
            B1 =[0.716,0.7439,0.6822,0.6133;0.6618,0.6693,0.6166,0.5041];
            
         end
      elseif diameter == 20
          if lengths == 10
            lo = 9.8;
            li = [9.8, 8.5,7.8];
            l620 = 7.6;
            diameter = 20;
            lengths = 10;
            kink = [0 13 20];
            kmax = (9.8-7.6)/9.8;
                        E = (lo-li)./(lo);
            Erel = (E./kmax);
            testnum = test;
            State = [1 0];
            B0 = [-120.1725,-254.9974,-255.9741;-117.8307,-236.1016,-225.1293];
            B1 = [1.7308,0.8484,0.532;1.6816,0.8222,0.4876];
          elseif lengths == 12
            lo = 12;
            li = [12 11 10]; 
            l620 = 9.1 ; 
            diameter = 20;
            lengths =12;
            kink = [0 10 20];
            kmax = (12-9.1)/12;
                        E = (lo-li)./(lo);
            Erel = (E./kmax);
            testnum = test;
            State = [1 0];
            B0 =[-73.9562,-228.1784,-246.8121;-78.9729,-224.0691,-225.2483];
            B1 =[1.8329,1.3149,0.8961;1.7966,1.3085,0.8608] ;
          elseif lengths == 23
            lo = 22.5;
            li = [22.5 21.9 20.9]; 
            l620 = 17;
            diameter =20 ;
            lengths = 23;
            kink = [0 9 19];
            kmax =(22.5-17)/22.5;
                        E = (lo-li)./(lo);
            Erel = (E./kmax);
            testnum = test;
            State = [1 0];
            B0 =[-193.1132,-285.5341,-299.6463;-181.0135,-262.8829,-273.4042];
            B1 =[2.1845,1.8482,1.5106;2.1498,1.8044,1.4623];

          elseif lengths == 30
            lo = 27.4; 
            li = [27.4 26.1 25.2 24.1]; 
            l620 = 20.7; 
            diameter =20 ;
            lengths =30;
            kmax = (27.4-20.7)/27.4;
                        E = (lo-li)./(lo);
            Erel = (E./kmax);
            kink = [0 14 23 34];
            testnum = test;
            State = [1 0];
            B0 = [-138.4181,-284.4654,-309.7835,-331.1704;-132.6666,-269.9289,-290.9818,-304.3443];
            B1 = [2.3146,2.0557,1.8759,1.4738;2.2916,2.0255,1.8375,1.4227];

          elseif lengths == 40
            lo = 39.8; 
            li = [39.8 36.2 35.1 32.8]; 
            l620 = 29.9; 
            diameter =20 ;
            lengths =40;
            kink = [0 35 46 69];
            kmax =(39.8-29.9)/39.8;
                        E = (lo-li)./(lo);
            Erel = (E./kmax);
            testnum = test;
            State = [1 0];
            B0 =[ -162.5449,-340.6542,-344.231,-355.2951;-153.3159,-318.9088,-319.3926,-321.1931];
            B1 =[ 2.2906,1.7865,1.5472,1.1063;2.2619,1.7423,1.496,1.036];

          end
    end
end