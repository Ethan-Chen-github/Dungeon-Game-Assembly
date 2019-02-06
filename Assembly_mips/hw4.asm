# qiquan chen
# qiqchen
# 111566448

#####################################################################
############### DO NOT CREATE A .data SECTION! ######################
############### DO NOT CREATE A .data SECTION! ######################
############### DO NOT CREATE A .data SECTION! ######################
##### ANY LINES BEGINNING .data WILL BE DELETED DURING GRADING! #####
#####################################################################

.text

# Part I
init_game:

## a0  file name address
## a1  map struc address
## a2 player struc address

move $s5, $sp

move $s0, $a0
move $s1, $a1 ## map
move $s2, $a2 #player

li $a0, 16
li $v0, 9
syscall
addi $v0, $v0, 16
move $s6, $v0

sw $s0, ($v0)
sw $s1, 4($v0)
sw $s2, 8($v0)

move $a0, $s0
li $a1, 0
li $a2,0

li $v0, 13
syscall

bltz $v0, error_p1

move $s7, $v0 ## file 

move $a0, $v0  ##
move $a1, $sp
li $a2, 5
li $v0, 14
syscall


move $s3, $s1 ##map
move $s4, $s2 ##player

lb $t0, ($sp)
addi $sp, $sp, 1
lb $t1, ($sp)
addi $sp, $sp, 2
lb $t2, ($sp)
addi $sp, $sp, 1
lb $t3, ($sp)
addi $sp, $sp, -4

################### ascii to int
addi $t0, $t0, -48
addi $t1, $t1, -48
addi $t2, $t2, -48
addi $t3, $t3, -48
######################
li $t4, 10
mul $t0, $t0, $t4  ## row t1
add $t1, $t0, $t1
mul $t4, $t2, $t4
add $t2, $t4, $t3 ## col t2
mul $t0, $t1, $t2 ## space t0
#################
move $s0, $t0
move $s1, $t1
move $s2, $t2
#####  player struc
sb $t1, ($s3)
addi $s3, $s3, 1
sb $t2, ($s3)
addi $s3, $s3, 1
#######
################
addi $t0, $t0, 8 #### add
add $t0, $t0, $t1
################
move $a0, $s7  
move $a1, $sp
move $a2, $t0
li $v0, 14
syscall
###################
addi $sp, $sp, 1   ## important
move $t1, $s0

loop_part1:
	beqz $t1, done_part1
	
	lb $t0, ($sp)
	addi $sp, $sp,1
	beq $t0, 10, loop_part1
	beq $t0, 64, player_p1
	#####
	ori $t0, $t0, 128
	####
	sb $t0, ($s3)
	addi $s3, $s3, 1
	addi $t1, $t1, -1
	
	j loop_part1
	
player_p1:
	move $t9, $t1
	#####
	ori $t0, $t0, 128
	####
	sb $t0, ($s3)
	addi $s3, $s3, 1
	addi $t1, $t1, -1
	j loop_part1


done_part1:
	addi $sp, $sp, 1
	lb $t0, ($sp) ## player health 1 bit
	addi $sp, $sp, 1
	lb $t1, ($sp) ## player health 2 bit
	addi $sp, $sp, 1
	li $t4, 0
	move $t7, $t9
	
	
player_row_p1_l:
	add $t7, $s2, $t7
	bge $t7, $s0, con_p1
	addi $t4, $t4, 1 ## t4 is row
	j player_row_p1_l

con_p1:
	sb $t4, ($s4) ## first bit of player struc
	addi $s4, $s4, 1 ## now 2nd
	sub $t7, $t7, $s2
	
player_col_p1:
	sub $t5, $s0, $t7  ## t5 is col
	sb $t5, ($s4) ## 2 bit
	addi $s4, $s4, 1 ## now 3bit

player_hp_p1:
	addi $t0, $t0, -48
	addi $t1, $t1, -48
	li $t5, 10
	mul $t0, $t0, $t5
	add $t0, $t0, $t1
	sb $t0, ($s4) ## 3 bit
	addi $s4, $s4, 1 ## now 4 bit

player_coin_p1:
	li $t8, 0
	sb $t8, ($s4)
	
	
	## close file
	move $a0, $s7
	li $v0, 16
	syscall
	####
	move $sp, $s5
	
	
	li $v0, 0
	jr $ra

