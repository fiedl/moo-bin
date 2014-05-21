#!/usr/bin/python2

## begin spambot input
import random

def listSpamButtons(spam_buttons, answer):
	spam_buttons[random.randint(1, len(spam_buttons) - 1) ] = answer
	for btn in spam_buttons:
		print "<input type=\"submit\" value=\"",btn,"\" name=\"submit_button\" class=\"button_form\" />"
## end spambot input

## begin spambot POST
def checkSpamButtons(request, answer):
	# If we have submit_button parameter and they match 'answer', 404
	if not 'submit_button' in request or request['submit_button'] != answer:
		print "Failure, render_404(request)"
	else:
		print "Success, proceeding..."
## end spambot POST


## string to check against
answer = '3+1=4'

## begin spambot input test
listSpamButtons(['1+2=4', '2-2=3', '1+3=5', '2+2=5', '5-3=1', '1+4=3'], answer)
## end spambot input test

## begin test example POST
request={'submit_button': answer, 'foo': 2, "bar": 3}
checkSpamButtons(request, answer)
## end test example POST
