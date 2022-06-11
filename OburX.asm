#####################################################################
#	
#	PROJECT TITLE: OBURX
#	
#	PROJECT MEMBERS: 
#										MUHSIN ESAD TORUN  - 200722131
#										ZEYNEP ARSLAN			 - 180722011
#										HILAL KOC					 - 180723011
#
#
#
####################################################################
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8 (update this as needed)
# - Unit height in pixels: 8 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed)
# - Base Address for Display: 0x10008000 ($gp)
#
#####################################################################
#This game requires you to eat carefully by making calorie calculations. In the game, you have to collect 
#the foods that you can come across, including healthy foods and unhealthy foods. However, there is 
#something you need to be careful while collecting the dishes. YOUR WEIGHT. If you pack too many 
#unhealthy foods, you can gain a lot of weight and have a heart attack. But even if you don't collect 
#enough nutrients, you run the risk of dying. The healthier you eat, the better your chances of survival. 
#Remember this is just a game
#####################################################################
#						w									P --> Reset Button
#					A S D     
#####################################################################
#	The game is played with W A S D keys.
#	Apples 30 calories
#	Mushrooms 50 calories.
#	Hamburgers are 100 calories.
#
# Game over at 1000 calories.
# Beware, you may die of hunger !!!				
#
#####################################################################
.eqv BASE_ADDRESS 0x10008000
.eqv man_pos $s0 # absolute position in memory
.eqv man_col $s1
.eqv calorie $s3
.
.eqv timer $s4
.eqv timer_bar $s5
.eqv calorie_intake $s6
.eqv dead $t7

.eqv SLEEP 80
.eqv GAME_LENGTH 60 # game runs for 60*13*80 = 62.4 sec


.data

# TEXT
text: .asciiz "Stored Calories: "
death_1_text: .asciiz "It is a great achievement to die of hunger in so much food. You may have a chronic eating disorder in real life. I suggest you see a doctor immediately.\n"
death_2_text: .asciiz "Obesity was your end. You're stricken with a heart attack. May God rest your soul in heaven. BYE BYE\n"

# Relative coordinates of colored tiles:
# player man:
man_colors:.word 0xFFE5CC,     0x0000FF,0xFFE5CC,0x0000FF,      0x0000FF,    0xFFE5CC 
man_coord: .word 12,136,140,144,268,392,400

# apple
food1_colors: .word 0x99FF99,0xFF0000,0xFF0000,0xFF0000,0xFF0000,0xFF0000,0xFF0000
food1_coord: .word 4,128,132,136,256,260,264
food1_pos: .word 0, 100,200, 300, 1500


# hamburger
fastFood1_colors: .word 0xFFD400, 0xFFD400,0xFFD400,0x663300,0x663300,0x663300, 0xFFD400, 0xFFD400, 0xFFD400
fastFood1_coord: .word 0,4,8,128,132,136,256,260,264
fastFood1_pos: .word 1000,2000


# mushrom
mushroom_colors: .word 0x990000,0x990000,0x990000,0xFFFFFF,0xFFFFFF
mushroom_coord: .word 0,4,8,132,260
mushroom_pos: .word 100


.text
# $s0 stores man_pos
.globl main
main:

# init calorie_intake
	li calorie_intake,100
# init man:
	li man_pos, 1800
	la man_col, man_colors # store man color address
# init calorie:
	li calorie,0
# init timer stuff
	li timer,0#setting timer
	li timer_bar,3960# get location of blue timer bar, see below

	# making white base 
		li $t9, 4092 # till end
		li $t8, 3712 # start from 29th row
		li $t0 0xffffff 
	white_base:
		sw $t0, BASE_ADDRESS($t8) 
		addi $t8,$t8,4
		ble $t8,$t9,white_base
		li $t9, 3960 # till end
		li $t8, 3844 # start from 29th row
		li $t0 0xd50000 
	time_bar: # 30 pixels
		sw $t0, BASE_ADDRESS($t8) 
		addi $t8,$t8,4
		ble $t8,$t9,time_bar
 
	# ---------------- #

