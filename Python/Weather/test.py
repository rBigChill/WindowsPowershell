import json

import requests

MAIN_SITE = "https://geocoding.geo.census.gov/geocoder/geographies/coordinates"
data = requests.get(WEBSITE)
json = data.json()
city = json['city']
state = json['regionName']
self.info = f'{city}, {state}'
self.lat = json['lat']
self.lon = json['lon']
