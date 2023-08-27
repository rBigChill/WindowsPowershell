import requests
import json
import settings
import weatherCreds as c

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

# class Weather returns requested weather object
class Weather:
    def __init__(self):
        self.API_BASE = "https://api.weather.gov"
        self.HEADERS = {"personalPythonApp": "cisneros.jorge82@yahoo.com"}
        self.DAILY = f"{self.API_BASE}/gridpoints/SHV/39,67/forecast"
        self.HOURLY = f"{self.API_BASE}/gridpoints/SHV/39,67/forecast/hourly"
        self.responseObjects = []

    def _makeRequest(self, request_type, headers):
        self.weather = requests.get(request_type, headers=headers)
        return self.weather

    # _printWeather prints weather message
    def _printWeather(self):
        print()
        for i in self.responseObjects:
            message = f"{i.name:16}: {i.temperature:3}{i.temperatureUnit:2}~ {i.shortForecast}"
            print(message)
        print()

    def _textWeather(self):
        text = ""

        for i in self.responseObjects:
            message = f"{i.name:16}: {i.temperature:3}{i.temperatureUnit:2}~ {i.shortForecast}\n"
            text += message

        client = Client(c.ACCOUNT_SID, c.AUTO_TOKEN)
        client.messages.create(
          from_='+18556438832',
          body=text,
          to='+13103409148'
        )

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
            r.relativeHumidity = day['relativeHumidity']
            r.windSpeed = day['windSpeed']
            r.windDirection = day['windDirection']
            r.shortForecast = day['shortForecast']
            r.detailedForecast = day['detailedForecast']
            self.responseObjects.append(r)

        self._printWeather()
        #self._textWeather()
        
if __name__ == "__main__":
    w = Weather()
    w.DailyRequest()
