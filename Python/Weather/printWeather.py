import subprocess
import sys
import json
import datetime

try:
    import requests
except:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "requests"])
finally:
    import requests

class Location:
    def __init__(self):
        WEBSITE = "https://api.techniknews.net/ipgeo/"
        data = requests.get(WEBSITE)
        json = data.json()
        city = json['city']
        state = json['regionName']
        self.cityInfo = f'{city}, {state}'

        print(f'\n\tWeather for {self.cityInfo}')

        self.lat = json['lat']
        self.lon = json['lon']
    
class Grid:
    def __init__(self):
        API_BASE = "https://api.weather.gov"
        ll = Location()
        POINT = f"{API_BASE}/points/{ll.lat}%2C{ll.lon}"
        data = requests.get(POINT)
        json = data.json()

        self.gridId = json['properties']['gridId']
        self.gridX = json['properties']['gridX']
        self.gridY = json['properties']['gridY']

# daily weather response object
class DailyWeatherResponse:
    def __init__(self):
        self.number = '',
        self.name = '',
        self.isDaytime = '',
        self.temperature = 0,
        self.temperatureUnit = '',
        self.temperatureTrend = '',
        self.probabilityOfPrecipitation = {},
        self.relativeHumidity = {},
        self.windSpeed = '',
        self.windDirection = '',
        self.shortForecast = '',
        self.detailedForecast = '',

# Hourly weather response object
class HourlyWeatherResponse:
    def __init__(self):
        self.number = '',
        self.name = '',
        self.startTime = '',
        self.endTime = '',
        self.isDaytime = '',
        self.temperature = 0,
        self.temperatureUnit = '',
        self.temperatureTrend = '',
        self.probabilityOfPrecipitation = {},
        self.relativeHumidity = {},
        self.windSpeed = '',
        self.windDirection = '',
        self.icon = '',
        self.shortForecast = '',
        self.detailedForecast = '',

# class Weather returns requested weather object
class Weather:
    def __init__(self):
        API_BASE = "https://api.weather.gov"
        self.HEADERS = {"personalPythonApp": "cisneros.jorge82@yahoo.com"}
        GRID = Grid()
        self.DAILY = f"{API_BASE}/gridpoints/{GRID.gridId}/{GRID.gridX},{GRID.gridY}/forecast"
        self.HOURLY = f"{API_BASE}/gridpoints/{GRID.gridId}/{GRID.gridX},{GRID.gridY}/forecast/hourly"
        self.dailyObjects = []
        self.hourlyObjects = []

    # _makeRequest sends HTTP requests and retursn json object
    def _makeRequest(self, request_type, headers):
        self.weather = requests.get(request_type, headers=headers)
        while self.weather.status_code != 200:
            self.weather = requests.get(request_type, headers=headers)
        return self.weather

    # _printWeather prints weather message
    def _printWeather(self, rType):

        if rType == 'd':
            print()
            for i in self.dailyObjects:
                if i.isDaytime == True:
                    message = f"{i.name}\n{i.temperature:4}{i.temperatureUnit:2}: {i.shortForecast}"
                    print(message)
                else:
                    message = f"{''}{i.temperature:4}{i.temperatureUnit:2}: {i.shortForecast}"
                    print(message)
            print()
        if rType == 'h':
            count = 0
            print()
            for i in self.hourlyObjects:
                if count <= 24:
                    message = f"{i.startTime[11:16]}: {i.temperature}{i.temperatureUnit}: {i.shortForecast}"
                    print(message)
                    count += 1
            print()

    # DailyRequest request daily weather
    def DailyRequest(self):

        request = self._makeRequest(self.DAILY, self.HEADERS)
        weather = json.loads(request.text)

        for day in weather['properties']['periods']:

            r = DailyWeatherResponse()

            r.number = day['number']
            r.name = day['name']
            r.isDaytime = day['isDaytime']
            r.temperature = day['temperature']
            r.temperatureUnit = day['temperatureUnit']
            r.temperatureTrend = day['temperatureTrend']
            r.probabilityOfPrecipitation = day['probabilityOfPrecipitation']
            r.windSpeed = day['windSpeed']
            r.windDirection = day['windDirection']
            r.shortForecast = day['shortForecast']
            r.detailedForecast = day['detailedForecast']
            self.dailyObjects.append(r)

        self._printWeather('d')

    # HourlyRequest request hourly weather
    def HourlyRequest(self):

        request = self._makeRequest(self.HOURLY, self.HEADERS)
        weather = json.loads(request.text)

        for hour in weather['properties']['periods']:

            r = HourlyWeatherResponse()
            
            r.number = hour['number']
            r.name = hour['name']
            r.startTime = hour['startTime']
            r.endTime = hour['endTime']
            r.isDaytime = hour['isDaytime']
            r.temperature = hour['temperature']
            r.temperatureUnit = hour['temperatureUnit']
            r.temperatureTrend = hour['temperatureTrend']
            r.probabilityOfPrecipitation = hour['probabilityOfPrecipitation']
            r.relativeHumidity = hour['relativeHumidity']
            r.windSpeed = hour['windSpeed']
            r.windDirection = hour['windDirection']
            r.icon = hour['icon']
            r.shortForecast = hour['shortForecast']
            r.detailedForecast = hour['detailedForecast']
            self.hourlyObjects.append(r)
        
        self._printWeather('h')

if __name__ == "__main__":
    """
    Add ability for daily or hourly request?
    """
    w = Weather()
    w.DailyRequest()
    w.HourlyRequest()
