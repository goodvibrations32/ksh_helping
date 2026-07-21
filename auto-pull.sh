#!/bin/ksh
# A script for auto-pulling the website and copying to `/var/www' for
# httpd.
# todo:
#      - make the logging better.
#        For now only the last results are logged but this is somewhat
#        ok when you debug but not for fully automating the procedure.
#        I'm happy for the first steps in ksh and @(...|...) rocks!
#
#
# Copyright (c) 2026 Nick Torosian <goodvibrations32@awfulbytes.org>
#                     ____      ____          __
#     ____ __      __/ __/_  __/ / /_  __  __/ /____  _____
#    / __ `/ | /| / / /_/ / / / / __ \/ / / / __/ _ \/ ___/
#   / /_/ /| |/ |/ / __/ /_/ / / /_/ / /_/ / /_/  __(__  )
#   \__,_/ |__/|__/_/  \__,_/_/_.___/\__, /\__/\___/____/
#                                   /____/
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# 

base_folder="~/work/site/website"
log_file="git.log"

pull_the_stuff(){
    cd $base_folder

    exec 3> $log_file
    print -u3 "$(date)"
    /usr/local/bin/git fetch
    fetch_and_record_files=$(/usr/local/bin/git diff --name-only ..origin)
    
    if [ "$fetch_and_record_files" -eq 0 ]; then
	git_output="No files need to be updated"
    else
	print -u3 "Pulling files from the repo..."
	git_output=$(/usr/local/bin/git pull -v   2>&1)

	doas cp generated/@([4-5]*html) /var/www/errdocs
	doas cp generated/@([a-z]*html|*css) /var/www/htdocs/awfulbytes.org
	exit
     fi

    print -u3 $fetch_and_record_files
    exec 3>&-
    
    cd ~/
}

pull_the_stuff
