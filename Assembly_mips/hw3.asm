# Qiquan Chen
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
get_adfgvx_coords:

	## expcetion case
	bltz $a0, exception_part1
	bltz $a1, exception_part1
	bgt $a0, 5,exception_part1
	bgt $a1, 5,exception_part1
	##############################
	
	
	### save register
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	################
	
	
	#a0, 
	beq $a0, 0, A_1
	beq $a0, 1, D_1
	beq $a0, 2, F_1
	beq $a0, 3, G_1
	beq $a0, 4, V_1
	beq $a0, 5, X_1
	
A_1:
	li $t0, 65
	move $v0, $t0
	j part1
D_1:
	li $t0, 68
	move $v0, $t0
	j part1

F_1:
	li $t0, 70
	move $v0, $t0
	j part1

G_1:
	li $t0, 71
	move $v0, $t0
	j part1

V_1:
	li $t0, 86
	move $v0, $t0
	j part1

X_1:
	li $t0, 88
	move $v0, $t0
	j part1
	
part1:
		#a0, 
	beq $a1, 0, A_2
	beq $a1, 1, D_2
	beq $a1, 2, F_2
	beq $a1, 3, G_2
	beq $a1, 4, V_2
	beq $a1, 5, X_2 
	
A_2:
	li $t0, 65
	move $v1, $t0
	addi $sp, $sp, 12
	jr $ra
D_2:
	li $t0, 68
	move $v1, $t0
	addi $sp, $sp, 12
	jr $ra

F_2:
	li $t0, 70
	move $v1, $t0
	addi $sp, $sp, 12
	jr $ra

G_2:
	li $t0, 71
	move $v1, $t0
	addi $sp, $sp, 12
	jr $ra

V_2:
	li $t0, 86
	move $v1, $t0
	addi $sp, $sp, 12
	jr $ra

X_2:
	li $t0, 88
	move $v1, $t0
	addi $sp, $sp, 12
	jr $ra


exception_part1:
	
	
	##li $a0, -1
	##li $v0, 1
	##syscall
	
	
	##li $a0, ' '
	##li $v0, 11
	##syscall
	
	##li $a0, -1
	##li $v0, 1
	##syscall
	
	li $v0, -1
	li $v1, -1
	
	
	###########
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	#############

# Part II
search_adfgvx_grid:
	
	## save r
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	###########
	
	li $t0, 0
	
loop_part2:
	lb $t1,($a0)
	beq $t1, $zero, error_part2
	beq $t1, $a1, done_part2
	
	addi $a0, $a0, 1
	addi $t0, $t0, 1
	j loop_part2
	
done_part2:
	li $t3 , 6
	div $t0, $t3
	mflo $v0
	mfhi $v1
	
	###########
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	#############
	
error_part2:
	
	li $t2, -1
	move $v0, $t2
	move $v1, $t2
	
	#############
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	############

	
# Part III
map_plaintext:

	### reg v ##########
	addi $sp, $sp, -16
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $a2,12($sp)
	#################	
	
	move $s6, $a0
	move $s7, $a1
	
loop1_part3:
	lb $s0, ($s7)
	beq $s0, $zero, done_part3
	
	
	## search arg1 arg2
	move $a0, $s6   ### a0 array
	move $a1, $s0    ### char
	jal search_adfgvx_grid
	
	move $a0, $v0
	move $a1, $v1
	jal get_adfgvx_coords
	
	move $t0, $v0
	move $t1, $v1
	
	
	sb $t0, ($a2)
	addi $a2, $a2, 1
	sb $t1, ($a2)
	addi $a2, $a2, 1
	
	addi $s7, $s7,1
	j loop1_part3

done_part3:
	#############
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	#################	
	addi $sp, $sp, 16
	jr $ra
	
	
		
	

	

# Part IV
swap_matrix_columns:

	## save reg
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $t0, 20($sp)
	###############
	## s0
	move $s5, $sp
	move $s4, $t0
	move $s0, $a0
	move $s3, $a3
	move $s2, $a2
	move $s1, $a1
	li $t0, 0
	
