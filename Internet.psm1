# Import Variables module
Import-Module $home\Documents\WindowsPowerShell\Variables

# Weather
Function weather {python $HOME\OneDrive\Work\Weather\printWeather.py}
function reddit {python $HOME\OneDrive\Work\Reddit\Reddit.py}
function hacker {python $HOME\OneDrive\Work\HackerNews\hackerNews.py}
function newsapi {Start-Process -NoNewWindow $HOME\OneDrive\Work\News\main\main.exe}
function news {
    Write-Host "`n*** Reddit ***`n"
    reddit
    Write-Host "`n*** HN ***`n"
    hacker
    Write-Host "`n*** Top 10 ***`n"
    newsapi
}

Function wifi {open($ROUTER)}

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

    if ([string]::IsNullOrEmpty($s)) {
            open $GOOGLE
    } else {
        switch ($true) {
            $a {
                foreach ($site in $sites) {
                    open "$site$s"; wait 1
                }
            } 
            Default {
                open "$GOOGLE$s"; wait 1
            }
        }
    }
}

# Open youtube
Function youtube {
    param(
        [string]$esto
    )
    if ([string]::IsNullOrEmpty($esto)) {
        open $YOUTUBE
    }else{
        open "$YTSEARCH$esto"
    }
}

# Open Blackboard
Function black {
    open "https://kilgore.blackboard.com"
}

# Open Fav websites
Function fav {
    <#
    .Description
    -choice are s = social or n = news. Default is all 
    #>
    param(
        [switch]$s,
        [switch]$n
    )
    $social = @($YOUTUBE, $TIK, $INSTA, $FACE, $LINKED)
    $news = @($HN, $DEV, $REDDIT, $GNEWS, $YNEWS)
    
    switch ($true) {
        $s {
            foreach ($site in $social) {
                open $site; wait 1
            }
        } 
        $n {
            foreach ($site in $news) {
                open $site; wait 1
            }
        } 
        Default {
            foreach ($site in $social) {
                open $site; wait 1
            } 
            foreach ($site in $news) {
                open $site; wait 1
            }
        }
    }
}
