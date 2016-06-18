# Basic requirements:
* Python 2.7 - such as Mac OS X default version

# 1. Get an API key
<http://steamcommunity.com/dev/apikey>

# 2. Get your steam account ID:

Public name:    JimmyJazz

URL:            <http://steamcommunity.com/profiles/76561197970347865/home/>

Steam ID:       76561197970347865

# 3. Retrieve list of games

<http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=API_KEY_GOES_HERE&steamid=76561197970347865&format=json>

Games owned = 172 

# 4. Setup steamapi library

a. Download or clone from <https://github.com/smiley/steamapi>

b. Extract and change working directory

c. Build the library --> creates a build folder

    python setup.py build

d. Setup PYTHONPATH: 

    PYTHONPATH=/my/workspace/lib/python2.7/site-packages/

e. Install the library: 

    python setup.py install --prefix /my/workspace

# 5. Retrieve list of games, achievements, etc

See extract.py for code.

Uses the following:
- [steamapi](https://github.com/smiley/steamapi) library
- [SteamSpy API](http://steamspy.com/api.php)
- [requests](http://docs.python-requests.org/en/latest/) library

# 6. Analyze / plot data

See analyse.R for code

Uses output of extract.py to generate exploratory visualizations.







