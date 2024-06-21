# Weather
Function weather {python $HOME\OneDrive\Work\Weather\printWeather.py}
Function reddit {python $HOME\OneDrive\Work\Reddit\Reddit.py}
Function hacker {python $HOME\OneDrive\Work\HackerNews\hackerNews.py}
Function newsapi {python $HOME\OneDrive\Work\NewsAPI\NewsAPI.py}
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
    -choice are s = social or o = other. Default is all 
    #>
    param(
        [switch]$s,
        [switch]$o
    )
    $social = @($STACKFLOW, $GITHUB, $REDDIT, $DEVTO, $LINKED, $FACE, $INSTA)
    $other = @($YMUSIC, $YOUTUBE, $FANATICS)
    
    switch ($true) {
        $s {
            foreach ($site in $social) {
                start $site; sleep 1
            }
        } 
        $o {
            foreach ($site in $other) {
                start $site; sleep 1
            }
        }
        Default {
            foreach ($site in $other) {
                start $site; sleep 1
            } 
            foreach ($site in $social) {
                start $site; sleep 1
            }
        }
    }
}

Function sound {
    $sound = @($YMUSIC, $YOUTUBE)
    foreach ($site in $sound) {
        start $site; sleep 1
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

    if ([string]::IsNullOrEmpty($s)) {
            start $GOOGLE
    } else {
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