# algorithm to clear entire screen:
	# ---------------- #
	li $t9, 3712
	li $t8, 0
	clear:
	sw $zero, BASE_ADDRESS($t8) 
	addi $t8,$t8,4
	bne $t8,$t9,clear
	# ----------------- #
	
###################################### print INTROOOOO :D:D:D OburX ###########################
	li $t0, BASE_ADDRESS
	li $t1, 0xFF007F #pink
	 #O
        sw $t1, 656($t0)
    	sw $t1, 660($t0)
    	sw $t1, 664($t0)
    	sw $t1, 668($t0)
    	sw $t1, 672($t0)
    
    	sw $t1, 784($t0)
    	sw $t1, 800($t0)
    
    	sw $t1, 912($t0)
   	sw $t1, 928($t0)
    
    	sw $t1, 1040($t0)
   	sw $t1, 1056($t0)
   	 
    	sw $t1, 1168($t0)		
    	sw $t1, 1184($t0)	
    
    	sw $t1, 1296($t0)
    	sw $t1, 1312($t0)
    
    	sw $t1, 1424($t0)
    	sw $t1, 1428($t0)
    	sw $t1, 1432($t0)
    	sw $t1, 1436($t0)
    	sw $t1, 1440($t0)
    
   	 #B
    	sw $t1, 680($t0)
    	sw $t1, 684($t0)
    	sw $t1, 688($t0)
    	sw $t1, 692($t0)
    
    	sw $t1, 808($t0)
    	sw $t1, 824($t0)
    
    	sw $t1, 936($t0)
    	sw $t1, 952($t0)
    
    	sw $t1, 1064($t0)
    	sw $t1, 1068($t0)
    	sw $t1, 1072($t0)
    	sw $t1, 1076($t0)
    
    	sw $t1, 1192($t0)
    	sw $t1, 1208($t0)
    
    	sw $t1, 1320($t0)
    	sw $t1, 1336($t0)
    
    
    	sw $t1, 1448($t0)
    	sw $t1, 1452($t0)
    	sw $t1, 1456($t0)
    	sw $t1, 1460($t0)	
    
    	#U
    
    	sw $t1, 704($t0)
    	sw $t1, 720($t0)
    
    	sw $t1, 832($t0)
    	sw $t1, 848($t0)
   
    	sw $t1, 960($t0)
    	sw $t1, 976($t0)
    
    	sw $t1, 1088($t0)
    	sw $t1, 1104($t0)
    
    	sw $t1, 1216($t0)
    	sw $t1, 1232($t0)
    
    	sw $t1, 1344($t0)
    	sw $t1, 1360($t0)
    
    	sw $t1, 1472($t0)
    	sw $t1, 1476($t0)
    	sw $t1, 1480($t0)
    	sw $t1, 1484($t0)
    	sw $t1, 1488($t0)
    
    	#R
    
    	sw $t1, 728($t0)
    	sw $t1, 732($t0)
    	sw $t1, 736($t0)
    	sw $t1, 740($t0)
    
    	sw $t1, 856($t0)
    	sw $t1, 872($t0)
    
    	sw $t1, 984($t0)
    	sw $t1, 1000($t0)
    
    	sw $t1, 1112($t0)
    	sw $t1, 1116($t0)
    	sw $t1, 1120($t0)
    	sw $t1, 1124($t0)
    
    	sw $t1, 1240($t0)
    	sw $t1, 1248($t0)
    
    	sw $t1, 1368($t0)
    	sw $t1, 1380($t0)
    
    	sw $t1, 1496($t0)
    	sw $t1, 1512($t0)
    
    	#X
    
    	sw $t1, 1836($t0)
    	sw $t1, 1868($t0)
    
    	sw $t1, 1968($t0)
    	sw $t1, 1992($t0)
    
    	sw $t1, 2100($t0)
    	sw $t1, 2116($t0)
    
    	sw $t1, 2232($t0)
    	sw $t1, 2240($t0)
    
    	sw $t1, 2364($t0)
    
    	sw $t1, 2496($t0)
    	sw $t1, 2488($t0)
    
    	sw $t1, 2628($t0)
    	sw $t1, 2612($t0)
    
    	sw $t1, 2736($t0)
    	sw $t1, 2760($t0)
    
    	sw $t1, 2860($t0)
    	sw $t1, 2892($t0)
	
	li $v0, 32 #loading sleep service
	li $a0, 2000 # Wait
	syscall

