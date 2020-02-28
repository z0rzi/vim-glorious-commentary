
if ! exists("g:glorious_com_use_ascii")
    let g:glorious_com_use_ascii = 1
endif

if g:glorious_com_use_ascii
    let s:horizontal = '-'

    let s:horizontal_left_up = ''''
    let s:horizontal_right_up = ''''
    let s:horizontal_middle_up = '.'

    let s:horizontal_left_down = '.'
    let s:horizontal_right_down = '.'
    let s:horizontal_middle_down = ''''
else
    let s:horizontal = '─'

    let s:horizontal_left_up = '╰'
    let s:horizontal_right_up = '╯'
    let s:horizontal_middle_up = '┬'

    let s:horizontal_left_down = '╭'
    let s:horizontal_right_down = '╮'
    let s:horizontal_middle_down = '┴'
endif

function gloriousCommentary#horizontal(direction)
    let origin_left = getpos('''<')
    let origin_right = getpos('''>')

    let g:origin_left = origin_left
    let g:origin_right = origin_right
    
    if a:direction == 'up'
        let middle = s:horizontal_middle_up
        let right = s:horizontal_right_up
        let left = s:horizontal_left_up
    else
        let middle = s:horizontal_middle_down
        let right = s:horizontal_right_down
        let left = s:horizontal_left_down
    endif

    if col('''>') == col('$')
        " Out of line!
        exe "norm!gvr\<SPACE>"
        let origin_left[2] = origin_left[2] + origin_left[3] + 1
        let origin_right[2] = origin_right[2] + origin_right[3] + 1

        let pos1 = [ line('''<'), virtcol('''<') + origin_left[3] ]
        let pos2 = [ line('''>'), virtcol('''>') + origin_right[3] ]
    else
        let pos1 = [ line('''<'), virtcol('''<') ]
        let pos2 = [ line('''>'), virtcol('''>') ]
    endif

    let dist = pos2[1] - pos1[1] - 1

    let half_dist = (dist - (dist%2?2:1)) / 2
    let middle_amount = dist - half_dist*2

    call setpos('.', origin_left)
    exe 'norm!'.(dist+2).'xh'
    if dist+2 > 1
        exe 'norm!a' . left
    endif
    if half_dist > 0
        exe 'norm!'.half_dist.'a' . s:horizontal
    endif
    if middle_amount > 0
        exe 'norm!'.middle_amount.'a' . middle
    endif
    if half_dist > 0
        exe 'norm!'.half_dist.'a' . s:horizontal
    endif
    if dist+2 > 1
        exe 'norm!a' . right
    endif
endfunction