loop_find_col_part4:
	lb $t1, ($a0)
	beq $t0, $s4, loop2_part4_i
	
	addi $a0, $a0, 1
	addi $t0, $t0, 1
	
	j loop_find_col_part4
	
	
loop2_part4_i:
	li $t0,0
	move $t4, $a1

loop2_part4:
	div $t0, $a2
	mfhi $t3
	
	
	beqz $t4, loop4_part4_i
	bnez $t3, loop3_part4
	lb $t1, ($a0)
	### save into stack
	addi $sp, $sp, -4
	sw $t1, ($sp)
	###############
	
	
	addi $t0, $t0, 1
	addi $a0, $a0, 1
	addi $t4, $t4, -1
	
	j loop2_part4
	
	
loop3_part4:
	addi $t0, $t0, 1
	addi $a0, $a0, 1
	j loop2_part4

############################################# first col into sp
loop4_part4_i:
	li $t0, 0
		
	move $a0, $s0

loop4_part4:
	lb $t1, ($a0)
	beq $t0, $a3, loop5_part4_i
	
	addi $a0, $a0, 1
	addi $t0, $t0, 1
	
	j loop4_part4
	
loop5_part4_i:
	li $t0,0
	move $t4, $a1
loop5_part4:
	div $t0, $a2
	mfhi $t3
	
	
	beqz $t4, loop7_part4_i
	bnez $t3, loop6_part4
	lb $t1, ($a0)
	### save into stack
	addi $sp, $sp, -4
	sw $t1, ($sp)
	###############
	addi $a0, $a0, 1 
	addi $t0, $t0, 1
	addi $t4, $t4, -1
	
	j loop5_part4
	
loop6_part4:
	addi $t0, $t0, 1
	addi $a0, $a0, 1
	j loop5_part4
####################################
loop7_part4_i:
	move $a0, $s0
	li $t0, 0
	
	addi $t5, $a1, -1
	move $t6, $s4
	
	mul $t0, $t5, $s2
	add $t0, $t0, $s4## t0 have the count
	

loop7_part4:
	beqz $t0, loop8_part4_i
	addi $a0, $a0, 1
	addi $t0, $t0, -1
	j loop7_part4
	
loop8_part4_i:
	
	li $t0, 0
	move $t4, $a1
	move $a2, $s2
	
loop8_part4:
	div $t0,$a2
	mfhi $t3

	beqz $t4, loop10_part4_i
	bnez $t3, loop9_part4
	###temp 
	lb $t1, ($a0)
	#####
	lb $t1, ($sp)
	sb $t1, ($a0)
	addi $sp, $sp, 4
	addi $a0, $a0, -1
	
	addi $t4, $t4, -1
	addi $t0, $t0, 1

	
	j loop8_part4
	
loop9_part4:

	addi $t0, $t0, 1
	addi $a0, $a0, -1
	j loop8_part4
##################################################
##################################################
loop10_part4_i:
	move $a0, $s0
	li $t0, 0
	move $a1, $s1
	
	addi $t5, $a1, -1
	move $t6, $s3
	
	mul $t0, $t5, $s2
	add $t0, $t0, $s3

##########
loop10_part4:
	beqz $t0, loop12part4_i
	addi $a0, $a0, 1
	addi $t0, $t0, -1
	j loop10_part4
	
loop12part4_i:
	
	li $t0, 0
	move $t4, $a1
	move $a2, $s2
	
loop12_part4:

	div $t0,$a2
	mfhi $t3

	beqz $t4, loop14_part4_i
	bnez $t3, loop13_part4
	###temp 
	lb $t1, ($a0)
	#####
	lb $t1, ($sp)
	sb $t1, ($a0)
	addi $sp, $sp, 4
	addi $a0, $a0, -1
	
	addi $t4, $t4, -1
	addi $t0, $t0, 1

	
	j loop13_part4
	
loop13_part4:

	addi $t0, $t0, 1
	addi $a0, $a0, -1
	j loop12_part4
	
loop14_part4_i:
	move $sp, $s5
	lw $ra, 0($sp)
	jr $ra
	
	
	
	
	

	
# Part V
key_sort_matrix:

	beq $t0, 4, part5_w