error_p1:
	## close file
	move $a0, $s7
	li $v0, 16
	syscall
	####
	move $sp, $s5

	li $v0, -1
	jr $ra

# Part II
is_valid_cell:

	#######temp##########
	#lb $t0, 0($a2)
	#lb $t0, 1($a2)
	#lb $t0, 2($a2)
	#lb $t0, 3($a2)
	###################
	
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	
	## a0 address map
	## a1 row
	## a2 col
	
	### pointer assume a0 is pointer to map 
	lb $t0, 0($a0) #row
	lb $t1, 1($a0) ## col
	
	
	#### errors#######
	bltz $a1, error_p2
	bge $a1, $t0, error_p2
	bltz $a2, error_p2
	bge $a2, $t1, error_p2
	##################

	lw $ra, ($sp)
	addi $sp, $sp, 4
	li $v0, 0
	jr $ra
error_p2:
	lw $ra, ($sp)
	addi $sp, $sp, 4
	li $v0, -1
	jr $ra
	

# Part III
get_cell:
	## a0 map struc address
	## a1 row
	## a2 col
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	jal is_valid_cell
	beq $v0, -1, error_p3
	
	### pointer assume a0 is pointer to map 
	lb $t0, 0($a0) #row
	lb $t1, 1($a0) ## col
	########################################

	mul $t2, $a1, $t1, ## t2 is counter
	add $t2, $t2, $a2  
	###################
	addi $a0, $a0, 2 ## starting at second bit
loop_p3:
	beqz $t2, done_p3
	lbu $v0, ($a0)
	addi $a0, $a0, 1
	addi $t2, $t2, -1
	j loop_p3
done_p3:
	####################
	lw $ra, ($sp)
	addi $sp, $sp, 4
	lbu $v0, ($a0)
	jr $ra
	
error_p3:
	lw $ra, ($sp)
	addi $sp, $sp, 4
	li $v0, -1
	jr $ra
	
# Part IV
set_cell:
	## a0 set cell
	## a1 row
	## a2 col
	## a3 ch
	
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	jal is_valid_cell
	beq $v0, -1, error_p4
	
	jal get_cell
	lb $t0, ($a0) ## temp
	sb $a3, ($a0) ## set
	lb $t0, ($a0) ## temp
	
	
	
	lw $ra, ($sp)
	addi $sp, $sp, 4
	li $v0, 0
	jr $ra
error_p4:
	lw $ra, ($sp)
	addi $sp, $sp, 4
	li $v0, -1
	jr $ra

# Part V
reveal_area:
	## a0 map
	## a1 row
	## a2 int
	
	addi $sp, $sp, -4
	sw $ra, ($sp)
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	li $t0, 127
	
center_p5:
	############
	jal get_cell
	beq $v0, -1, center_up_p5
	beq $v0, 191, center_up_p5
	andi $v0, $v0, 127
	##########
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $v0
	jal set_cell
center_up_p5:
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
 	addi $a1, $a1, -1  ## upper row
	############
	jal get_cell
	beq $v0, -1, center_up_l_p5
	beq $v0, 191, center_up_l_p5
	andi $v0, $v0, 127
	##########
	move $a0, $s0
	move $a1, $s1
	addi $a1, $a1, -1  ## upper row
	move $a2, $s2
	move $a3, $v0
	jal set_cell
center_up_l_p5:
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
 	addi $a1, $a1, -1  ## upper row
 	addi $a2, $a2, -1
	############
	jal get_cell
	beq $v0, -1, center_up_r_p5
	beq $v0, 191, center_up_r_p5
	andi $v0, $v0, 127
	##########
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $v0
	addi $a1, $a1, -1  ## upper row
 	addi $a2, $a2, -1
	jal set_cell
center_up_r_p5:
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
 	addi $a1, $a1, -1  ## upper row
 	addi $a2, $a2, 1
	############
	jal get_cell
	beq $v0, -1, center_l_p5
	beq $v0, 191, center_l_p5
	andi $v0, $v0, 127
	##########
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $v0
	addi $a1, $a1, -1  ## upper row
 	addi $a2, $a2, 1
	jal set_cell
