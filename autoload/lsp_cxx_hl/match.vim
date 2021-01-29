" Conversion Functions
function! lsp_cxx_hl#match#lsrange2match(range) abort
    return s:range_to_matches(
                \ a:range['start']['line'] + 1,
                \ a:range['start']['character'] + 1,
                \ a:range['end']['line'] + 1,
                \ a:range['end']['character'] + 1
                \ )
endfunction

function! s:range_to_matches(s_line, s_char, e_line, e_char) abort
    " single line symbol
    if a:s_line == a:e_line
        if a:e_char - a:s_char > 0
            return [[a:s_line, a:s_char, a:e_char - a:s_char]]
        else
            return []
        endif
    endif

    " multiline symbol
    let l:s_line = a:s_line < 1 ? 1 : a:s_line
    let l:e_line = a:e_line > line('$') ? line('$') : a:e_line

    let l:matches = []

    let l:s_line_end = col([l:s_line, '$'])

    if l:s_line_end - a:s_char >= 0
        call add(l:matches, [l:s_line, a:s_char, l:s_line_end - a:s_char])
    endif

    if (l:s_line + 1) < (l:e_line - 1)
        let l:matches += range(l:s_line + 1, l:e_line - 1)
    endif

    if a:e_char - 1 > 0
        call add(l:matches, [l:e_line, 1, a:e_char - 1])
    endif

    return l:matches
endfunction