#####################################################################################
	## save regis
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $t0, 20($sp)
	###################
	## s0
	move $s6, $sp
	move $s4, $t0
	move $s0, $a0
	move $s3, $a3
	move $s2, $a2
	move $s1, $a1
	li $t0, 0

	
	li $t8, 0 ## key length
	## count key length
loop_length_part5:
	lb $t0, ($a3)
	beq $t0, $zero, i_part5
	
	addi $a3, $a3, 1
	addi $t8, $t8, 1
	j loop_length_part5
i_part5:	
	move $sp, $s6
	lw $a3, 16($sp)
	li $t0, 0
	j for1_part5
	
for1_part5:

	beq $t0, $t8, done_part5
	li $t1, 0 ## reset j = 0
	lw $a3, 16($s6)
	j for2_part5


for2_part5:
	
	##############
	addi $t2, $t0, 1
	li $t3, -1
	mul $t3, $t2, $t3 
	add $t3, $t8, $t3 
	#############
	beq $t1,$t3,for2_part5_1
	lb $t3, ($a3) ## j
	addi $a3, $a3, 1
	lb $t4, ($a3) ## j +1
	ble $t3, $t4, for_2_up_part5
	### call swap matrix
	
	sb $t3, ($a3)
	
	addi $a3, $a3, -1
	
	sb $t4, ($a3)
	
	addi $a3,$a3, 1
	
	
	
	addi $sp, $sp, -20
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t3, 8($sp)
	sw $t4, 12($sp)
	sw $a3, 16($sp)
	move $s7, $sp  ## s6 new cursor
	
	move $sp, $s6  ## old cursor
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	
	move $a3, $t1  ##J
	addi $t0, $a3, 1  ### j + 1
	move $sp, $s7
		
	jal swap_matrix_columns
	
	
	move $sp, $s7 ## new cursor
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t3, 8($sp)
	lw $t4, 12($sp)
	lw $a3, 16($sp)
	
	addi $sp, $sp, 20
	addi $t1, $t1, 1
	j for2_part5
	
	
	############
for_2_up_part5:
	addi $t1, $t1, 1
	j for2_part5
	
for2_part5_1:
	addi $t0, $t0, 1
	j for1_part5
	
done_part5:
	move $sp, $s6
	lw $ra, 0($sp)
	jr $ra
	
######################################################################################################################################
part5_w:
	## save regis
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $t0, 20($sp)
	###################
	## s0
	move $s6, $sp
	move $s4, $t0
	move $s0, $a0
	move $s3, $a3
	move $s2, $a2
	move $s1, $a1
	li $t0, 0

	
	li $t8, 0 ## key length
	## count key length
loop_length_part5_w:
	lw $t0, ($a3)
	beq $t0, $zero, i_part5_w
	
	addi $a3, $a3, 4
	addi $t8, $t8, 1
	j loop_length_part5_w
i_part5_w:	
	move $sp, $s6
	lw $a3, 16($sp)
	li $t0, 0
	j for1_part5_w
	
for1_part5_w:

	beq $t0, $t8, done_part5_w
	li $t1, 0 ## reset j = 0
	lw $a3, 16($s6)
	j for2_part5_w


for2_part5_w:
	
	##############
	addi $t2, $t0, 1
	li $t3, -1
	mul $t3, $t2, $t3 
	add $t3, $t8, $t3 
	#############
	beq $t1,$t3,for2_part5_1_w
	lw $t3, ($a3) ## j
	addi $a3, $a3, 4
	lw $t4, ($a3) ## j +1
	ble $t3, $t4, for_2_up_part5_w
	### call swap matrix
	
	sw $t3, ($a3)
	
	addi $a3, $a3, -4
	
	sw $t4, ($a3)
	
	addi $a3,$a3, 4
	
	
	
	addi $sp, $sp, -20
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t3, 8($sp)
	sw $t4, 12($sp)
	sw $a3, 16($sp)
	move $s7, $sp  ## s6 new cursor
	
	move $sp, $s6  ## old cursor
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	
	move $a3, $t1  ##J
	addi $t0, $a3, 1  ### j + 1
	move $sp, $s7
		
	jal swap_matrix_columns
	
	
	move $sp, $s7 ## new cursor
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t3, 8($sp)
	lw $t4, 12($sp)
	lw $a3, 16($sp)
	
	addi $sp, $sp, 20
	addi $t1, $t1, 1
	j for2_part5_w
	
	