center_l_p5:
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
 	addi $a2, $a2, -1  
	############
	jal get_cell
	beq $v0, -1, center_r_p5
	beq $v0, 191, center_r_p5
	andi $v0, $v0, 127
	##########
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $v0
	addi $a2, $a2, -1  
	jal set_cell
center_r_p5:
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	addi $a2, $a2, 1
	############
	jal get_cell
	beq $v0, -1, center_d_p5
	beq $v0, 191, center_d_p5
	andi $v0, $v0, 127
	##########
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $v0
	addi $a2, $a2, 1
	jal set_cell
center_d_p5:
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	addi $a1, $a1, 1
	############
	jal get_cell
	beq $v0, -1, center_d_l_p5
	beq $v0, 191, center_d_l_p5
	andi $v0, $v0, 127
	##########
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $v0
	addi $a1, $a1, 1
	jal set_cell
center_d_l_p5:
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	addi $a1, $a1, 1
	addi $a2, $a2, -1
	############
	jal get_cell
	beq $v0, -1, center_d_r_p5
	beq $v0, 191, center_d_r_p5
	andi $v0, $v0, 127
	##########
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $v0
	addi $a1, $a1, 1
	addi $a2, $a2, -1
	jal set_cell

center_d_r_p5:
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	addi $a1, $a1, 1
	addi $a2, $a2, 1
	############
	jal get_cell
	beq $v0, -1, done_p5
	beq $v0, 191, done_p5
	andi $v0, $v0, 127
	##########
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $v0
	addi $a1, $a1, 1
	addi $a2, $a2, 1
	jal set_cell	
	
	
done_p5:
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
	

# Part VI
get_attack_target:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	### a0 map address
	### a1 player address
	### a2 ch U D L R

U_p6:
	bne $a2, 85, D_p6
	j cont_p6

D_p6:
	bne $a2, 68, L_p6
	j cont_p6
L_p6:
	bne $a2, 76, R_p6
	j cont_p6
R_p6:
	bne $a2, 82, error_p6
	j cont_p6
	
cont_p6:
	lb $t0, 0($a1) ##row player
	lb $t1, 1($a1) ##col player
	
	beq $a2, 85, U1_p6
	beq $a2, 68, D1_p6
	beq $a2, 76, L1_p6
	beq $a2, 82, R1_p6

U1_p6:
	## a0 map starting
	move $a1, $t0
	move $a2, $t1
	addi $a1, $a1, -1 ## row -1
	jal get_cell
	beq $v0, -1, error_p6 ## if invalid index
	
	andi $v0, $v0, 127 ## change back to ascii
	j select_p6
	
D1_p6:
	## a0 map starting
	move $a1, $t0
	move $a2, $t1
	addi $a1, $a1, 1 ## row -1
	jal get_cell
	beq $v0, -1, error_p6 ## if invalid index
	
	andi $v0, $v0, 127 ## change back to ascii
	j select_p6

L1_p6:
	## a0 map starting
	move $a1, $t0
	move $a2, $t1
	addi $a2, $a2, -1 ## row -1
	jal get_cell
	beq $v0, -1, error_p6 ## if invalid index
	
	andi $v0, $v0, 127 ## change back to ascii
	j select_p6
	
R1_p6:
	## a0 map starting
	move $a1, $t0
	move $a2, $t1
	addi $a2, $a2, 1 ## COL +1
	jal get_cell
	beq $v0, -1, error_p6 ## if invalid index
	
	andi $v0, $v0, 127 ## change back to ascii
	j select_p6

select_p6:
	beq $v0, 109, monster_p6
	beq $v0, 66, boss_p6
	beq $v0, 47, door_p6
	j error_p6
monster_p6:
	lw $ra, ($sp)
	addi $sp, $sp, 4
	li $v0, 109
	jr $ra

boss_p6:
	lw $ra, ($sp)
	addi $sp, $sp, 4
	li $v0, 66
	jr $ra
	
door_p6:
	lw $ra, ($sp)
	addi $sp, $sp, 4
	li $v0, 47
	jr $ra
	
	
error_p6:
	lw $ra, ($sp)
	addi $sp, $sp, 4
	li $v0, -1
	jr $ra