# resetting timer bar:
	li $t9, 3960 # till end
	li $t8, 3844 # start from 29th row
	li $t0 0x03a8f4 #blue 
time_bar1: # 30 pixels
	sw $t0, BASE_ADDRESS($t8) 
	addi $t8,$t8,4
	li $v0, 32 #loading sleep service
	li $a0, 80 # Wait
	syscall
	ble $t8,$t9,time_bar1 # if end not reached loop again
	
	li $v0, 32 #loading sleep service
	li $a0, 5000 # Wait
	syscall

# re-initialize stuff
	li man_pos, 1800 # re-position man
# init calorie:
	li calorie,0
# init timer stuff
	li timer,0#setting timer
	li timer_bar,3960# get location of blue timer bar, see below
	
############# -------------------------------------------------------------------------- GAME --------------------------------------------------------------------------------------- ###############

game:

# -------------------------------------------- CLEARING SCREEN -------------------------------------------------- #
# algorithm to clear entire screen:
# ---------------- #
li $t9, 3712 # upper limit of loop vairable
li $t8, 0 # loop vairable
li $t0,0xFFB266 
clear3:
	sw $t0, BASE_ADDRESS($t8) 
	addi $t8,$t8,4
bne $t8,$t9,clear3
# ----------------- #
# -------------------------------------------- CLEARING SCREEN ENDS-------------------------------------------------- #


# -------------------------------------------- UPDATE POSITIONS -------------------------------------------------- #

# recieve input asdw and update man position
# ------------------ #
	jal check_input
# ----------------- #
# ------------- #
# to update the position if still rendering
		
# ------------ #

# ------- update food1_pos ----------#
# this foodroid can only move left at speed 1 pixel, from pixel 0-26

	jal updating_food1 # function call
# ------------------ #

# update fastFood1_pos
# ------------------- #

lw $t0,  fastFood1_pos  # $t0 holds value fastFood1_pos

# do a check to see out-of-bounds
	sll $t1, $t0,25 # gets x coordinate in upper bits
	beqz $t1, new_pos_fastFood1 # checks if x ==0, then out of bounds
	srl $t1, $t0,7 # gets y coordinate to lower bits
	beqz $t1, new_pos_fastFood1 # checks if y ==0, then out of bounds
	addi $t1,$t1,-27 # compute y-27
	beqz $t1, new_pos_fastFood1 # checks if y-30 ==0, then out of bounds

# compute next position
	addi $t0, $t0, -8 # move left by 8(2 pixel) # speed can be changed here, be careful! init pos should be a multiple of this
	li $t1,1 # to move 1 pixel down
	sll $t1,$t1,7
	add $t0,$t0,$t1 # move down by 4(1 pixel)
	j update_fastFood1
# choose new y coord when out of bounds
new_pos_fastFood1:
	li $v0, 42 #load service number
	li $a0, 0 #choose number generator
	li $a1, 25 #max value 0-25
	syscall
# setting y coord:
	addi $t0,$a0,1 # y value from 1-26 
	sll $t0,$t0,7 # shift $t0 left 7
	addi $t0, $t0,-8 # square off with right side

update_fastFood1:
	sw $t0,fastFood1_pos# update mushroom_pos in memory
# ------------------ #
# update mushroom_pos
# ------------------- #

lw $t0,  mushroom_pos  # $t0 holds value fastFood1_pos