######################
for_2_up_part5_w:
	addi $t1, $t1, 1
	j for2_part5_w
	
for2_part5_1_w:
	addi $t0, $t0, 1
	j for1_part5_w
	
done_part5_w:
	move $sp, $s6
	lw $ra, 0($sp)
	jr $ra
	

# Part IV
transpose:
	ble $a2, 0, error_p6
	ble $a3, 0, error_p6
	
	####### save regis
	move $s3, $v0
	addi $sp, $sp, -20
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $ra, 16($sp)
	###################
	move $t2, $a2 ### # row
	move $t3, $a3 ## ## col
	move $t1, $a0 ## initial pos
	move $t5, $a3 ## a3
	
loop_part6:
	beqz $t5, done_part6
	lw $a2, 8($sp)
	li $t3, 0
	j loop1_part6
	
loop_part6_1:
	addi $t1, $t1, 1
	move $a0, $t1
	## temp
	lb $t6, ($a0)
	##
	addi  $t5, $t5, -1 ## i--
	j loop_part6
	
loop1_part6:
	div $t3,$a3
	mfhi $t4
	
	beqz $a2, loop_part6_1 ### update for first run
	bnez $t4, loop1_part6_1
	lb $t0, ($a0)
	
	## temp
	lb $t6, ($a1)
	##
	sb $t0, ($a1)
	
	addi $a0, $a0, 1
	addi $t3, $t3, 1
	addi $a1, $a1, 1 ### store into the next
	addi $a2, $a2, -1 ## j--
	j loop1_part6
	
loop1_part6_1:
	addi $a0, $a0, 1
	addi $t3, $t3, 1
	j loop1_part6	
	
done_part6:
	
	lw $ra, 16($sp)
	li $v0, 0
	jr $ra
	
error_p6:
	li $v0, -1

# Part VII
encrypt:
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	
	li $a0, 16
	li $v0, 9
	syscall

	addi $v0, $v0, 24
	sw $s0, 0($v0)
	sw $s1, 4($v0)
	sw $s2, 8($v0)
	sw $s3, 12($v0)
	sw $ra, 16($v0)
	sw $v0, 20($v0)
	move $s4, $v0
	li $t1, 42
	
#########################	 fill with star
loop_length_part7_i:
	lb $t0, ($a3)
	beq $t0, $zero, i_part7
	sb $t1, ($a3)
	
	addi $a3, $a3, 1
	addi $t9, $t9, 1
	j loop_length_part7_i
###############################

i_part7:
	############################## 
	## map plaintext
	lw $a0, 0($s4)
	lw $a1, 4($s4)
	lw $a2, 12($s4)
	jal map_plaintext
	#############################
	
	################################
	## key sort
	lw $a0, 0($s4)
	lw $a1, 4($s4)
	lw $a2, 8($s4)
	lw $a3, 12($s4)
	move $v0 $s4
	
	################### length counter
	li $t8, 0 
loop_length_part7:
	lb $t0, ($a2)
	beq $t0, $zero, loop_length_part7_1i
	
	addi $a2, $a2, 1
	addi $t8, $t8, 1
	j loop_length_part7
	###############################
	

	
	################### matrix length counter
	
loop_length_part7_1i:
	li $t9, 0 
	
loop_length_part7_1:
	lb $t0, ($a3)
	beq $t0, 42, cont_part7
	
	addi $a3, $a3, 1
	addi $t9, $t9, 1
	j loop_length_part7_1
	###############################
cont_part7:
	div $t9, $t8
	mfhi $t0
	mflo $t7
	beqz $t0, cont1_part7_i
	addi $t7,$t7, 1

#### null terminate a string
cont1_part7_i:
	lw $a3, 12($s4)
	mul $t6, $t7, $t8
	li $t0, 0
