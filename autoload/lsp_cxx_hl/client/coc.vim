" coc.nvim support

function! lsp_cxx_hl#client#coc#init() abort
    " This may do nothing if started up without a file open
    call s:doinit()

    augroup lsp_cxx_hl_coc_init
        autocmd! 
        autocmd User CocNvimInit call s:doinit()
    augroup END
endfunction

function! s:doinit() abort
    call CocRegistNotification('ccls',
                \ '$ccls/publishSemanticHighlight',
                \ function('s:ccls_hl'))

    call CocRegistNotification('ccls',
                \ '$ccls/publishSkippedRanges',
                \ function('s:ccls_regions'))
endfunction

function! s:ccls_hl(params) abort
    call lsp_cxx_hl#log('ccls hl:', a:params)

    call lsp_cxx_hl#notify_symbols('ccls', a:params['uri'],
                \ a:params['symbols'])
endfunction

function! s:ccls_regions(params) abort
    call lsp_cxx_hl#log('ccls regions:', a:params)

    call lsp_cxx_hl#notify_skipped('ccls', a:params['uri'],
                \ a:params['skippedRanges'])
endfunction