# Part VII
complete_attack:
	## a0 map starting
	## a1 player staring
	## a2 target row
	## a3 target col
	
	addi $sp, $sp, -20
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	##lb $t3, 2($a1) ## t3 health
	
	###### getcell ##
	## a1 map
	move $a1, $a2 ## row
	move $a2, $a3 ##col
	jal get_cell
	###################
	beq $v0, -1, error_p7 ## if invalid index
	
	andi $v0, $v0, 127 ## change back to ascii
	j select_p7
	
select_p7:
	beq $v0, 109, monster_p7
	beq $v0, 66, boss_p7
	beq $v0, 47, door_p7
	j error_p7
monster_p7:
	## health -1
	lw $a1, 8($sp)
	lb $t3, 2($a1)
	
	addi $t3, $t3, -1
	sb $t3, 2($a1)
	
	
	### set monster $
	lw $a0, 4($sp)
	lw $a1, 12($sp)
	lw $a2, 16($sp)
	li $a3, 36 ##$$
	jal set_cell
	##########
	lw $a1, 8($sp)
	lb $t3, 2($a1)
	blez $t3, die_p7
	
	lw $ra, ($sp)
	addi $sp, $sp, 20
	jr $ra

boss_p7:
	## health -2
	lw $a1, 8($sp)
	lb $t3, 2($a1)
	
	addi $t3, $t3, -2
	sb $t3, 2($a1)
	lb $t3, 2($a1) 
	
	
	
	### set monster $
	lw $a0, 4($sp)
	lw $a1, 12($sp)
	lw $a2, 16($sp)
	li $a3, 42 ##gem
	jal set_cell
	##########
	lw $a1, 8($sp)
	lb $t3, 2($a1)
	blez $t3, die_p7
	
	
	lw $ra, ($sp)
	addi $sp, $sp, 20
	jr $ra
	
door_p7:
	
	### set monster $
	lw $a0, 4($sp)
	lw $a1, 12($sp)
	lw $a2, 16($sp)
	li $a3, 46
	jal set_cell
	##########
	
	
	lw $ra, ($sp)
	addi $sp, $sp, 20
	jr $ra

	
die_p7:
	lw $a0, 4($sp)
	lw $t3, 8($sp)
	lb $a1, 0($t3)
	lb $a2, 1($t3)
	li $a3, 88
	jal set_cell
	
	lw $ra, ($sp)
	addi $sp, $sp, 20
	jr $ra
	
	

error_p7:
	lw $ra, ($sp)
	addi $sp, $sp, 20
	jr $ra


# Part VIII
monster_attacks:
	## a0 map
	## a1 player
	addi $sp, $sp, -16
	sw $ra, ($sp)
	sw $a0, 4($sp)
	
	li $t6, 0 ## hit point
	
	lb $t0, 0($a1)
	lb $t1, 1($a1)
	
	sw $t0, 8($sp) #row
	sw $t1, 12($sp)  #col
	### up
	
U_p8:
	lw $a0, 4($sp) #map
	lw $a1, 8($sp) #row
	lw $a2, 12($sp) #col
	addi $a1, $a1, -1
	jal get_cell
	beq $v0, -1, error_p7 ## if invalid index
	andi $v0, $v0, 127 ## change back to ascii
	jal select_p8

D_p8:
	lw $a0, 4($sp) #map
	lw $a1, 8($sp) #row
	lw $a2, 12($sp) #col
	addi $a1, $a1, 1
	jal get_cell
	beq $v0, -1, error_p7 ## if invalid index
	andi $v0, $v0, 127 ## change back to ascii
	jal select_p8

L_p8:
	lw $a0, 4($sp) #map
	lw $a1, 8($sp) #row
	lw $a2, 12($sp) #col
	addi $a2, $a2, -1
	jal get_cell
	beq $v0, -1, error_p7 ## if invalid index
	andi $v0, $v0, 127 ## change back to ascii
	jal select_p8

R_p8:
	lw $a0, 4($sp) #map
	lw $a1, 8($sp) #row
	lw $a2, 12($sp) #col
	addi $a2, $a2, 1
	jal get_cell
	beq $v0, -1, error_p7 ## if invalid index
	andi $v0, $v0, 127 ## change back to ascii
	jal select_p8
	j done_p8

