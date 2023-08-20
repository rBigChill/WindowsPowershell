# Import Variables module
Import-Module $home\Documents\WindowsPowerShell\Var

# Longview Weather
Function weather {open($WEATHER)}

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
    -choice is s = social or n = news. Default is all 
    #>
    param(
        [switch]$s,
        [switch]$n
    )
    $social = @($TIK, $INSTA, $FACE, $LINKED)
    $news = @($GITHUB, $HN, $DEV, $REDDIT, $GNEWS, $YNEWS)
    
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

# Open files
Function finance {open $FINANCE}

# Open Apps
Function chrome {open $CHROME}
Function outlook {open $OUTLOOK}
Function onenote {open $ONENOTE}

# Startup
Function leggo {
    $apps = @($OUTLOOK, $ONENOTE)
    foreach ($app in $apps) {
        open $app; wait 1
    }
}
