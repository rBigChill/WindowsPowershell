import apiKey
import subprocess
import sys
import webbrowser
import argparse

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

    def _printDash(self):
        count = 1
        print(f"{'':10}*** Top US Articles ***")
        print()
        for i in self.Articles:
            print(f"{count}) {i.title}\n\t--> {i.url}\n")
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

    def GetDashNews(self):
        self._clear()
        self._getArticles()
        self._printDash()

if __name__ == "__main__":
    p = argparse.ArgumentParser(exit_on_error=False)
    p.add_argument("-d", action="store_true")
    a = p.parse_args()
    if a.d:
        n = NewsAPI()
        n.GetDashNews()
    else:
        n = NewsAPI()
        n.GetNews()    