# do a check to see out-of-bounds
	sll $t1, $t0,25 # gets x coordinate in upper bits
	beqz $t1, new_pos_mushroom # checks if x ==0, then out of bounds
	srl $t1, $t0,7 # gets y coordinate to lower bits
	beqz $t1, new_pos_mushroom # checks if y ==0, then out of bounds
	addi $t1,$t1,-27 # compute y-27
	beqz $t1, new_pos_mushroom # checks if y-30 ==0, then out of bounds

# compute next position
	addi $t0, $t0, -4 # move left by 4(1 pixel) # speed can be changed here, be careful! init pos should be a multiple of this
	li $t1,-1 # to move 1 pixel up
	sll $t1,$t1,7
	add $t0,$t0,$t1 # move down by 4(1 pixel)
	j update_mushroom
# choose new y coord when out of bounds
new_pos_mushroom:
	li $v0, 42 #load service number
	li $a0, 0 #choose number generator
	li $a1, 25 #max value 0-25
	syscall
# setting y coord:
	addi $t0,$a0,1 # y value from 1-26 
	sll $t0,$t0,7 # shift $t0 left 7
	addi $t0, $t0,-8 # square off with right side

update_mushroom:
	sw $t0,mushroom_pos# update fastFood1_pos in memory
# ------------------ #

# -------------------------------------------- UPDATE POSITIONS -------------------------------------------------- #

# -------------------------------------------- RENDERING -------------------------------------------------- #

# --------------- #
	jal rendering_man
# --------------- #
# ----------------- #

	jal rendering_food1 
# ----------------- #


# algorithm to render foodr2
# ------------------ #
lw $t1, fastFood1_pos # load value of fastFood1_pos
addi $t1, $t1,BASE_ADDRESS# get absolute position of where food2 starts

li $t8,32
	render_fastFood1:
	#getting pixel color
		lw $t5, fastFood1_colors($t8)# load color into $t5
	# getting pixel address
		lw $t0, fastFood1_coord($t8) # load relative address of xth pixel of food2
		add $t0,$t0,$t1# now $t0 is absolute address of xth pixel
	# check for collision:
		lw $t2, 0($t0) # pixel color to check
		# checks if cuurent color is man colors
		beq $t2,  0xFFE5CC, fastFood1_col_detected
		beq $t2, 0x0000FF , fastFood1_col_detected
		
		j fastFood1_col_end
	fastFood1_col_detected:
		li calorie, 2 # calorie done by food1
		li $t2,0 # reset position food1
		sw $t2, fastFood1_pos($zero)
		j fastFood1_render_end # stop rendering 
	fastFood1_col_end:
	# displaying pixel color
		sw $t5, 0($t0) # store colour on framebuffer
	
	addi $t8,$t8,-4#decrement counter
	bgez $t8, render_fastFood1#check if counter x != 0, then loop
fastFood1_render_end:
# ----------------- #

# algorithm to render mushroom
# ------------------ #
lw $t1, mushroom_pos # load value of fastFood1_pos
addi $t1, $t1,BASE_ADDRESS# get absolute position of where food2 starts

li $t8,16 
	render_mushroom:
	#getting pixel color
		lw $t5, mushroom_colors($t8)# load color into $t5
	# getting pixel address
		lw $t0, mushroom_coord($t8) # load relative address of xth pixel of mushroom
		add $t0,$t0,$t1# now $t0 is absolute address of xth pixel
	# check for collision:
		lw $t2, 0($t0) # pixel color to check
		# checks if cuurent color is man colors: 

		beq $t2,  0xFFE5CC, mushroom_col_detected
		beq $t2, 0x0000FF , mushroom_col_detected
		j mushroom_col_end
	mushroom_col_detected:
		li calorie, 3 # calorie done by food1
		li $t2,0 # reset position food1
		sw $t2, mushroom_pos($zero)
		j mushroom_render_end # stop rendering 
	mushroom_col_end:
	# displaying pixel color
		sw $t5, 0($t0) # store colour on framebuffer
	
	addi $t8,$t8,-4 #decrement counter
	bgez $t8, render_mushroom#check if counter x != 0, then loop