select_p8:
	beq $v0, 109, monster_p8
	beq $v0, 66, boss_p8
	jr $ra

monster_p8:
	addi $t6, $t6, 1
	jr $ra

boss_p8:
	addi $t6, $t6, 2
	jr $ra
	
done_p8:
	move $v0, $t6
	lw $ra, ($sp)
	addi $sp, $sp, 16
	jr $ra	

error_p8:
	lw $ra, ($sp)
	addi $sp, $sp, 16
	jr $ra


# Part IX
player_move:
	# a0 map
	# a1 player
	# a2 target row
	# a3 target col
	addi $sp, $sp, -20
	sw $ra, ($sp)
	sw $a0, 4($sp) #map
	sw $a1, 8($sp) ##player
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	## before moving player
	jal monster_attacks
	lw $a1, 8($sp)
	lb $t0, 2($a1)
	sub $t0, $t0, $v0
	sb $t0, 2($a1)
	## die ?
	lb $t0, 2($a1)
	blez $t0, die_p9
	## select
	lw $a0, 4($sp)
	lw $a1, 12($sp)
	lw $a2, 16($sp)
	jal get_cell
	beq $v0, -1, error_p9 ## if invalid index
	andi $v0, $v0, 127 ## change back to ascii
	jal select_p9
	j done_p9
	
select_p9:
	beq $v0, 46, floor_p9
	beq $v0, 36, coin_p9
	beq $v0, 42, gem_p9
	beq $v0, 62, exit_p9
	jr $ra
	
floor_p9:
	## set player to .
	lw $t0, 8($sp)
	
	lw $a0, 4($sp)
	lb $a1, 0($t0)
	lb $a2, 1($t0)
	li $a3, 46
	jal set_cell
	
	## set target to @
	
	
	lw $a0, 4($sp)
	lw $a1, 12($sp)
	lw $a2, 16($sp)
	li $a3, 64
	jal set_cell
	
	## done
	lw $ra, ($sp)
	addi $sp, $sp, 20
	li $v0, 0
	jr $ra
	
coin_p9:
	## set player to .
	lw $t0, 8($sp)
	
	lw $a0, 4($sp)
	lb $a1, 0($t0)
	lb $a2, 1($t0)
	li $a3, 46
	jal set_cell
	
	## set target to @
	
	
	lw $a0, 4($sp)
	lw $a1, 12($sp)
	lw $a2, 16($sp)
	li $a3, 64
	jal set_cell
	
	## coin +1
	lw $a1, 8($sp)
	
	lb $t0, 3($a1)
	addi $t0, $t0, 1
	sb $t0, 3($a1)
	lb $t0, 3($a1)
	
	## done
	lw $ra, ($sp)
	addi $sp, $sp, 20
	li $v0, 0
	jr $ra

gem_p9:
	## set player to .
	lw $t0, 8($sp)
	
	lw $a0, 4($sp)
	lb $a1, 0($t0)
	lb $a2, 1($t0)
	li $a3, 46
	jal set_cell
	
	## set target to @
	
	
	lw $a0, 4($sp)
	lw $a1, 12($sp)
	lw $a2, 16($sp)
	li $a3, 64
	jal set_cell
	
	## coin +1
	lw $a1, 8($sp)
	
	lb $t0, 3($a1)
	addi $t0, $t0, 5
	sb $t0, 3($a1)
	lb $t0, 3($a1)
	
	## done
	lw $ra, ($sp)
	addi $sp, $sp, 20
	li $v0, 0
	jr $ra
	
exit_p9:
	## set player to .
	lw $t0, 8($sp)
	
	lw $a0, 4($sp)
	lb $a1, 0($t0)
	lb $a2, 1($t0)
	li $a3, 46
	jal set_cell
	
	## set target to @
	
	
	lw $a0, 4($sp)
	lw $a1, 12($sp)
	lw $a2, 16($sp)
	li $a3, 64
	jal set_cell
	
	## done
	lw $ra, ($sp)
	addi $sp, $sp, 20
	li $v0, -1
	jr $ra
	
