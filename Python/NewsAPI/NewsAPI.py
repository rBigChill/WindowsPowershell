import apiKey
import subprocess
import sys
import webbrowser

from os import system, name

try:
    from newsapi import NewsApiClient
except:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "newsapi-python"])
finally:
    from newsapi import NewsApiClient

class Article:
    def __init__(self):
        self.title = ''
        self.url = ''

class NewsAPI:
    def __init__(self):
        self.Articles = []

    def _getArticles(self):
        client = NewsApiClient(api_key = apiKey.ApiKey)
        top = client.get_top_headlines(page_size=10,country='us') 

        for v in top['articles']:
            a = Article()
            a.title = v['title']
            a.url = v['url']
            self.Articles.append(a)

    def _printArticles(self):
        count = 1
        print(f"{'':10}*** Top US Articles ***")
        print()
        for i in self.Articles:
            print(f"{count}) {i.title}\n")
            count += 1

    def _clear(self):
        system('cls') if name == 'nt' else system('clear')

    def _prompt(self):
        selection = 0

        while selection != '':
            try:
                selection = input("Print article (#) or Enter to quit?: ")
                if selection != '':
                    webbrowser.open(n.Articles[int(selection)-1].url)
                    self._clear()
                    self._printArticles()
            except (ValueError, IndexError):
                print("Enter article number or Enter to quit")

    def GetNews(self):
        self._clear()
        self._getArticles()
        self._printArticles()
        self._prompt()

if __name__ == "__main__":
    n = NewsAPI()
    n.GetNews()    