cont1_part7:
	beq $t6, $t0, cont1_part7_d
	addi $a3, $a3, 1
	addi $t0, $t0, 1
	j cont1_part7
cont1_part7_d:
	li $t0, 0
	sb $t0, ($a3)

 cont2_part7:
 ########### keysort
 	lw $a0, 12($s4) ##matrix
 	move $a1, $t7 ## row
 	move $a2, $t8 #col
 	lw $a3, 8($s4) ##key
 	li $t0, 1 ##size

	jal key_sort_matrix 
####################################
### tranpose

	move $s4, $v0
	lw $a0, 12($s4)
	lw $a1, ($s4)
######################	
loop_part7_sw:
	lb $t0, ($a0)
	beq $t0, $zero, contt_part7
	sb $t0, ($a1)
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	j loop_part7_sw

########################
	
contt_part7:
	move $s4, $v0
	lw $a0, ($s4)
	lw $a1, 12($s4)
	move $a2, $t7
	move $a3, $t8
	
	
	
	
	#################
	jal transpose
	
	lw $ra, 16($s4)

	jr $ra
##############################
# Part VIII
lookup_char:
	
	######reg save
	addi $sp,$sp, -16
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	################
	
	### check error###### a0
A_p8:
	bne $a1, 65, D_p8
	li $t1, 0
	j cont_part8
D_p8:
	bne $a1, 68, F_p8
	li $t1, 1
	j cont_part8
F_p8:
	bne $a1, 70, G_p8
	li $t1, 2
	j cont_part8
G_p8:
	bne $a1, 71, V_p8
	li $t1, 3
	j cont_part8
V_p8:
	bne $a1, 86, X_p8
	li $t1, 4
	j cont_part8
X_p8:
	bne $a1, 88, error_part8
	li $t1, 5
	j cont_part8
	####################
	
cont_part8:
	
	### check error###### a1
A_p8_1:
	bne $a2, 65, D_p8_1
	li $t0, 0
	j cont1_part8
D_p8_1:
	bne $a2, 68, F_p8_1
	li $t0, 1
	j cont1_part8
F_p8_1:
	bne $a2, 70, G_p8_1
	li $t0, 2
	j cont1_part8
G_p8_1:
	bne $a2, 71, V_p8_1
	li $t0, 3
	j cont1_part8
V_p8_1:
	bne $a2, 86, X_p8_1
	li $t0, 4
	j cont1_part8
X_p8_1:
	bne $a2, 88, error_part8
	li $t0, 5
	j cont1_part8
	####################
	
cont1_part8:
	li $v0, 0
	li $t4, 6
	mul $t3, $t1, $t4
	add $t3, $t3, $t0

loop_part8:
	lb $t2, ($a0)
	beqz $t3, done_part8
	
	addi $t3, $t3, -1
	addi $a0, $a0, 1
	j loop_part8
done_part8:
	move $v1, $t2
	
	lw $ra,($sp)
	jr $ra

error_part8:
	li $v0, -1
	li $v1, -1
	
	lw $ra,($sp)
	jr $ra

# Part IX
string_sort:
	### regis
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $ra, 4($sp)
	########
	li $t8, 0 ## key length
	## count key length
loop_length_part9:
	lb $t0, ($a0)
	beq $t0, $zero, i_part9
	
	addi $a0, $a0, 1
	addi $t8, $t8, 1
	j loop_length_part9
	
i_part9:
	lw $a0, 0($sp)
	li $t0, 0
	j for1_part9
	
for1_part9:
	beq $t0, $t8, done_part9
	li $t1, 0 
	lw $a0, 0($sp)
	j for2_part9

for2_part9:
	##############
	addi $t2, $t0, 1
	li $t3, -1
	mul $t3, $t2, $t3 
	add $t3, $t8, $t3 
	#############
	beq $t1,$t3,for2_part9_1
	
	
	lb $s0, ($a0)
	
	addi $a0, $a0, 1
	lb $s1, ($a0)
	
	ble $s0, $s1, for_2_up_part9
	### swap
	
	sb $s0, ($a0)
	
	addi $a0, $a0, -1
	
	sb $s1, ($a0)
	
	addi $a0,$a0, 1
	
	addi $t1, $t1, 1
	
	j for2_part9
	
	### swap