mushroom_render_end:
#####################

# ----------------- #
bne calorie,1,no2 #check if calorie is done
		addi calorie_intake,calorie_intake,30
		
		li $v0,4
		la $a0, text
		syscall
		li $v0, 1
		add $a0,calorie_intake,$zero
		syscall
		li $v0, 11
		li $a0, '\n'
		syscall
		li dead, 2
		bge calorie_intake, 1000, game_over
		li dead, 0
		li calorie,0
no2:
	bne calorie,2,no_calorie2
		addi calorie_intake,calorie_intake,100
		
		li $v0,4
		la $a0, text
		syscall
		li $v0, 1
		add $a0,calorie_intake,$zero
		syscall
		li $v0, 11
		li $a0, '\n'
		syscall
		li dead, 2
		bge calorie_intake, 1000, game_over
		li dead, 0
		li calorie,0
no_calorie2:
		bne calorie,3,no_calorie3
		addi calorie_intake,calorie_intake,50
		
		li $v0,4
		la $a0, text
		syscall
		li $v0, 1
		add $a0,calorie_intake,$zero
		syscall
		li $v0, 11
		li $a0, '\n'
		syscall
		li dead, 2
		bge calorie_intake, 1000, game_over
		li dead, 0
		li calorie,0
no_calorie3:
#######################

# -------------------------------------------- RENDERING END -------------------------------------------------- #

# sleep stuff
	li $v0, 32 #loading sleep service
	li $a0, SLEEP # Wait
	syscall

# timer stuff:
# ------------ #
	addi timer,timer,1 # increment timer
	blt timer,GAME_LENGTH,game # check if 60 frames have passed

	li timer, 0 # reset timer
	sw $zero, BASE_ADDRESS(timer_bar)# reduce timer on timer_bar
	addi timer_bar,timer_bar,-4 # decrement timer_bar address
	addi calorie_intake,calorie_intake,-50
	li $v0,4
	la $a0, text
	syscall
	li $v0, 1
	add $a0,calorie_intake,$zero
	syscall
	li $v0, 11
	li $a0, '\n'
	syscall
	
	li dead, 1	
	ble calorie_intake, 0, game_over
	li dead, 0

	beq timer_bar,3840, done_game # if all of timer bar is decremented, The game ends successfully. 
#3840
j game

############# -------------------------------------------------------------------------- GAME ENDS --------------------------------------------------------------------------------------- ###############

done_game:
		li $t9, 3712 # upper limit of loop vairable
		li $t8, 0 # loop vairable
		li $t1,0x00FF00
	clear5:
		sw $t0, BASE_ADDRESS($t8) 
		addi $t8,$t8,4
		li $v0, 32 #loading sleep service
		li $a0, 5 # Wait to create an effect
		syscall
		bne $t8,$t9,clear5
print_win:
	li $t0, BASE_ADDRESS
	li $t1, 0x00FFFF
