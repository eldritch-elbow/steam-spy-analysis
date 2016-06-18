#!/usr/bin/python

import steamapi
import inspect
import requests
import csv

def get_my_games(  ):

	# Set up the connection and user objects
	api = steamapi.core.APIConnection(api_key="")
	me  = steamapi.user.SteamUser(76561197970347865)

	# Retrieve games / get achievements
	games_map = dict()
	achs_list = []

	for game in me.games:

	  games_map[game.appid] = game

	  try:
	  	for ach in game.achievements:
	  		achs_list.append(ach)

	  except steamapi.errors.APIBadCall, e:
	  	print "ERROR: Unable to retrieve achievements. %d:'%s' / playtime = %d m" % (game.appid, game.name.encode('utf8'), game.playtime_forever)
	  except AttributeError, e:
	  	print "ERROR: AttributeError. %d:'%s' / Exception = %s" % (game.appid, game.name.encode('utf8'), str(e))


	def rarity(ach1, ach2):
	    if ach1.unlock_percentage < ach2.unlock_percentage:
	        return -1
	    elif ach1.unlock_percentage > ach2.unlock_percentage:
	        return 1
	    else:
	        return 0

	# Display games list 
	print '\nGAMES'
	print games_map
	print len(games_map)
	print ''

	achs_list = sorted(achs_list, cmp=rarity)

	# Display achievements list 
	print '\nACHIEVEMENTS'
	for ach in achs_list:
		if ach.is_unlocked:
			print "'%d', '%s', '%f', '%d'" % (ach.appid, ach.name.encode('utf8'), ach.unlock_percentage, games_map[ach.appid].playtime_forever)

def get_steamspy_records():

	r = requests.get('http://steamspy.com/api.php?request=top100forever')
	print r.status_code
	print r.headers['content-type']
	print r.encoding
	resp_data = r.json()

	with open('output/steamspy_out.csv', 'wb') as csvfile:
		spamwriter = csv.writer(csvfile, quoting=csv.QUOTE_NONNUMERIC)
		for app_id in resp_data:
			record = resp_data[app_id]
			spamwriter.writerow([record['appid'], record['name'], record['players_forever'], record['average_forever']])		

get_steamspy_records()