die_p9:
	lw $t0, 8($sp)
	
	lw $a0, 4($sp)
	lb $a1, 0($t0)
	lb $a2, 1($t0)
	li $a3, 88
	jal set_cell
	lw $ra, ($sp)
	addi $sp, $sp, 20
	li $v0, 0 #####func return
	jr $ra

	
	
done_p9:	
	lw $ra, ($sp)
	addi $sp, $sp, 20
	li $v0, 0
	jr $ra

error_p9:
	lw $ra, ($sp)
	addi $sp, $sp, 20
	li $v0, 0
	jr $ra


# Part X
player_turn:
	
	## a0 map
	## a1 player
	## a2 char u d l r
	addi $sp, $sp, -24
	sw $ra, ($sp)
	sw $a0, 4($sp)  #map
	sw $a1, 8($sp)  #player
	sw $a2, 20($sp) ## char
	### 12 target row
	### 16 target col
	
	
U_p10:
	bne $a2, 85, D_p10
	## target dirc
	lb $t0, 0($a1) #row
	lb $t1, 1($a1)
	addi $t0, $t0, -1 ## row -1
	sw $t0, 12($sp) ## tar row
	sw $t1, 16($sp) ## tar col
	###################
	j cont_p10

D_p10:
	bne $a2, 68, L_p10
	## target dirc
	lb $t0, 0($a1) #row
	lb $t1, 1($a1)
	addi $t0, $t0, 1 ## row +1
	sw $t0, 12($sp) ## row
	sw $t1, 16($sp) ## col
	###################
	j cont_p10
L_p10:
	bne $a2, 76, R_p10
	## target dirc
	lb $t0, 0($a1) #row
	lb $t1, 1($a1)
	addi $t1, $t1, -1 ## row +1
	sw $t0, 12($sp) ## row
	sw $t1, 16($sp) ## col
	###################
	j cont_p10
	
	
	j cont_p10
R_p10:
	bne $a2, 82, error_p10
	## target dirc
	lb $t0, 0($a1) #row
	lb $t1, 1($a1)
	addi $t1, $t1, 1 ## row +1
	sw $t0, 12($sp) ## row
	sw $t1, 16($sp) ## col
	###################
	j cont_p10
	
	
cont_p10:

	## call get cell
	## a0 map
	## a1 row
	## a2 col
	
	lw $a0, 4($sp)
	move $a1, $t0
	move $a2, $t1
	jal get_cell
	
	beq $v0, -1, error_z_p10 ## if invalid index
	andi $v0, $v0, 127 ## change back to ascii
	
	beq $v0, 35, wall_p10
	
	
	### get attack target
	## a0, map
	## a1 player
	## a2 char U 
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 20($sp)
	jal get_attack_target
	
	beq $v0, -1, moveplayer_p10
	## complete attack
	# a0 map
	# a1 player
	# a2 tar row
	# a3 tar col
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	
	jal complete_attack
	
	lw $ra, ($sp)
	addi $sp, $sp, 24
	li $v0, 0 ## temp
	jr $ra
	
	
	
moveplayer_p10:
	### player move
	# a0 map
	# a1 player
	# a2 tar row
	# a3 tar col
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	jal player_move
	lw $ra, ($sp)
	addi $sp, $sp, 24
	jr $ra
		
				
wall_p10:
	lw $ra, ($sp)
	addi $sp, $sp, 24
	li $v0, 0 ## temp
	jr $ra
	
	
done_p10:
	lw $ra, ($sp)
	addi $sp, $sp, 24
	li $v0, 0 ## temp
	jr $ra

error_p10:
	lw $ra, ($sp)
	addi $sp, $sp, 24
	li $v0, -1
	jr $ra
error_z_p10:
	lw $ra, ($sp)
	addi $sp, $sp, 20
	li $v0, 0
	jr $ra


# Part XI
flood_fill_reveal:
	## a0 map
	## a1 row
	## a2 col
	## a3 bit[][]
	
	
	### check error#####
	lb $t0, ($a0) #row
	lb $t1, 1($a0) ## col
	
	bltz $a1, error_p11
	bge $a1, $t0, error_p11
	bltz $a2, error_p11
	bge $a2, $t1, error_p11
	#####################
	addi $sp, $sp, -28
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $t0, 20($sp)
	sw $t1, 24($sp)
	
	
	
