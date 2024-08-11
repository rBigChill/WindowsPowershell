# Author: Jorge Cisneros
#
# Purpose: Automation functions for all my internet needs...
#

# Variables
$BASE = "$HOME\Documents\WindowsPowershell\Python\"

# Scrape and print to screen the passed in url's body
Function web {
    param(
        [string]$url
    )
    $a = Invoke-WebRequest $url
    $a.ParsedHtml.IHTMLDocument2_body.innerText
}

# Runs weather python script and prints the current locations weather
Function weather {
    param(
        [switch]$n
    )
    $FILE = "Weather\printWeather.py"
    switch ($true) {
        $n {python $BASE$FILE -n}
        Default {python $BASE$FILE}
    }
}

# News
Function reddit {
    param(
        [switch]$d
    )
    $FILE = "Reddit\Reddit.py"
    switch ($true) {
        $d {python $BASE$FILE -d}
        Default {python $BASE$FILE}
    }
}
Function hacker {
    param(
        [switch]$d
    )
    $FILE = "HackerNews\hackerNews.py" 
    switch ($true) {
        $d {python $BASE$FILE -d}
        Default {python $BASE$FILE}
    }
}
Function newsapi {
    param(
        [switch]$d
    )
    $FILE = "NewsAPI\NewsAPI.py"
    switch ($true) {
        $d {python $BASE$FILE -d}
        Default {python $BASE$FILE}
    }
}
Function news {
    reddit
    hacker
    newsapi
}

Function wifi {start($ROUTER)}

# start Fav websites
Function fav {
    <#
    .Description
    -choices are s = social, e = entertainment. Default is all 
    #>
    param(
        [switch]$s,
        [switch]$e
    )
    $social = @($REDDIT, $TWITTER, $FACE, $INSTA)
    $entertainment = @($TV, $YMUSIC, $YOUTUBE, $TIK)

    Function go ($a) {foreach ($s in $a) {start $s; sleep 1}}
    
    switch ($true) {
        $s {go $social} 
        $e {go $entertainment}
        $o {go $other}
        Default {
            go $entertainment
            go $other
            go $social
        }
    }
}

# Google search
Function google {
    <#
    .Description
    -a to search all sites
    #>
    param(
        [string]$s,
        [switch]$a
    )

    $sites = @($GOOGLE, $BING, $YOU, $YAHOO, $DUCK)

    switch ($true) {
        $a {
            foreach ($site in $sites) {
                start "$site$s"; sleep 1
            }
        } 
        Default {
            start "$GOOGLE$s"; sleep 1
        }
    }
}

# start youtube
Function youtube {
    param(
        [string]$esto
    )
    if ([string]::IsNullOrEmpty($esto)) {
        start $YOUTUBE
    }else{
        start "$YTSEARCH$esto"
    }
}
