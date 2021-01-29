" Helper functions for unifying match and textprop
" Variables:
" b:lsp_cxx_hl_disabled - disable highlighting for this buffer

" Check if highlighting in the current buffer needs updating
function! lsp_cxx_hl#hl#check(...) abort
    let l:force = (a:0 > 0 && a:1)

    if get(b:, 'lsp_cxx_hl_disabled', 0)
        call lsp_cxx_hl#hl#clear()
    endif
endfunction

" Clear highlighting in this buffer
function! lsp_cxx_hl#hl#clear() abort
    let l:bufnr = winbufnr(0)

    call lsp_cxx_hl#textprop_nvim#symbols#clear(l:bufnr)
    call lsp_cxx_hl#textprop_nvim#skipped#clear(l:bufnr)
endfunction

" Enable the highlighting for this buffer
function! lsp_cxx_hl#hl#enable() abort
    unlet! b:lsp_cxx_hl_disabled

    let l:bufnr = winbufnr(0)

    call lsp_cxx_hl#textprop_nvim#symbols#highlight(l:bufnr)
    call lsp_cxx_hl#textprop_nvim#skipped#highlight(l:bufnr)
endfunction

" Disable the highlighting for this buffer
function! lsp_cxx_hl#hl#disable() abort
    let b:lsp_cxx_hl_disabled = 1

    call lsp_cxx_hl#hl#clear()
endfunction

" Notify of new semantic highlighting symbols
function! lsp_cxx_hl#hl#notify_symbols(bufnr, symbols) abort
    if get(b:, 'lsp_cxx_hl_disabled', 0)
        call lsp_cxx_hl#hl#clear()
    else
        call lsp_cxx_hl#textprop_nvim#symbols#notify(a:bufnr, a:symbols)
    endif
endfunction

" Notify of new preprocessor skipped regions
function! lsp_cxx_hl#hl#notify_skipped(bufnr, skipped) abort
    if get(b:, 'lsp_cxx_hl_disabled', 0)
        call lsp_cxx_hl#hl#clear()
    else
        call lsp_cxx_hl#textprop_nvim#skipped#notify(a:bufnr, a:skipped)
    endif
endfunction
