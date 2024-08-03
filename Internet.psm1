# Author: Jorge Cisneros
#
# Purpose: Automation functions for all my internet needs...
#
# Print web requested text to screen. Scrape the passed in website's data
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
    switch ($true) {
        $n {python "$HOME\Documents\WindowsPowershell\Python\Weather\printWeather.py" -n}
        Default {python "$HOME\Documents\WindowsPowershell\Python\Weather\printWeather.py"}
    }
}

# News
Function reddit {
    param(
        [switch]$d
    )
    switch ($true) {
        $d {python "$HOME\Documents\WindowsPowershell\Python\Reddit\Reddit.py" -d}
        Default {python "$HOME\Documents\WindowsPowershell\Python\Reddit\Reddit.py"}
    }
}
Function hacker {
    param(
        [switch]$d
    )
    switch ($true) {
        $d {python "$HOME\Documents\WindowsPowershell\Python\HackerNews\hackerNews.py" -d}
        Default {python "$HOME\Documents\WindowsPowershell\Python\HackerNews\hackerNews.py"}
    }
}
Function newsapi {
    param(
        [switch]$d
    )
    switch ($true) {
        $d {python "$HOME\Documents\WindowsPowershell\Python\NewsAPI\NewsAPI.py" -d}
        Default {python "$HOME\Documents\WindowsPowershell\Python\NewsAPI\NewsAPI.py"}
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
    $entertainment = @($YMUSIC, $TV, $YOUTUBE, $TIK)

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
