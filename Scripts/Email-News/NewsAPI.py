import newsapiKey
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
        client = NewsApiClient(api_key = newsapiKey.ApiKey)
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
            print(f"{count}) {i.title}\n{i.url}\n")
            count += 1

    def GetNews(self):
        self._getArticles()
        self._printArticles()

if __name__ == "__main__":
    n = NewsAPI()
    n.GetNews()    