for_2_up_part9:
	addi $t1, $t1, 1
	j for2_part9
	
for2_part9_1:
	addi $t0, $t0, 1
	j for1_part9
	
done_part9:
	lw $ra, 4($sp)
	jr $ra

# Part X
decrypt:
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	li $t8,0
#### length counter
loop_p10:
	lb $t0, ($a2)
	beq $t0, $zero, cont1_p10
	
	addi $a2, $a2, 1
	addi $t8, $t8, 1
	j loop_p10
cont1_p10:
	move $t7, $t8
	addi $t8, $t8, 24
	move $a0, $t8
	li $v0, 9
	syscall
	
	### save regis###
	sw $ra, 0($v0)
	sw $s0, 4($v0)
	sw $s1, 8($v0)
	sw $s2, 12($v0)
	sw $s3, 16($v0)
	sw $v0, 20($v0)
	################
	move $s3, $v0
	
	addi $v0, $v0, 24
	
	move $s4, $v0
	
	move $v0, $s3
	
	lw $a2, 12($s3)
	
	move $v0, $s4
	
	
loop1_p10:
	lb $t0, ($a2)
	beq $t0, $zero, cont2_p10
	sb $t0, ($v0)
	
	addi $a2, $a2, 1
	addi $v0, $v0, 1
	j loop1_p10
cont2_p10:
	
	move $a0, $s4
	jal string_sort
	
	## test
	##addi $a0, $a0, 1
	##lb $t0, ($a0)
	move $s2, $a0
	li $t0, 0 ## i
	
for1_p10:
	lb $t2, ($a0)
	beq $t2, $zero, done_p10
	##################
	li $t1, 0
	move $v0, $s3
	lw $a2, 12($s3)
	#################
	
for2_p10:
	lb $t3, ($a2)
	beq $t2, $t3, for_up_p10
	
	addi $t1, $t1, 1
	addi $a2, $a2, 1
	j for2_p10
	
for_up_p10:
############
	addi $t1, $t1, 48
	########
	sb $t1, ($a0)
	addi $a0, $a0, 1
	j for1_p10
	
	
done_p10:
	################## counter
	li $t7, 0
	move $v0, $s3
	lw $a0, 8($v0)
	#################
loop3_p10:
	lb $t0, ($a0)
	beq $t0, $zero, cont3_p10
	
	addi $a0, $a0, 1
	addi $t7, $t7, 1
	j loop3_p10


cont3_p10:
	###lb $t0, ($s2)
	move $v0, $s3
	#### transpose
	sw $s2, 12($v0)  ## sorted address
	lw $a0, 8($v0)
	lw $a1, 16($v0)
	move $a2, $t8
	div $t7, $t8
	mflo $a3
	
	jal transpose
	
	
	
	#########  key sort
	move $v0, $s3
	lw $a0, 16($v0)
	###############
	move $a2, $t8
	div $t7, $t8
	mflo $a1
	##################
	lw $a3, 12($v0)
	li $t0, 1
	
	jal key_sort_matrix
	
	#########  pair loop
	move $s1, $v0
	#################
	lw $s2, 16($s1)
	move $s0, $s2
	
loop_pair_p10:
	lb $a1, ($s2)
	beq $a1, 42, done_p_p10
	addi $s2, $s2, 1
	lb $a2, ($s2)
	addi $s2, $s2, 1
	lw $a0, 4($s1)
	jal lookup_char
	
	sb $v1, ($s0)
	addi $s0, $s0, 1
	j loop_pair_p10
	
done_p_p10:	
	li $t0, 0
	lb $t9, ($s0)
	sb $t0, ($s0)
	lw $ra, 0($s1)
	jr $ra

#####################################################################
############### DO NOT CREATE A .data SECTION! ######################
############### DO NOT CREATE A .data SECTION! ######################
############### DO NOT CREATE A .data SECTION! ######################
##### ANY LINES BEGINNING .data WILL BE DELETED DURING GRADING! #####
#####################################################################
