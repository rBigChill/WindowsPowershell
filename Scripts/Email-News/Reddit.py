import subprocess
import sys
import webbrowser
import redditCreds as c

from os import system, name

try:
    import praw
except:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "praw"])
finally:
    import praw

class Article:
    def __init__(self):
        self.title = ''
        self.sub = ''
        self.url = ''

class Reddit:

    def __init__(self):
        self.REDDIT = praw.Reddit(
                client_id = c.CLIENT_ID,
                client_secret = c.CLIENT_SECRET,
                user_agent = c.USER_AGENT,
                username = c.USERNAME,
                password = c.PASSWORD,
                )
        self.ARTICLES = []

    def _grabArticles(self):

        for submission in self.REDDIT.front.hot(limit=10):
            a = Article()
            a.title = submission.title
            a.sub = submission.subreddit.display_name
            a.url = submission.url
            self.ARTICLES.append(a)

    def _printArticles(self):
        count = 1
        print(f"{'':10}*** REDDIT ***")
        print()
        for i in self.ARTICLES:
            article = f"{count}) {i.title}\n{i.url}\n"
            print(article)
            count += 1
        print()
    
    def GetReddit(self):
        self._grabArticles()
        self._printArticles()

if __name__ == "__main__":
    r = Reddit()
    r.GetReddit()
