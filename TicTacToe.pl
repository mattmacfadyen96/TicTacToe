import random

def choose_first():
	flip = random.randint(0,1)

	if flip == 0:
		return 'Player1'
	else:
		return 'Player2'

def display_board(a,b):
	print('\n'*100)
	print('Available   TIC-TAC-TOE\n'+
           '  moves\n\n  '+
          a[7]+'|'+a[8]+'|'+a[9]+'        '+b[7]+'|'+b[8]+'|'+b[9]+'\n  '+
          '-----        -----\n  '+
          a[4]+'|'+a[5]+'|'+a[6]+'        '+b[4]+'|'+b[5]+'|'+b[6]+'\n  '+
          '-----        -----\n  '+
          a[1]+'|'+a[2]+'|'+a[3]+'        '+b[1]+'|'+b[2]+'|'+b[3]+'\n')
def place_marker(board, marker, position):
		board[position] = marker
		return board

def player_input():
	ready_to_play = False
	while ready_to_play == False:
		assign_random = input("Do you want to randomly be given 'X' or 'O'? Type Yes or No: ")
		if assign_random.upper() == 'YES':
			if choose_first() == 'Player1':
				player1 = 'X'
				player2 = 'O'
				return (player1, player2)
			elif choose_first() == 'Player2':
				player2 = 'X'
				player1 = 'O'
				return (player2, player1)
		elif assign_random.upper() == 'NO':
			player1 = input("Do you want to be 'X' or 'O': ")
			if player1.upper() == 'X':
				print('Player 1 will go first')
				player1 = 'X'
				player2 = 'O'
				return (player1, player2)
			elif player1.upper() == 'O':
				print('Player 2 will go first')
				player1 = 'O'
				player2 = 'X'
				return (player2, player1)
		print("\n")

def space_check(board, position):
	"""Returns true if the space is free, otherwise returns false"""
	if board[position] == ' ':
		return True
	else:
		return False 

def win_check(board, mark):
	# Check horizontal wins 
	if board[1] == board[2] == board[3] == mark:
		return True
	elif board[4] == board[5] == board[6] == mark:
		return True 
	elif board[7] == board[8] == board[9] == mark:
		return True
	# Check vertical wins 
	elif board[1] == board[4] == board[7] == mark:
		return True
	elif board[2] == board[5] == board[8] == mark:
		return True
	elif board[3] == board[6] == board[9] == mark:
		return True
	# Check diagonal wins 
	elif board[1] == board[5] == board[9] == mark:
		return True
	elif board[3] == board[5] == board[7] == mark:
		return True
	else:
		return False

def full_board_check(board):
	if ' ' in board[1:len(board)-1]:
		return False
	else:
		return True

def player_choice(board):
	position = int(input('Choose your next position: (1-9)'))
	if position < 1 or position > 9:
		return 'Invalid position provided'
	else:
		if space_check(board, position):
			return position
		else:
			print('There is a mark on that position already!')

def replay():
	playAgain = input("Do you want to play again? Enter Yes or No: ")
	if playAgain.upper() == 'YES':
		return True
	else:
		return False

print("Welcome to Tic Tac Toe!")
print("\n")
players = list(player_input())
ready_to_play = input("Are you ready to play? Enter Yes or No. ")

board = [' '] * 10
available = [str(num) for num in range(0,10)]

if ready_to_play.upper() == 'YES':
	game_on = True
	display_board(available, board)
	while(game_on):
		# Do a full board check
		if full_board_check(board):
			print('Full board, its a tie!')
			if replay() == False:
				break
			else:
				board = [' '] * 10
				display_board(available, board)
				continue

		position = player_choice(board)
		if position is None:
			continue
		current_player = players.pop(0)
		board = place_marker(board, current_player, position)


		# Display the board after a move has been made  
		display_board(available, board)


		players.append(current_player)

		if win_check(board, current_player):
			print('You are the winner!')
			if replay() == False:
				game_on = False
			else:
				board = [' '] * 10
				display_board(available, board)
