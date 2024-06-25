# Weather
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
Function reddit {python "$HOME\Documents\WindowsPowershell\Python\Reddit\Reddit.py"}
Function hacker {python "$HOME\Documents\WindowsPowershell\Python\HackerNews\hackerNews.py"}
Function newsapi {python "$HOME\Documents\WindowsPowershell\Python\NewsAPI\NewsAPI.py"}
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
    -choices are s = social, e = entertainment, o = other. Default is all 
    #>
    param(
        [switch]$s,
        [switch]$e,
        [switch]$o
    )
    $social = @($REDDIT, $DEVTO, $LINKED, $FACE, $INSTA)
    $entertainment = @($YMUSIC, $YOUTUBE)
    $other = @($FANATICS, $STACKFLOW, $GITHUB)

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
