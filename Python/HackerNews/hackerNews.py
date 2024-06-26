# Author: Jorge Cisneros

import subprocess
import sys
import webbrowser
import argparse

from os import system, name

try:
    import requests
except:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "requests"])
finally:
    import requests

class Article:
    def __init__(self):
        self.title = ''
        self.url = ''

class HackerNews:
    def __init__(self):
        self.API_BASE = "https://hacker-news.firebaseio.com/v0"
        self.TOP_STORIES = f"{self.API_BASE}/topstories.json"
        self.ARTICLES = f"{self.API_BASE}/item/"
        self.frontPage = [] 

    def _makeRequest(self):
        r = requests.get(self.TOP_STORIES)
        self.submission_ids = r.json()

    def _getArticles(self):
        self._makeRequest()

        for submission_id in self.submission_ids[:10]:
            r = requests.get(f"{self.ARTICLES}{submission_id}.json")
            self.response_dict = r.json()

            r = Article()

            try:
                r.title = self.response_dict["title"]
                r.url = self.response_dict["url"]
                self.frontPage.append(r)
            except KeyError:
                continue

    def _printArticles(self):
        count = 1
        print(f"{'':10}*** Hacker News ***")
        print()
        for i in self.frontPage:
            article = f"{count}) {i.title}\n"
            print(article)
            count += 1
        print()

    def _clear(self):
        system('cls') if name == 'nt' else system('clear')

    def _prompt(self):
        selection = 0

        while selection != '':
            try:
                selection = input("Print article (#) or Enter to quit?: ")
                if selection != '':
                    webbrowser.open(HN.frontPage[int(selection)-1].url)
                    self._clear()
                    self._printArticles()
            except (ValueError, IndexError):
                print("Enter article number")

    def GetNews(self):
        self._clear()
        self._getArticles()
        self._printArticles()
        self._prompt()
        
    def GetDashNews(self):
        self._clear()
        self._getArticles()
        self._printArticles()

if __name__ == "__main__":
    p = argparse.ArgumentParser(exit_on_error=False)
    p.add_argument("-d", action="store_true")
    a = p.parse_args()
    if a.d:
        HN = HackerNews()
        HN.GetDashNews()
    else:
        HN = HackerNews()
        HN.GetNews()

