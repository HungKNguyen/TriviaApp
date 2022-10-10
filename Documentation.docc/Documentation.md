# ``TriviaApp``

Documentation to link View (Colin) and Controller (Hung) of the app

## Overview

### Entry View (Scene #1)
This is the place where user can choose to make/manage quizzes or to join and answer questions.
Two Buttons:
1: Choose to make/manage quizzes -> Implement later if we have the time
2: Choos to join and answer questions -> Transition to Scene #2

### Login View (Scene #2)
This is the place where user can put in their login information
Two Text Fields:
1: Place for user to put in username
2: Place for users to put in passwords
Two Buttons:
1: Press to Log In -> If valid move to Scene Group #3
2: Press to create a new user -> If valid move to Scene Group #3
One Label:
1: Place to provide user feedback if not valid

### Tab Bar (Scene Group #3)
This tab bar have 3 options
Three tab buttons:
1: Press to show tab about user personal info (Scene #3A)
2: Press to show tab about taking quizzes (Scene #3B)
3: Press to show leaderboard (Scene #3C)

### Profile Tab (Scene #3A)
This is the place where user can view their username, password and score as well as log out
Three labels:
1: Show username
2: Show password
3: Show score
One button:
1: Press to log out -> Move to Scene #2

### Quizzes (Scene Group #3B)
This is the place where you can view the list of quizzes
Table views:
Each cell shows the title and how many questions that quiz have
User can press on the quiz to move to that quiz specifically -> Move to Scene #4

### Questions (Scene #4)
This is the place where to user can view all questions of a quiz
Table views:
Each cell show the question
User can press on the question to move to that question specifically -> Move to Scene #5
One Button:
1: Press to go back to the list of quizzes -> move to Scene Group #3 and Scene #3B

### Question (Scene #5)
This is the place where the user can answer a question
Two labels:
1: Label to show question
2: Label to provide feedback on if the user got it right, wrong, or answred already
Four radio choice box:
Each for user to select as their answer.
Two Button:
1: Press to submit the answer -> Label 2 will change to reflect feedback
2: Press to navigate back to the list of question -> Move to Scene #4
