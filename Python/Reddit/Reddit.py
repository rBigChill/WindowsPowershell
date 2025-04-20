# Author: Jorge Cisneros

# Reddit grabs users front page and prints it to the command line
# User can then choose an article to read in their default browser.

# import modules
import subprocess
import sys
import webbrowser
import argparse

import redditCreds as c

from os import system, name

# import praw. If praw not installed, install praw and import
try:
    import praw
except:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "praw"])
finally:
    import praw

# Article object to save article information
class Article:
    def __init__(self):
        self.title = ''
        self.sub = ''
        self.url = ''

# The reddit instance
class Reddit:

    # initialize reddit class using praw
    def __init__(self):
        self.REDDIT = praw.Reddit(
                client_id = c.CLIENT_ID,
                client_secret = c.CLIENT_SECRET,
                user_agent = c.USER_AGENT,
                username = c.USERNAME,
                password = c.PASSWORD,
                )
        self.ARTICLES = []

    # Download and save article objects into self.articles
    def _grabArticles(self):

        for submission in self.REDDIT.front.hot(limit=10):
            a = Article()
            a.title = submission.title
            a.sub = submission.subreddit.display_name
            a.url = submission.url
            self.ARTICLES.append(a)

    # Print Reddit articles
    def _printArticles(self):
        count = 1
        print(f"{'':10}*** REDDIT ***")
        print()
        for i in self.ARTICLES:
            article = f"{count}) {i.title}\n"
            print(article)
            count += 1
        print()
    
    # Print Dash articles
    def _printDash(self):
        count = 1
        #print(f"{'':10}*** REDDIT ***")
        #print()
        for i in self.ARTICLES:
            #article = f"{count}) {i.title}\n\t--> {i.url}\n"
            article = f"{i.title}"
            print(article)
            count += 1
        print()
    
    # clears the screen
    def _clear(self):
        system('cls') if name == 'nt' else system('clear')        

    # prompt for the user
    def _prompt(self):
        selection = 0 

        while selection != '':
            try:
                selection = input("Print article (#) or Enter to quit?: ")
                if selection != '':
                    webbrowser.open(r.ARTICLES[int(selection)-1].url)
                    self._clear()
                    self._printArticles()
            except (ValueError, IndexError):
                print(f"Enter article number or press Enter to quit")

    # Constructor
    def GetReddit(self):
        self._clear()
        self._grabArticles()
        self._printArticles()
        self._prompt()

    def DashReddit(self):
        self._clear()
        self._grabArticles()
        self._printDash()

if __name__ == "__main__":
    p = argparse.ArgumentParser(exit_on_error=False)
    p.add_argument("-d", action="store_true")
    a = p.parse_args()
    if a.d:
        r = Reddit()
        r.DashReddit()
    else:
        r = Reddit()
        r.GetReddit()
