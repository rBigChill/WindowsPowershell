import subprocess
import sys
import webbrowser

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
            article = f"{count}) {i.title}\n{i.url}\n"
            print(article)
            count += 1
        print()

    def GetNews(self):
        self._getArticles()
        self._printArticles()
        
if __name__ == "__main__":
    HN = HackerNews()
    HN.GetNews()