####
	### make bit array all visited
	### 111111111 which is add 255
	### then check code

###
	
############################# mark current as visited
	## visit is 7 row  * 25 col 
	##lw $t0, 20($sp) #row
	##lw $t1, 24($sp) #col
	
	##lw $a1, 4($sp) #i
	##lw $a2, 8($sp) #j
	
	##mul $t2, $a1, $
	
	
	## t2 counter
	
	
	
	##mflo $t3 ##quotient
	##mfhi $t4 # remainder
	
	
	
############################# pseu code start
	move $fp, $sp ## pointer
	
	###### sp push row
	addi $sp, $sp, -4 
	sw $a1, ($sp)
	##### sp push col
	addi $sp, $sp, -4
	sw $a2, ($sp)
	
	#### offset -1 0 , 1 0 , 0 -1 , 0 1  # a1 row, #a2 col
while_p11:
	## sp != fp
	beq $sp, $fp, done_p11
	### col = sp.pop
	lw $a2, ($sp)
	move $s4, $a2 
	addi $sp, $sp, 4 ## sp pop
	### row = sp.pop
	lw $a1, ($sp)
	move $s3, $a1
	addi $sp, $sp, 4 ## sp pop
	
	##  current cell as msb to 1##############
	lw $a0, 4($fp)
	## a1 row
	## a2 col
	######################
	jal get_cell
	beq $v0, -1, error_p11
	andi $v0, $v0, 127
	##bne $v0, 46, while_1_p11 ## no need
	lw $a0, 4($fp)
	##lw $a1, 8($fp) different everytime
	##lw $a2, 12($fp)
	move $a3, $v0
	jal set_cell	
	################ #####################
	#  NO NEED  visited to 1
	#lw $t0, 20($fp) #row
	#lw $t1, 24($fp) #col
	
	#a1 #a2
	#mul $t2, $a1, $t1
	#add $t2, $t2, $a2
	#li $t8, 8
	#li $t9, 128
	
	#div $t2, $t8
	
	#mflo $t3
	#mfhi $t4
	
	#lw $t5, 16($fp) # array
	
	#add $s0, $t5, $t3 ## go to m byte
	
	#lb $t5, ($s0) ## the t5 byte
	
	#addi $t7, $t4, -1
	
	#srlv $t6, $t9, $t7 ## shift
	
	#or $t5, $t5, $t6
	
	#sb $t5, ($s0)
	
	
	############################################
####################################################
while_1_p11:

center_up_p11:
	lw $a0, 4($fp)
	move $a1, $s3
	move $a2, $s4
 	addi $a1, $a1, -1  ## upper row
	############ condition 1 it is a floor
	jal get_cell
	beq $v0, -1,center_d_p11
	andi $v0, $v0, 127
	bne $v0, 46,center_d_p11 ## only reveal floor which is 46 ask ta
	########## condition 2 byte is 0 which mean it is not visited\
	lw $t0, 20($fp) #row
	lw $t1, 24($fp) #col
	
	#a1 #a2
	mul $t2, $a1, $t1
	add $t2, $t2, $a2
	li $t8, 8
	li $t9, 128
	
	div $t2, $t8
	
	mflo $t3
	mfhi $t4
	
	lw $t5, 16($fp) # array
	
	add $s0, $t5, $t3 ## go to m byte
	
	lb $t5, ($s0) ## the t5 byte
	
	##addi $t7, $t4, -1
	
	srlv $t6, $t9, $t4 ## shift
	
	and $s1, $t5, $t6
	
	bnez $s1, center_d_p11
	############### then set to be visted
	or $t5, $t5, $t6
	
	sb $t5, ($s0)
	
	##push stack
	addi $sp, $sp, -4
	sw $a1, ($sp)
	addi $sp, $sp, -4
	sw $a2, ($sp)