#y
	sw $t1, 1052($t0)
	sw $t1, 1068($t0)
	sw $t1, 1184($t0)
	sw $t1, 1192($t0)
	sw $t1, 1316($t0)
	sw $t1, 1444($t0)
	sw $t1, 1572($t0)
	
	#O
	sw $t1, 1076($t0)
	sw $t1, 1080($t0)
	sw $t1, 1084($t0)
	sw $t1, 1088($t0)
	
	sw $t1, 1204($t0)
	sw $t1, 1216($t0)
	
	sw $t1, 1332($t0)
	sw $t1, 1344($t0)
	
	sw $t1, 1460($t0)
	sw $t1, 1472($t0)
	
	sw $t1, 1588($t0)
	sw $t1, 1592($t0)
	sw $t1, 1596($t0)
	sw $t1, 1600($t0)
	
	#U
	sw $t1, 1096($t0)
	sw $t1, 1108($t0)
	
	sw $t1, 1224($t0)
	sw $t1, 1236($t0)
	
	sw $t1, 1352($t0)
	sw $t1, 1364($t0)
	
	sw $t1, 1480($t0)
	sw $t1, 1492($t0)
	
	sw $t1, 1608($t0)
	sw $t1, 1612($t0)
	sw $t1, 1616($t0)
	sw $t1, 1620($t0)
	
	#F
	sw $t1, 2080($t0)
	sw $t1, 2084($t0)
	sw $t1, 2088($t0)
	sw $t1, 2092($t0)
	
	sw $t1, 2208($t0)
	
	
	sw $t1, 2336($t0)
	sw $t1, 2340($t0)
	sw $t1, 2344($t0)
	

	sw $t1, 2464($t0)
	
	sw $t1, 2592($t0)
	
	#I
	sw $t1, 2104($t0)
	sw $t1, 2232($t0)
	sw $t1, 2360($t0)
	sw $t1, 2488($t0)
	sw $t1, 2616($t0)
	
	#T
	sw $t1, 2116($t0)
	sw $t1, 2120($t0)
	sw $t1, 2124($t0)
	sw $t1, 2128($t0)
	sw $t1, 2132($t0)
	
	sw $t1, 2252($t0)
	sw $t1, 2380($t0)
	sw $t1, 2508($t0)
	sw $t1, 2636($t0)
	
	j resetting
    
game_over:
# algorithm to clear entire screen:
# ---------------- #
li $t9, 3712 # upper limit of loop vairable
li $t8, 0 # loop vairable
li $t0,0x000000 #black
clear4:
	sw $t0, BASE_ADDRESS($t8) 
	addi $t8,$t8,4
	li $v0, 32 #loading sleep service
	li $a0, 5 # Wait to create an effect
	syscall
bne $t8,$t9,clear4

print_loser:
	li $t0, BASE_ADDRESS
	li $t1, 0xFF0000
	#heart
	sw $t1, 816($t0)
	sw $t1, 820($t0)
	sw $t1, 836($t0)
	sw $t1, 840($t0)
	
	sw $t1, 940($t0)
	sw $t1, 952($t0)
	sw $t1, 960($t0)
	sw $t1, 972($t0)
	
	sw $t1, 1064($t0)
	sw $t1, 1084($t0)
	sw $t1, 1104($t0)
	
	sw $t1, 1192($t0)
	sw $t1, 1232($t0)
	
	sw $t1, 1324($t0)
	sw $t1, 1356($t0)
	
	sw $t1, 1456($t0)
	sw $t1, 1480($t0)
	
	sw $t1, 1588($t0)
	sw $t1, 1604($t0)
	
	sw $t1, 1720($t0)
	sw $t1, 1728($t0)
	
	sw $t1, 1852($t0)
	
	
	#A
	
	sw $t1, 2176($t0)
	sw $t1, 2180($t0)
	sw $t1, 2184($t0)
	sw $t1, 2188($t0)
	
	sw $t1, 2304($t0)
	sw $t1, 2316($t0)
	
	sw $t1, 2432($t0)
	sw $t1, 2436($t0)
	sw $t1, 2440($t0)
	sw $t1, 2444($t0)
	
	sw $t1, 2560($t0)
	sw $t1, 2572($t0)
	
	sw $t1, 2688($t0)
	sw $t1, 2700($t0)
	
	#T
	sw $t1, 2196($t0)
	sw $t1, 2200($t0)
	sw $t1, 2204($t0)
	sw $t1, 2208($t0)
	sw $t1, 2212($t0)
	
	sw $t1, 2332($t0)
	sw $t1, 2460($t0)
	sw $t1, 2588($t0)
	sw $t1, 2716($t0)
	
	#T
	
	sw $t1, 2220($t0)
	sw $t1, 2224($t0)
	sw $t1, 2228($t0)
	sw $t1, 2232($t0)
	sw $t1, 2236($t0)
	
	sw $t1, 2356($t0)
	sw $t1, 2484($t0)
	sw $t1, 2612($t0)
	sw $t1, 2740($t0)
	
	#A
	sw $t1, 2244($t0)
	sw $t1, 2248($t0)
	sw $t1, 2252($t0)
	sw $t1, 2256($t0)
	
	sw $t1, 2372($t0)
	sw $t1, 2384($t0)
	
	sw $t1, 2500($t0)
	sw $t1, 2504($t0)
	sw $t1, 2508($t0)
	sw $t1, 2512($t0)
	
	sw $t1, 2628($t0)
	sw $t1, 2640($t0)
	
	sw $t1, 2756($t0)
	sw $t1, 2768($t0)
	
	#C
	
	sw $t1, 2264($t0)
	sw $t1, 2268($t0)
	sw $t1, 2272($t0)
	sw $t1, 2276($t0)
	
	sw $t1, 2392($t0)
	sw $t1, 2520($t0)
	sw $t1, 2648($t0)
	
	sw $t1, 2776($t0)
	sw $t1, 2780($t0)
	sw $t1, 2784($t0)
	sw $t1, 2788($t0)
	
	#K
	sw $t1, 2284($t0)
	sw $t1, 2296($t0)
	
	sw $t1, 2412($t0)
	sw $t1, 2420($t0)
	
	sw $t1, 2540($t0)
	sw $t1, 2544($t0)
	
	sw $t1, 2668($t0)
	sw $t1, 2676($t0)
	
	sw $t1, 2796($t0)
	sw $t1, 2808($t0)
