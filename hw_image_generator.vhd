--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.math_real.all;



ENTITY hw_image_generator IS
	GENERIC(
	 
		pixels_y :	INTEGER := 0;    --row that first color will persist until
		pixels_x	:	INTEGER := 0);   --column that first color will persist until
		
		
		
	PORT(
		  
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--column pixel coordinate
		
		x0_input		:	IN	   	BIT;
		x1_input		:	IN	   	BIT;
		x2_input		:	IN	   	BIT;
		x3_input		:	IN	   	BIT;
		x4_input		:	IN	   	BIT;
		
	   y0_input	   :	IN	   	BIT;
		y1_input	   :	IN	   	BIT;
		y2_input	   :	IN	   	BIT;
		y3_input	   :	IN	   	BIT;
		y4_input	   :	IN	   	BIT;
		
      game0	   :	IN	   	BIT; -- 1B game 
		game1	   :	IN	   	BIT; -- 2B game 
		game2	   :	IN	   	BIT; -- 3B game
		game3	   :	IN	   	BIT; -- 5B  game
		game4	   :	IN	   	BIT; -- 9B game
		resetGame :	IN	   	BIT;
		
								
		
		
		
		--check a 360 field 
		red			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
		
	   

END hw_image_generator;


--procedure UNIFORM(variable SEED1, SEED2 : inout POSITIVE;
  --                variable X : out REAL);
ARCHITECTURE behavior OF hw_image_generator IS
BEGIN

	PROCESS(disp_ena, row, column)
	variable x,y:	INTEGER;   --created x and y varibales 
	
	variable xGB,yGB , hold1, hold2:	INTEGER;  -- 1 BOMB game -- default game
	
	
	variable xG1B1,yG1B1, xG1B2 ,yG1B2:	INTEGER;-- 2 BOMB game 

				
	variable xG2B1,yG2B1,xG2B2,yG2B2, xG2B3,yG2B3:	INTEGER;  -- 3 BOMB game
	
	variable xG3B1,yG3B1 , xG3B2,yG3B2 ,xG3B3 ,yG3B3 ,xG3B4 ,yG3B4  , xG3B5,yG3B5 , xG3B6,yG3B6:	INTEGER;  -- 5 BOMB game	
	
	variable xG4B1,yG4B1 ,xG4B2,yG4B2 , xG4B3,yG4B3 ,xG4B4,yG4B4,  xG4B5,yG4B5 ,xG4B6,yG4B6,  xG4B7,yG4B7 ,xG4B8,yG4B8 , xG4B9,yG4B9 :	INTEGER;  -- 9 BOMB game

	
	BEGIN
	 
	--setting the values of x and y to for the use of multiplying them by cordinate later on.
  
 	         IF(x0_input = '1') THEN  
				
				x := 0;
				
				ELSIF(x1_input = '1')THEN
				x :=  1;
				
				ELSIF(x2_input = '1')THEN
				x :=  2;
				
				ELSIF(x3_input = '1')THEN
			    x :=  3;
				
				ELSIF(x4_input = '1')THEN
			    x :=  4;
				ELSE
				x:= -10; --causing white lines fix it later 
					
				END IF;
				
				
			 IF(y0_input = '1') THEN  
				
				y := 0;
				
				ELSIF(y1_input = '1')THEN
				y := 1;
				
				ELSIF(y2_input = '1')THEN
			y :=  2;
				
				ELSIF(y3_input = '1')THEN
				y :=  3;
				
				ELSIF(y4_input = '1')THEN
			    y :=  4;
				ELSE
					y:= -10;--causing white lines fix it later 
				END IF;
				
				
				
				--Chose Game 
				
				IF(game0 = '1')THEN
				--RESET each bomb thing 
		         xGB := 5;	--RESET each bomb thing 
					yGB := 5;	--RESET each bomb thing 
					
					xG1B1 := 5;	--RESET each bomb thing 
					yG1B1 := 5;	--RESET each bomb thing 
					xG1B2 := 5;	--RESET each bomb thing 
					yG1B2 := 5;	--RESET each bomb thing 
					
					xG2B1 := 5;
		      	yG2B1 := 5;		--RESET each bomb thing 
					xG2B2 := 5;	--RESET each bomb thing 
					yG2B2 := 5;	--RESET each bomb thing 
					xG2B3 := 5;	--RESET each bomb thing 
					yG2B3 := 5;	--RESET each bomb thing 
					
					
					
					xG3B1 := 5;	--RESET each bomb thing 
					yG3B1 := 5;					--RESET each bomb thing 
					xG3B2 := 5;	--RESET each bomb thing 
					yG3B2 := 5;				  	--RESET each bomb thing 
					xG3B3 := 5;	--RESET each bomb thing 
					yG3B3 := 5;					  	--RESET each bomb thing 
					xG3B4 := 5;	--RESET each bomb thing 
					yG3B4 := 5;					  	--RESET each bomb thing 
					xG3B5 := 5;	--RESET each bomb thing 
					yG3B5 := 5;	--RESET each bomb thing 
					 
					
					xG4B1 := 5;	--RESET each bomb thing 
					yG4B1 := 5;					--RESET each bomb thing 
					xG4B2 := 5;	--RESET each bomb thing 
					yG4B2 := 5;					  	--RESET each bomb thing 
					xG4B3 := 5;	--RESET each bomb thing 
					yG3B3 := 5;				  	--RESET each bomb thing 
					xG4B4 := 5;	--RESET each bomb thing 
					yG4B4 := 5;	  	--RESET each bomb thing 
					xG4B5 := 5;	--RESET each bomb thing 
					yG4B5 := 5;	--RESET each bomb thing 
					xG4B6 := 5;	--RESET each bomb thing 
					yG4B6 := 5;	--RESET each bomb thing 
					xG4B7 := 5;	--RESET each bomb thing 
					yG4B7 := 5;  	--RESET each bomb thing 
					xG4B8 := 5;	--RESET each bomb thing 
					yG4B8 := 5;	  	--RESET each bomb thing 
					xG4B9 := 5;	--RESET each bomb thing 
					yG4B9 := 5;	--RESET each bomb thing 
				
			--	END RESETING	
					
						--SETTING BOMBS
				
				xGB := 2;
				yGB := 2;
				
				ELSIF(game1 = '1')THEN 
				--RESET each bomb thing 
		   xGB := 5;
					yGB := 5;
					
					xG1B1 := 5;--RESET each bomb thing 
					yG1B1 := 5;--RESET each bomb thing 
					xG1B2 := 5;--RESET each bomb thing 
					yG1B2 := 5;--RESET each bomb thing 
					
					xG2B1 := 5;--RESET each bomb thing 
		      	yG2B1 := 5;	--RESET each bomb thing 
					xG2B2 := 5;--RESET each bomb thing 
					yG2B2 := 5;--RESET each bomb thing 
					xG2B3 := 5;--RESET each bomb thing 
					yG2B3 := 5;--RESET each bomb thing 
					
					
					
					xG3B1 := 5;--RESET each bomb thing 
					yG3B1 := 5;				--RESET each bomb thing 
					xG3B2 := 5;--RESET each bomb thing 
					yG3B2 := 5;				  --RESET each bomb thing 
					xG3B3 := 5;--RESET each bomb thing 
					yG3B3 := 5;					  --RESET each bomb thing 
					xG3B4 := 5;--RESET each bomb thing 
					yG3B4 := 5;					  --RESET each bomb thing 
					xG3B5 := 5;--RESET each bomb thing 
					yG3B5 := 5;--RESET each bomb thing 
					 
					
					xG4B1 := 5;--RESET each bomb thing 
					yG4B1 := 5;				--RESET each bomb thing 
					xG4B2 := 5;--RESET each bomb thing 
					yG4B2 := 5;					  --RESET each bomb thing 
					xG4B3 := 5;--RESET each bomb thing 
					yG3B3 := 5;				  --RESET each bomb thing 
					xG4B4 := 5;--RESET each bomb thing 
					yG4B4 := 5;	  --RESET each bomb thing 
					xG4B5 := 5;--RESET each bomb thing 
					yG4B5 := 5;--RESET each bomb thing 
					xG4B6 := 5;--RESET each bomb thing 
					yG4B6 := 5;--RESET each bomb thing 
					xG4B7 := 5;--RESET each bomb thing 
					yG4B7 := 5;  --RESET each bomb thing 
					xG4B8 := 5;--RESET each bomb thing 
					yG4B8 := 5;	  --RESET each bomb thing 
					xG4B9 := 5;--RESET each bomb thing 
					yG4B9 := 5;--RESET each bomb thing 
				
			--	END RESETING	
					
					
					
					
					--SETTING BOMBS
				
			xG1B1 := 0;
			yG1B1 := 4;
			
			xG1B2 := 4;
			yG1B2 := 3;
				
				ELSIF(game2 = '1')THEN
						--RESET each bomb thing 
		         xGB := 5;
					yGB := 5;
					
					xG1B1 := 5;--RESET each bomb thing 
					yG1B1 := 5;--RESET each bomb thing 
					xG1B2 := 5;--RESET each bomb thing 
					yG1B2 := 5;--RESET each bomb thing 
					
					xG2B1 := 5;--RESET each bomb thing 
		      	yG2B1 := 5;	--RESET each bomb thing 
					xG2B2 := 5;--RESET each bomb thing 
					yG2B2 := 5;--RESET each bomb thing 
					xG2B3 := 5;--RESET each bomb thing 
					yG2B3 := 5;--RESET each bomb thing 
															
					xG3B1 := 5;--RESET each bomb thing 
					yG3B1 := 5;				--RESET each bomb thing 
					xG3B2 := 5;--RESET each bomb thing 
					yG3B2 := 5;				  --RESET each bomb thing 
					xG3B3 := 5;--RESET each bomb thing 
					yG3B3 := 5;					  --RESET each bomb thing 
					xG3B4 := 5;--RESET each bomb thing 
					yG3B4 := 5;					  --RESET each bomb thing 
					xG3B5 := 5;--RESET each bomb thing 
					yG3B5 := 5;--RESET each bomb thing 
					 				
					xG4B1 := 5;--RESET each bomb thing 
					yG4B1 := 5;				--RESET each bomb thing 
					xG4B2 := 5;--RESET each bomb thing 
					yG4B2 := 5;					  --RESET each bomb thing 
					xG4B3 := 5;--RESET each bomb thing 
					yG3B3 := 5;				  --RESET each bomb thing 
					xG4B4 := 5;--RESET each bomb thing 
					yG4B4 := 5;	  --RESET each bomb thing 
					xG4B5 := 5;--RESET each bomb thing 
					yG4B5 := 5;--RESET each bomb thing 
					xG4B6 := 5;--RESET each bomb thing 
					yG4B6 := 5;--RESET each bomb thing 
					xG4B7 := 5;--RESET each bomb thing 
					yG4B7 := 5;  --RESET each bomb thing 
					xG4B8 := 5;--RESET each bomb thing 
					yG4B8 := 5;	  --RESET each bomb thing 
					xG4B9 := 5;--RESET each bomb thing 
					yG4B9 := 5;--RESET each bomb thing 
				
			--	END RESETING	
					
										
										
						--SETTING BOMBS						
					
			xG2B1 := 1;
			yG2B1 := 2;
			
			xG2B2 := 3;
			yG2B2 := 2;
			
			
			xG2B3 := 2;
			yG2B3 := 4;
		
			
				
				ELSIF(game3 = '1')THEN
				   	--RESET each bomb thing 
		         xGB := 5;--RESET each bomb thing 
					yGB := 5;--RESET each bomb thing 
					
					xG1B1 := 5;--RESET each bomb thing 
					yG1B1 := 5;--RESET each bomb thing 
					xG1B2 := 5;--RESET each bomb thing 
					yG1B2 := 5;--RESET each bomb thing 
					
					xG2B1 := 5;--RESET each bomb thing 
		      	yG2B1 := 5;	--RESET each bomb thing 
					xG2B2 := 5;--RESET each bomb thing 
					yG2B2 := 5;--RESET each bomb thing 
					xG2B3 := 5;--RESET each bomb thing 
					yG2B3 := 5;									--RESET each bomb thing 
					
					xG3B1 := 5;--RESET each bomb thing 
					yG3B1 := 5;				--RESET each bomb thing --RESET each bomb thing 
					xG3B2 := 5;--RESET each bomb thing 
					yG3B2 := 5;				  --RESET each bomb thing 
					xG3B3 := 5;--RESET each bomb thing 
					yG3B3 := 5;					  --RESET each bomb thing 
					xG3B4 := 5;--RESET each bomb thing 
					yG3B4 := 5;					  --RESET each bomb thing 
					xG3B5 := 5;--RESET each bomb thing 
					yG3B5 := 5;					 --RESET each bomb thing 
					
					xG4B1 := 5;--RESET each bomb thing 
					yG4B1 := 5;				--RESET each bomb thing --RESET each bomb thing 
					xG4B2 := 5;--RESET each bomb thing 
					yG4B2 := 5;					  --RESET each bomb thing 
					xG4B3 := 5;--RESET each bomb thing 
					yG3B3 := 5;				  --RESET each bomb thing 
					xG4B4 := 5;--RESET each bomb thing 
					yG4B4 := 5;	  --RESET each bomb thing 
					xG4B5 := 5;--RESET each bomb thing 
					yG4B5 := 5;--RESET each bomb thing 
					xG4B6 := 5;--RESET each bomb thing 
					yG4B6 := 5;--RESET each bomb thing 
					xG4B7 := 5;--RESET each bomb thing 
					yG4B7 := 5;  --RESET each bomb thing 
					xG4B8 := 5;--RESET each bomb thing 
					yG4B8 := 5;	  --RESET each bomb thing 
					xG4B9 := 5;--RESET each bomb thing --RESET each bomb thing --RESET each bomb thing 
					yG4B9 := 5;--RESET each bomb thing 
				
			--	END RESETING	
					
				
						--SETTING BOMBS
				
			xG3B1 := 1;
			yG3B1 := 1;
			
			xG3B2 := 3;
			yG3B2 := 1;
        	  
			xG3B3 := 2;
			yG3B3 := 2;
        	  
			xG3B4 := 1;
			yG3B4 := 3;
        	  
			xG3B5 := 3;
			yG3B5 := 3;
        	 
        	  
        	  
				
				ELSIF(game4 = '1')THEN
					--RESET each bomb thing 
		         xGB := 5;
					yGB := 5;
					
					xG1B1 := 5;--RESET each bomb thing 
					yG1B1 := 5;--RESET each bomb thing 
					xG1B2 := 5;--RESET each bomb thing 
					yG1B2 := 5;--RESET each bomb thing 
					
					xG2B1 := 5;--RESET each bomb thing 
		      	yG2B1 := 5;	--RESET each bomb thing 
					xG2B2 := 5;--RESET each bomb thing 
					yG2B2 := 5;--RESET each bomb thing 
					xG2B3 := 5;--RESET each bomb thing 
					yG2B3 := 5;--RESET each bomb thing 
					
					xG3B1 := 5;--RESET each bomb thing 
					yG3B1 := 5;				--RESET each bomb thing 
					xG3B2 := 5;--RESET each bomb thing 
					yG3B2 := 5;				  --RESET each bomb thing 
					xG3B3 := 5;--RESET each bomb thing 
					yG3B3 := 5;					  --RESET each bomb thing 
					xG3B4 := 5;--RESET each bomb thing 
					yG3B4 := 5;					  --RESET each bomb thing 
					xG3B5 := 5;--RESET each bomb thing 
					yG3B5 := 5;--RESET each bomb thing 
					 					
					xG4B1 := 5;--RESET each bomb thing 
					yG4B1 := 5;				--RESET each bomb thing 
					xG4B2 := 5;--RESET each bomb thing 
					yG4B2 := 5;					  --RESET each bomb thing 
					xG4B3 := 5;--RESET each bomb thing 
					yG3B3 := 5;				  --RESET each bomb thing 
					xG4B4 := 5;--RESET each bomb thing 
					yG4B4 := 5;	  --RESET each bomb thing 
					xG4B5 := 5;--RESET each bomb thing 
					yG4B5 := 5;--RESET each bomb thing 
					xG4B6 := 5;--RESET each bomb thing --RESET each bomb thing 
					yG4B6 := 5;--RESET each bomb thing 
					xG4B7 := 5;--RESET each bomb thing 
					yG4B7 := 5;  --RESET each bomb thing 
					xG4B8 := 5;--RESET each bomb thing 
					yG4B8 := 5;	  --RESET each bomb thing 
					xG4B9 := 5;--RESET each bomb thing 
					yG4B9 := 5;--RESET each bomb thing 
				
			--	END RESETING	
					
					
						--SETTING BOMBS
			xG4B1 := 0;
			yG4B1 := 0;
			
			xG4B2 := 1;
			yG4B2 := 1;
        	  
			xG4B3 := 2;
			yG3B3 := 2;
        	  
			xG4B4 := 3;
			yG4B4 := 3;
        	  
			xG4B5 := 4;
			yG4B5 := 4;
			
			xG4B6 := 0;
			yG4B6 := 4;
			
			xG4B7 := 1;
			yG4B7 := 3;
        	  
        	  
			xG4B8 := 3;
			yG4B8 := 1;
        	  
			xG4B9 := 4;
			yG4B9 := 0;
			
			
			ELSIF(resetGame = '1')THEN
			
		--RESET every bomb thing 
--		         xGB := 5;
--					yGB := 5;
--					
--					xG1B1 := 5;
--					yG1B1 := 5;
--					xG1B2 := 5;
--					yG1B2 := 5;
--					
--					xG2B1 := 5;
--		      	yG2B1 := 5;	
--					xG2B2 := 5;
--					yG2B2 := 5;
--					xG2B3 := 5;
--					yG2B3 := 5;
--					
--					xG3B1 := 5;
--					yG3B1 := 5;				
--					xG3B2 := 5;
--					yG3B2 := 5;				  
--					xG3B3 := 5;
--					yG3B3 := 5;					  
--					xG3B4 := 5;
--					yG3B4 := 5;					  
--					xG3B5 := 5;
--					yG3B5 := 5;
--					 					
--					xG4B1 := 5;
--					yG4B1 := 5;				
--					xG4B2 := 5;
--					yG4B2 := 5;					  
--					xG4B3 := 5;
--					yG3B3 := 5;				  
--					xG4B4 := 5;
--					yG4B4 := 5;	  
--					xG4B5 := 5;
--					yG4B5 := 5;
--					xG4B6 := 5;
--					yG4B6 := 5;
--					xG4B7 := 5;
--					yG4B7 := 5;  
--					xG4B8 := 5;
--					yG4B8 := 5;	  
--					xG4B9 := 5;
--					yG4B9 := 5;
				
			--	END RESETING	
		
				
				
	
				ELSE
			
					
				END IF;
  
 
 
 
		IF(disp_ena = '1') THEN		--display time

			---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--MAKING THE BOARD  
			
				
			IF((420 < row AND row <620) AND ((0 < column AND column < 200) OR (220 < column AND column < 420) OR  (440 < column AND column < 640) OR (660 < column AND column < 860) OR (880 < column AND column < 1080))) THEN 

red <= (OTHERS => '0');
green <= (OTHERS => '0'); -- Dark blue SEA
blue <= (OTHERS => '1');
	
				
				
				
			ELSIF((640 < row AND row <840) AND ((0 < column AND column < 200) OR (220 < column AND column < 420) OR  (440 < column AND column < 640) OR (660 < column AND column < 860) OR (880 < column AND column < 1080))) THEN 

red <= (OTHERS => '0');
green <= (OTHERS => '0'); -- Dark blue SEA
blue <= (OTHERS => '1');

				
				
				
				ELSIF((860 < row AND row < 1060) AND ((0 < column AND column < 200) OR (220 < column AND column < 420) OR  (440 < column AND column < 640) OR (660 < column AND column < 860) OR (880 < column AND column < 1080))) THEN 

red <= (OTHERS => '0');
green <= (OTHERS => '0'); -- Dark blue SEA
blue <= (OTHERS => '1');

				
				
				
				ELSIF((1080 < row AND row < 1280) AND ((0 < column AND column < 200) OR (220 < column AND column < 420) OR  (440 < column AND column < 640) OR (660 < column AND column < 860) OR (880 < column AND column < 1080))) THEN 

red <= (OTHERS => '0');
green <= (OTHERS => '0'); -- Dark blue SEA
blue <= (OTHERS => '1');

				
				
				ELSIF((1300 < row AND row < 1500) AND ((0 < column AND column < 200) OR (220 < column AND column < 420) OR  (440 < column AND column < 640) OR (660 < column AND column < 860) OR (880 < column AND column < 1080))) THEN 

red <= (OTHERS => '0');
green <= (OTHERS => '0'); -- Dark blue SEA
blue <= (OTHERS => '1');
					
			
			ELSE
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0'); -- Black 
				blue <= (OTHERS => '0');
			END IF;
		ELSE								--blanking time
			red <= (OTHERS => '0');
			green <= (OTHERS => '0');
			blue <= (OTHERS => '0');
		END IF;
		
		
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER B 
					
			IF((1 < column AND column < 201) AND ((50 < row AND row <80) OR (120 < row AND row <150)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((50 < row AND row <130) AND ((0 < column AND column < 30) OR (85 < column AND column < 115) OR (171 < column AND column < 201)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER A 			
				
			IF((0 < column AND column < 200) AND ((180 < row AND row <210) OR (250 < row AND row <280)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((209 < row AND row <280) AND ((0 < column AND column < 30) OR (85 < column AND column < 115)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
		
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER T1
					
			IF((0 < column AND column < 199) AND ((340 < row AND row <370)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((310 < row AND row <400) AND (0 < column AND column < 30))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER T2
					
			IF((231 < column AND column < 432) AND ((80 < row AND row <110)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((50 < row AND row <140) AND (231 < column AND column < 261))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER L
					
			IF((231 < column AND column < 432) AND ((180 < row AND row <210)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((209 < row AND row <270) AND (402 < column AND column < 432))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER E
					
			IF((231 < column AND column < 432) AND ((300 < row AND row <330)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
				
			IF((300 < row AND row <390) AND ((231 < column AND column < 261) OR (316 < column AND column < 346) OR (402 < column AND column < 432)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER S
					
			IF((462 < column AND column < 548) AND (50 < row AND row <80))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
			End IF;
				
			IF((50 < row AND row <130) AND ((462 < column AND column < 492) OR (547 < column AND column < 577) OR (633 < column AND column < 663)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
			
			IF((100 < row AND row <130) AND (576 < column AND column < 660))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER H
					
			IF((462 < column AND column < 663) AND ((150 < row AND row <180) OR (200 < row AND row <230)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((150 < row AND row <230) AND (547 < column AND column < 577))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER I
					
			IF((462 < column AND column < 663) AND (250 < row AND row <280))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
		
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER P
					
			IF((462 < column AND column < 663) AND (300 < row AND row <330))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
			
			IF((462 < column AND column < 548) AND (350 < row AND row <380))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;	
				
			IF((300 < row AND row <380) AND ((462 < column AND column < 492) OR (547 < column AND column < 577)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
			--THE LETTER A 			
				
			IF((0 < column AND column < 201) AND ((1530 < row AND row <1560) OR (1600 < row AND row <1630)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((1559 < row AND row <1630) AND ((0 < column AND column < 30) OR (85 < column AND column < 115)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER I
					
			IF((0 < column AND column < 201) AND (1660 < row AND row <1690))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER M
					
			IF((0 < column AND column < 201) AND ((1720 < row AND row <1750) OR (1780 < row AND row <1810) OR (1840 < row AND row < 1870)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((1720 < row AND row <1870) AND (0 < column AND column < 30))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER F
					
			IF((231 < column AND column < 432) AND (1530 < row AND row <1560))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((1559 < row AND row <1620) AND ((231 < column AND column < 261) OR (316 < column AND column < 346)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER I
					
			IF((231 < column AND column < 432) AND (1640 < row AND row <1670))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER R
					
			IF((231 < column AND column < 432) AND (1690 < row AND row <1720))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
			
			IF((260 < column AND column < 316) AND (1750 < row AND row <1780))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
		
			IF((1719 < row AND row < 1780) AND ((231 < column AND column < 261) OR (315 < column AND column < 347)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
			
			IF((346 < column AND column < 375) AND (1719 < row AND row <1740))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
			
			IF((375 < column AND column < 403) AND (1740 < row AND row <1760))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
			
			IF((403 < column AND column < 432) AND (1760 < row AND row <1780))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER E
					
			IF((231 < column AND column < 432) AND ((1800 < row AND row <1830)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
				
			IF((1800 < row AND row <1870) AND ((231 < column AND column < 261) OR (316 < column AND column < 346) OR (402 < column AND column < 432)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER W
					
			IF((462 < column AND column < 663) AND ((1530 < row AND row <1560) OR (1590 < row AND row <1620) OR (1650 < row AND row < 1680)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((1530 < row AND row <1680) AND (633 < column AND column < 663))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;			
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER I
					
			IF((462 < column AND column < 663) AND (1710 < row AND row <1740))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;			
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER N
					
			IF((462 < column AND column < 663) AND ((1770 < row AND row <1800) OR (1840 < row AND row <1870)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF((1770 < row AND row <1870) AND (462 < column AND column < 492))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;		
		
		
		

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
--					--THE LETTER H
--					
--				IF((880 < column AND column < 1080) AND ((50 < row AND row <80) OR (120 < row AND row <150) OR (1520 < row AND row < 1550) OR (1590 < row AND row <1620)))Then
--				red <= (OTHERS => '1');
--            green <= (OTHERS => '1'); -- White lettering
--            blue <= (OTHERS => '1');
--         End IF;
--				
--			IF(((50 < row AND row <130) OR (1530 < row AND row < 1595))  AND (965 < column AND column < 995))Then
--				red <= (OTHERS => '1');
--            green <= (OTHERS => '1'); -- White lettering
--            blue <= (OTHERS => '1');
--         End IF;
--					
-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
--					--THE LETTER I			
--	
--
--IF((880 < column AND column < 1080) AND ((210 < row AND row <240) OR (1690 < row AND row < 1720)))Then
--				red <= (OTHERS => '1');
--				green <= (OTHERS => '1'); -- White lettering
--				blue <= (OTHERS => '1');
--         End IF;
--	
--	
--	---------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
--					--THE LETTER T			
--	
--
--IF((880 < column AND column < 1080) AND ((310 < row AND row <340) OR (1790 < row AND row < 1820)))Then
--				red <= (OTHERS => '1');
--				green <= (OTHERS => '1'); -- White lettering
--				blue <= (OTHERS => '1');
--         End IF;
--			
--			IF(((1750 < row AND row < 1840) OR (280 < row AND row <370)) AND (879 < column AND column < 909))Then
--				red <= (OTHERS => '1');
--            green <= (OTHERS => '1'); -- White lettering
--            blue <= (OTHERS => '1');
--         End IF;
--			
			
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER M				
			
--			IF((880 < column AND column < 1080) AND ((50 < row AND row <70) OR (120 < row AND row <140) OR (190 < row AND row <210) OR (1530 < row AND row <1550) OR (1600 < row AND row <1620) OR (1670 < row AND row <1690)))Then
--				red <= (OTHERS => '1');
--            green <= (OTHERS => '1'); -- White lettering
--            blue <= (OTHERS => '1');
--         End IF;
--				
--			IF(((51 < row AND row <209) OR (1531 < row AND row <1689)) AND (880 < column AND column < 910))Then
--				red <= (OTHERS => '1');
--            green <= (OTHERS => '1'); -- White lettering
--            blue <= (OTHERS => '1');
--         End IF;
--			
-------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
--					--THE LETTER I			
--	
--
--IF((880 < column AND column < 1080) AND ((230 < row AND row <250) OR (1710 < row AND row < 1730)))Then
--				red <= (OTHERS => '1');
--				green <= (OTHERS => '1'); -- White lettering
--				blue <= (OTHERS => '1');
--         End IF;
--	
--		
-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
--					--THE LETTER S
--					
--			IF((880 < column AND column < 970) AND ((269 < row AND row <290) OR (350 < row AND row <370) OR (1749 < row AND row <1769) OR (1830 < row AND row <1850)))Then
--				red <= (OTHERS => '1');
--				green <= (OTHERS => '1'); -- White lettering
--				blue <= (OTHERS => '1');
--			End IF;
--				
--			IF(((270 < row AND row <330) OR(350 < row AND row <410) OR (1750 < row AND row <1810) OR(1830 < row AND row < 1890)) AND ((880 < column AND column < 910) OR (970 < column AND column < 989) OR (1050 < column AND column < 1080) ))Then
--				red <= (OTHERS => '1');
--				green <= (OTHERS => '1'); -- White lettering
--				blue <= (OTHERS => '1');
--         End IF;
--			
--         IF((970 < column AND column < 1080) AND ((310 < row AND row <330) OR (390 < row AND row <410) OR (1790 < row AND row <1810) OR (1870 < row AND row <1890)))Then
--				red <= (OTHERS => '1');
--				green <= (OTHERS => '1'); -- White lettering
--				blue <= (OTHERS => '1');
--			End IF;



--					 


					--BASE GAME SW11
					
			IF(game0 = '1')THEN
			
					
         
		IF(x < 5 AND y < 5  AND x > -1 AND y > -1)THEN -- check if user imputed anything 
		
		
		 IF((420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND (0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220))) THEN
		
red <= (OTHERS => '0');
green <= (OTHERS => '1'); -- GREEN  AIMING  
blue <= (OTHERS => '0');

IF((resetGame = '0'))THEN --selcting  
IF((420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND (0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220))) THEN
		
red <= (OTHERS => '1');
green <= (OTHERS => '1'); -- YEllow MISS
blue <= (OTHERS => '0');
END IF;

END IF;


END IF;


END IF;
				
		
	--checking if user hits bomb	
		IF((resetGame = '0') AND (x = xGB AND y = yGB))THEN  
		
		
		---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE RED BOX
		IF((680 < column AND column < 860) AND ((130 < row AND row <330) OR (1630 < row AND row <1830)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '0'); -- White lettering
            blue <= (OTHERS => '0');
         End IF;
	
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER H
					
				IF((880 < column AND column < 1080) AND ((50 < row AND row <80) OR (120 < row AND row <150) OR (1520 < row AND row < 1550) OR (1590 < row AND row <1620)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF(((50 < row AND row <130) OR (1530 < row AND row < 1595))  AND (965 < column AND column < 995))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
					
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER I			
	

IF((880 < column AND column < 1080) AND ((210 < row AND row <240) OR (1690 < row AND row < 1720)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
	
	
	---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER T			
	

IF( (880 < column AND column < 1080) AND ((310 < row AND row <340) OR (1790 < row AND row < 1820)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
			
			IF(((1750 < row AND row < 1840) OR (280 < row AND row <370)) AND (879 < column AND column < 909))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
			

				
		IF(420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND ((0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220)))THEN
  red <= (OTHERS => '1');
green <= (OTHERS => '0'); -- RED bomb  
blue <= (OTHERS => '0');
END IF;
					END IF;
					
					END IF;
		
		
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------


		--GAME  1 SW10
			IF(game1 = '1')THEN
			   
		IF(x < 5 AND y < 5  AND x > -1 AND y > -1)THEN -- check if user imputed anything 
		
		
		 IF((420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND (0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220))) THEN
		
red <= (OTHERS => '0');
green <= (OTHERS => '1'); -- GREEN AIMING  
blue <= (OTHERS => '0');


IF((resetGame = '0') AND (420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND (0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220))) THEN
		
red <= (OTHERS => '1');
green <= (OTHERS => '1'); -- YEllow
blue <= (OTHERS => '0');
END IF;


END IF;


END IF;
			
		--checking if user hits bomb FIX BOMBS
					IF((resetGame = '0') AND ((x = xG1B1 AND y = yG1B1) OR  (x = xG1B2 AND y = yG1B2)))THEN
			
	---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE RED BOX
		IF((680 < column AND column < 860) AND ((130 < row AND row <330) OR (1630 < row AND row <1830)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '0'); -- White lettering
            blue <= (OTHERS => '0');
         End IF;
	
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER H
					
				IF((880 < column AND column < 1080) AND ((50 < row AND row <80) OR (120 < row AND row <150) OR (1520 < row AND row < 1550) OR (1590 < row AND row <1620)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF(((50 < row AND row <130) OR (1530 < row AND row < 1595))  AND (965 < column AND column < 995))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
					
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER I			
	

IF((880 < column AND column < 1080) AND ((210 < row AND row <240) OR (1690 < row AND row < 1720)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
	
	
	---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER T			
	

IF( (880 < column AND column < 1080) AND ((310 < row AND row <340) OR (1790 < row AND row < 1820)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
			
			IF(((1750 < row AND row < 1840) OR (280 < row AND row <370)) AND (879 < column AND column < 909))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
	


	
				
		IF(420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND ((0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220)))THEN
  red <= (OTHERS => '1');
green <= (OTHERS => '0'); -- RED bomb  
blue <= (OTHERS => '0');
END IF;
					END IF;
					END IF;
					
					
					
					
					
					
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------				
			--GAME 2	SW9	
			
			
			IF(game2 = '1')THEN
			   
		IF(x < 5 AND y < 5  AND x > -1 AND y > -1)THEN -- check if user imputed anything 
		
		
		 IF((420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND (0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220))) THEN
		
red <= (OTHERS => '0');
green <= (OTHERS => '1'); -- GREEN AIMING  
blue <= (OTHERS => '0');


IF((resetGame = '0') AND (420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND (0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220))) THEN
		
red <= (OTHERS => '1');
green <= (OTHERS => '1'); -- YEllow
blue <= (OTHERS => '0');
END IF;


END IF;


END IF;
					--checking if user hits bomb
					IF((resetGame = '0') AND ((x = xG2B1 AND y = yG2B1) OR  (x = xG2B2 AND y = yG2B2) OR  (x = xG2B3 AND y = yG2B3)))THEN  
					
					---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE RED BOX
		IF((680 < column AND column < 860) AND ((130 < row AND row <330) OR (1630 < row AND row <1830)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '0'); -- White lettering
            blue <= (OTHERS => '0');
         End IF;
	
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER H
					
				IF((880 < column AND column < 1080) AND ((50 < row AND row <80) OR (120 < row AND row <150) OR (1520 < row AND row < 1550) OR (1590 < row AND row <1620)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF(((50 < row AND row <130) OR (1530 < row AND row < 1595))  AND (965 < column AND column < 995))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
					
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER I			
	

IF((880 < column AND column < 1080) AND ((210 < row AND row <240) OR (1690 < row AND row < 1720)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
	
	
	---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER T			
	

IF( (880 < column AND column < 1080) AND ((310 < row AND row <340) OR (1790 < row AND row < 1820)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
			
			IF(((1750 < row AND row < 1840) OR (280 < row AND row <370)) AND (879 < column AND column < 909))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
		IF(420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND ((0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220)))THEN
  red <= (OTHERS => '1');
green <= (OTHERS => '0'); -- RED bomb 
blue <= (OTHERS => '0');
END IF;
					END IF;
					END IF;
--					
					
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------	



					
			--GAME 3	SW8		
			
			IF(game3 = '1')THEN
			   
		IF(x < 5 AND y < 5  AND x > -1 AND y > -1)THEN -- check if user imputed anything 
		
		
		 IF((420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND (0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220))) THEN
		
red <= (OTHERS => '0');
green <= (OTHERS => '1'); -- GREEN AIMING  
blue <= (OTHERS => '0');


IF((resetGame = '0') AND (420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND (0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220))) THEN
		
red <= (OTHERS => '1');
green <= (OTHERS => '1'); -- YEllow
blue <= (OTHERS => '0');
END IF;


END IF;


END IF;

			--checking if user hits bomb
					IF((resetGame = '0') AND ((x = xG3B1 AND y = yG3B1) OR  (x = xG3B2 AND y = yG3B2) OR  (x = xG3B3 AND y = yG3B3) OR  (x = xG3B4 AND y = yG3B4) OR  (x = xG3B5 AND y = yG3B5)))THEN  
				
				---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE RED BOX
		IF((680 < column AND column < 860) AND ((130 < row AND row <330) OR (1630 < row AND row <1830)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '0'); -- White lettering
            blue <= (OTHERS => '0');
         End IF;
	
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER H
					
				IF((880 < column AND column < 1080) AND ((50 < row AND row <80) OR (120 < row AND row <150) OR (1520 < row AND row < 1550) OR (1590 < row AND row <1620)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF(((50 < row AND row <130) OR (1530 < row AND row < 1595))  AND (965 < column AND column < 995))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
					
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER I			
	

IF((880 < column AND column < 1080) AND ((210 < row AND row <240) OR (1690 < row AND row < 1720)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
	
	
	---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER T			
	

IF( (880 < column AND column < 1080) AND ((310 < row AND row <340) OR (1790 < row AND row < 1820)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
			
			IF(((1750 < row AND row < 1840) OR (280 < row AND row <370)) AND (879 < column AND column < 909))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
				
		IF(420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND ((0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220)))THEN
  red <= (OTHERS => '1');
green <= (OTHERS => '0'); -- RED bomb 
blue <= (OTHERS => '0');
END IF;
					END IF;
					END IF;
					
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------


				
					--GAME 4 SW7
					IF(game4 = '1')THEN
			   
		IF(x < 5 AND y < 5  AND x > -1 AND y > -1)THEN -- check if user imputed anything 
		
		
		 IF((420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND (0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220))) THEN
		
red <= (OTHERS => '0');
green <= (OTHERS => '1'); -- GREEN AIMING  
blue <= (OTHERS => '0');


IF((resetGame = '0') AND (420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND (0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220))) THEN
		
red <= (OTHERS => '1');
green <= (OTHERS => '1'); -- YEllow
blue <= (OTHERS => '0');
END IF;


END IF;


END IF;

					--checking if user hits bomb
					IF((resetGame = '0') AND ((x = xG4B1 AND y = yG4B1)  OR (x = xG4B2 AND y = yG4B2)	OR  (x = xG4B3 AND y = yG4B3) OR  (x = xG4B4 AND y = yG4B4) OR  (x = xG4B5 AND y = yG4B5) OR (x = xG4B6 AND y = yG4B6) OR  (x = xG4B7 AND y = yG4B7) OR (x = xG4B8 AND y = yG4B8) OR  (x = xG4B9 AND y = yG4B9)))THEN  
				
				---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE RED BOX
		IF((680 < column AND column < 860) AND ((130 < row AND row <330) OR (1630 < row AND row <1830)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '0'); -- White lettering
            blue <= (OTHERS => '0');
         End IF;
	
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER H
					
				IF((880 < column AND column < 1080) AND ((50 < row AND row <80) OR (120 < row AND row <150) OR (1520 < row AND row < 1550) OR (1590 < row AND row <1620)))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
			IF(((50 < row AND row <130) OR (1530 < row AND row < 1595))  AND (965 < column AND column < 995))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
					
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER I			
	

IF((880 < column AND column < 1080) AND ((210 < row AND row <240) OR (1690 < row AND row < 1720)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
	
	
	---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
					--THE LETTER T			
	

IF( (880 < column AND column < 1080) AND ((310 < row AND row <340) OR (1790 < row AND row < 1820)))Then
				red <= (OTHERS => '1');
				green <= (OTHERS => '1'); -- White lettering
				blue <= (OTHERS => '1');
         End IF;
			
			IF(((1750 < row AND row < 1841) OR (280 < row AND row <370)) AND (879 < column AND column < 909))Then
				red <= (OTHERS => '1');
            green <= (OTHERS => '1'); -- White lettering
            blue <= (OTHERS => '1');
         End IF;
				
				
				
			IF(420 +(220 * (x)) < row AND row < 400 +(220 * (x+1)) AND ((0 + (220 * (y)) < column AND column < 200 +(220 * (y+1))-220)))THEN
  red <= (OTHERS => '1');
green <= (OTHERS => '0'); -- RED bomb 
blue <= (OTHERS => '0');
END IF;
			END IF;
			
			
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
--					
					END IF;
	
	
	END PROCESS;
	
	
	
END behavior;