center_d_p11:
	lw $a0, 4($fp)
	move $a1, $s3
	move $a2, $s4
 	addi $a1, $a1, 1  ## upper row
	############ condition 1 it is a floor
	jal get_cell
	beq $v0, -1,center_l_p11
	andi $v0, $v0, 127
	bne $v0, 46,center_l_p11 ## only reveal floor which is 46 ask ta
	########## condition 2 byte is 0 which mean it is not visited\
	lw $t0, 20($fp) #row
	lw $t1, 24($fp) #col
	
	#a1 #a2
	mul $t2, $a1, $t1
	add $t2, $t2, $a2
	li $t8, 8
	li $t9, 128
	
	div $t2, $t8
	
	mflo $t3
	mfhi $t4
	
	lw $t5, 16($fp) # array
	
	add $s0, $t5, $t3 ## go to m byte
	
	lb $t5, ($s0) ## the t5 byte
	
	##addi $t7, $t4, -1
	
	srlv $t6, $t9, $t4 ## shift
	
	and $s1, $t5, $t6
	
	bnez $s1, center_l_p11
	############### then set to be visted
	or $t5, $t5, $t6
	
	sb $t5, ($s0)
	
	##push stack
	addi $sp, $sp, -4
	sw $a1, ($sp)
	addi $sp, $sp, -4
	sw $a2, ($sp)
	
	
center_l_p11:
	lw $a0, 4($fp)
	move $a1, $s3
	move $a2, $s4
 	addi $a2, $a2, -1  ## upper row
	############ condition 1 it is a floor
	jal get_cell
	beq $v0, -1,center_r_p11
	andi $v0, $v0, 127
	bne $v0, 46,center_r_p11 ## only reveal floor which is 46 ask ta
	########## condition 2 byte is 0 which mean it is not visited\
	lw $t0, 20($fp) #row
	lw $t1, 24($fp) #col
	
	#a1 #a2
	mul $t2, $a1, $t1
	add $t2, $t2, $a2
	li $t8, 8
	li $t9, 128
	
	div $t2, $t8
	
	mflo $t3
	mfhi $t4
	
	lw $t5, 16($fp) # array
	
	add $s0, $t5, $t3 ## go to m byte
	
	lb $t5, ($s0) ## the t5 byte
	
	##addi $t7, $t4, -1
	
	srlv $t6, $t9, $t4 ## shift
	
	and $s1, $t5, $t6
	
	bnez $s1, center_r_p11
	############### then set to be visted
	or $t5, $t5, $t6
	
	sb $t5, ($s0)
	
	##push stack
	addi $sp, $sp, -4
	sw $a1, ($sp)
	addi $sp, $sp, -4
	sw $a2, ($sp)
	
center_r_p11:
		lw $a0, 4($fp)
	move $a1, $s3
	move $a2, $s4
 	addi $a2, $a2, 1  ## upper row
	############ condition 1 it is a floor
	jal get_cell
	beq $v0, -1, while_p11
	andi $v0, $v0, 127
	bne $v0, 46, while_p11 ## only reveal floor which is 46 ask ta
	########## condition 2 byte is 0 which mean it is not visited\
	lw $t0, 20($fp) #row
	lw $t1, 24($fp) #col
	
	#a1 #a2
	mul $t2, $a1, $t1
	add $t2, $t2, $a2
	li $t8, 8
	li $t9, 128
	
	div $t2, $t8
	
	mflo $t3
	mfhi $t4
	
	lw $t5, 16($fp) # array
	
	add $s0, $t5, $t3 ## go to m byte
	
	lb $t5, ($s0) ## the t5 byte
	
	##addi $t7, $t4, -1
	
	srlv $t6, $t9, $t4 ## shift
	
	and $s1, $t5, $t6
	
	bnez $s1, while_p11
	############### then set to be visted
	or $t5, $t5, $t6
	
	sb $t5, ($s0)
	
	##push stack
	addi $sp, $sp, -4
	sw $a1, ($sp)
	addi $sp, $sp, -4
	sw $a2, ($sp)
	

	j while_p11


#######################################################################################
done_p11:
	lw $ra, ($sp)
	addi $sp, $sp, 28
	li $v0, 0
	jr $ra
	
error_p11:
	lw $ra, ($sp)
	addi $sp, $sp, 28
	li $v0, -1
	jr $ra

#####################################################################
############### DO NOT CREATE A .data SECTION! ######################
############### DO NOT CREATE A .data SECTION! ######################
############### DO NOT CREATE A .data SECTION! ######################
##### ANY LINES BEGINNING .data WILL BE DELETED DURING GRADING! #####
#####################################################################