# ----------------- #
	
bne dead, 1, death_2
		li $v0,4
		la $a0, death_1_text
		syscall
		li dead,0
death_2:
	bne dead, 2, zombie
		li $v0,4
		la $a0, death_2_text
		syscall
		li dead,0
zombie:
# ---------------- #



resetting:
	li $v0, 32
	li $a0, 80 # Wait one second (1000 milliseconds)
	syscall

	li $t9, 0xffff0000 # load address to check MMIO event
	lw $t8, 0($t9) # load value of MMIO event
	bne $t8, 1, resetting # jump if not keystoke

	lw $t0, 4($t9) # get ASCII value of key stroke into $t0
	beq $t0, 112, pressed_p
	j resetting




li $v0, 10 # terminate the program gracefully
syscall


# -------------------- FUCNTIONS ------------------- #

check_input: # void check_input(void)
	# recieve input asdw and update man position( function )
	# ------------------ #

	li $t9, 0xffff0000 # load address to check MMIO event
	lw $t8, 0($t9) # load value of MMIO event
	bne $t8, 1, input_end

	lw $t0, 4($t9) # get ASCII value of key stroke into $t0

	beq $t0, 97, pressed_a 
	beq $t0, 100, pressed_d
	beq $t0, 119, pressed_w
	beq $t0, 115, pressed_s 
	beq $t0, 112, pressed_p
	j input_end

	pressed_a: # move left
	# check if out of bounds
		sll $t1, man_pos, 25 # $t1 is non-zero when x is non-zero
		beqz $t1, input_end # if x = 0, then man is at left bound of map, goto end
		addi man_pos,man_pos,-4# moves position to left
		j input_end
	pressed_d: # move right
	# check if out of bounds
		addi $t1, man_pos,-104
		sll $t1, $t1, 25 # $t1 is non-zero when x-104 is non-zero
		beqz $t1, input_end # if x-104=0, man is at right bound of map
		addi man_pos,man_pos,4 # moves position to right
		j input_end
	pressed_w: # move up
	# check if out of bounds:
		srl $t1, man_pos, 7 # $t1 now stores y coord
		beqz $t1, input_end # if y==0, man is out of bounds and goto input_end
		li $t1,4  # to move 1 pixel up
		sll $t1,$t1,7 # since y coord starts after 7th bit
		sub man_pos, man_pos, $t1 #  y = y -1
		j input_end
	pressed_s: # move down
	# check if out of bounds:
		srl $t1, man_pos, 7 # $t1 now stores y coord
		addi $t1,$t1, -26
		beqz $t1, input_end # if y-29==0, man is out of bounds and goto input_end
		li $t1,4 # to move 1 pixel down
		sll $t1,$t1,7 # since y coord starts after 7th bit
		add man_pos, man_pos, $t1 # y = y + 4
		j input_end
	pressed_p:
		j main
	input_end:
	jr $ra
