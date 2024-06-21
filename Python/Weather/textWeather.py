#! python3.11

import subprocess
import sys
import json
import datetime
import weatherCreds as c

try:
    import requests
    from twilio.rest import Client
except:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "requests"])
finally:
    import requests

try:
    from twilio.rest import Client
except:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "twilio"])
finally:
    from twilio.rest import Client

# daily response object
class DailyWeatherResponse:
    def __init__(self):
        self.number = '',
        self.name = '',
        self.isDaytime = '',
        self.temperature = 0,
        self.temperatureUnit = '',
        self.temperatureTrend = '',
        self. probabilityOfPrecipitation = {},
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
        self.API_BASE = "https://api.weather.gov"
        self.HEADERS = {"personalPythonApp": "cisneros.jorge82@yahoo.com"}
        self.DAILY = f"{self.API_BASE}/gridpoints/SHV/39,67/forecast"
        self.HOURLY = f"{self.API_BASE}/gridpoints/SHV/39,67/forecast/hourly"
        self.dailyObjects = []
        self.hourlyObjects = []

    def _makeRequest(self, request_type, headers):
        self.weather = requests.get(request_type, headers=headers)
        while self.weather.status_code != 200:
            self.weather = requests.get(request_type, headers=headers)
        return self.weather

    # DailyRequest request daily weather
    def _dailyRequest(self):

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
            r.relativeHumidity = day['relativeHumidity']
            r.windSpeed = day['windSpeed']
            r.windDirection = day['windDirection']
            r.shortForecast = day['shortForecast']
            r.detailedForecast = day['detailedForecast']
            self.dailyObjects.append(r)

    # HourlyRequest request hourly weather
    def _hourlyRequest(self):

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

    def TextWeather(self):
        self._dailyRequest()
        self._hourlyRequest()

        text = ""

        for i in self.dailyObjects:
            if i.isDaytime == True:
                message = f"{i.name}:\n{i.temperature:4}{i.temperatureUnit:2}~ {i.shortForecast}\n"
                text += message
            else:
                message = f"{i.temperature:4}{i.temperatureUnit:2}~ {i.shortForecast}\n"
                text += message

        text += "\n"

        for i in self.hourlyObjects:
            today = datetime.date.today()
            if str(today) in i.startTime:
                message = f"{i.startTime[11:16]} :{i.temperature:4}{i.temperatureUnit:2}~ {i.shortForecast}\n"
                text += message

        client = Client(c.API_KEY, c.API_SECRET, c.ACCOUNT_SID)
        client.messages.create(
          from_ = c.FROM,
          body = text,
          to = c.TO
        )
        
if __name__ == "__main__":
    w = Weather()
    w.TextWeather()