# ----------------- #

rendering_man:
	# function  to render the man
addi $t1, man_pos,BASE_ADDRESS# get abs position of man



li $t0, 0xFFE5CC #ten rengi
sw $t0, 12($t1)  # saving color in framebuffer

sw $t0, 136($t1) # saving color in framebuffer
li $t0, 0x0000FF #blue
sw $t0, 140($t1) # saving color in framebuffer
li $t0, 0xFFE5CC #ten rengi
sw $t0, 144($t1) # saving color in framebuffer


li $t0, 0x0000FF #blue
sw $t0, 268($t1) # saving color in framebuffer
li $t0, 0xFFE5CC #ten rengi

sw $t0, 392($t1) # saving color in framebuffer
sw $t0, 400($t1) # saving color in framebuffer


	jr $ra
# ----------------- #


# ------- update food1_pos ----------#
# this foodroid can only move left at speed 1 pixel, from pixel 0-26
updating_food1 : # function void updating_food1(void)
	li $t9,12 

	update_next_food1:

		la $t0, food1_pos($t9) # address to food1_pos
		lw $t0, 0($t0) # $t0 holds value food1_pos

		# do a check to see out-of-bounds
			sll $t1, $t0,25 # gets x coordinate in upper bits
			beqz $t1, new_pos_food1 # checks if x ==0, then get random pos
		# compute next position
			addi $t0, $t0, -4 # move left by 4(1 pixel)
			j update_food1
		# choose new y coord when out of bounds
		new_pos_food1:
			li $v0, 42 #load service number
			li $a0, 0 #choose number generator
			li $a1, 26 # pick number from 0-26
			syscall
		# setting y coord:
			move $t0,$a0
			sll $t0,$t0,7 # shift $t0 left 7
			addi $t0, $t0,-12
		update_food1:
			sw $t0,food1_pos($t9) # update food1_pos in memory
	
	addi $t9,$t9,-4
	bgez $t9,update_next_food1
	
	jr $ra
# ------------------ #


# algorithm to render foodr1
# ------------------ #
rendering_food1:
	li $t9,12 

	render_next_food1:
	la $t1, food1_pos($t9) # load adress to food1_pos
	lw $t1, 0($t1) # load value of food1_pos
	addi $t1, $t1,BASE_ADDRESS# get absolute position of where food1 starts

	li $t8,24 
	render_food1:
	#getting pixel color
		la $t5, food1_colors
		add $t5, $t5, $t8 # address of xth colour is into $t5
		lw $t5, 0($t5)# load color into $t5
	# getting pixel address
		lw $t0, food1_coord($t8) # load relative address of xth pixel of food1
		add $t0,$t0,$t1# now $t0 is absolute address of xth pixel
	# check for collision:
		lw $t2, 0($t0) # pixel color to check
	# checks if cuurent color is man colors:
		beq $t2,  0xFFE5CC, food1_col_detected
		beq $t2, 0x0000FF , food1_col_detected
		
		j food1_col_end
	food1_col_detected:
		li calorie, 1 # calorie done by food1	
		li $t2,0 # reset position food1
		sw $t2, food1_pos($t9)
		j food1_render_end # stop rendering 
	food1_col_end:
	# displaying pixel color
		sw $t5, 0($t0) # store colour on framebuffer
		addi $t8,$t8,-4#decrement counter
		bgez $t8, render_food1#check if counter x != 0, then loop
	food1_render_end:

	addi $t9,$t9,-4
	bgez $t9,render_next_food1
	
	jr $ra
# ----------------- #
