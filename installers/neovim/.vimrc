"===============================================================================
" Auto install plugin(dein plugin manager config)
"===============================================================================
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" If dein.vim does not exist, vim download dein automatically.
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " External config file for plugin.
  let  g:rc_dir    = expand('~/.config/nvim/.')
  let  s:toml      = g:rc_dir . '/dein.toml'
  let  s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

" If dein didn't install plugin described in the dein.toml,
" dein install them
if dein#check_install()
  call dein#install()
endif

"===============================================================================
" Vim common Setting.
"===============================================================================
set number         " show line number
set title          " show path info at terminal's title
set expandtab      " replace tab input with space
set tabstop=4      " tab input = (space * 4)
set smartindent    " insert indent(when you start a new line)
set autoindent     " continuation of the indent
set history=100    " hisory size(command & search)
set pumheight=5    " preview windows's height
set showmatch      " show match "(" or ")"
set shiftwidth=4   " auto indent width
set tags=./tags;
set wildmenu       " show inputting command
set hlsearch       " highlight searching result
set ruler          " show ruler
syntax on          " coloring depending on syntax
hi Comment ctermfg=Green " comment color is green
set expandtab      " replace tab input with space
set laststatus=2   " the status bar at the bottom of the terminal
set noshowmode     " delete mode(e.g. '-- INSERT --') at the bottom
set colorcolumn=80 " draw(color) a line at the 80th character
execute "set colorcolumn=" . join(range(81, 9999), ',')
set incsearch      " search per one character
set termguicolors  " use True Color on terminal
set t_Co=256       " use 256 color on terminal
set nocompatible   " make it incompatible with vi editor.
set backspace=indent,eol,start  " enable backspace
set encoding=utf-8     " encoding when loading files
scriptencoding utf-8   " multibyte setting in vim script
set fileencoding=utf-8 " encoding when saving files
set ambiwidth=double   " charachter width
" automatic chara-code recognition at reading
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac " automatic recognition of line feed code.
set ambiwidth=double         " Character collapse prevention
set nf=alpha                 " Increment / decrement of alphabet
set hidden                   " A buffer becomes hidden when it is abandoned

"===============================================================================
" Key mapping setting using Leader.
" I leave comments on the settings using Leader at other lines.
"===============================================================================
let mapleader = "\<Space>"
nnoremap <Leader>w        :w<CR>
nnoremap <Leader>wq       :wq<CR>
nnoremap <Leader>q        :q<CR>
"nnoremap <Leader>c       :tablast <bar> tabnew<CR>
"nnoremap <Leader><Right> :tabnext<CR>
"nnoremap <Leader><Left>  :tabprevious<CR>
"nnoremap <Leader>g       :Ack<Space>

"===============================================================================
" Setting for cursor highlight setting(not plugin setting)
"===============================================================================
" When staying on the same line for several seconds, highlight that line
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

"===============================================================================
" Key bind setting(this setteing are default vim feature).
"===============================================================================
nnoremap <C-h>     :vsp<CR>
nnoremap <C-k>     :split<CR>
nnoremap +         <C-a>
nnoremap -         <C-x>
inoremap <C-Right> <Esc>$
inoremap <C-Left>  <Esc>^
noremap  <C-Right> <Esc>$
noremap  <C-Left>  <Esc>^

"===============================================================================
" Setting for airline tabline plugin.
"===============================================================================
colorscheme jellybeans
let g:airline_theme                           = 'powerlineish'
let g:airline#extensions#tabline#enabled      = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type  = 1
let g:airline#extensions#tabline#fnamemod     = ':t'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

"===============================================================================
" Setting for Markdown and HTML.
"===============================================================================
filetype plugin indent on
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
let g:previm_open_cmd = ''
command! OpenBrowserCurrent execute "OpenBrowser" expand("%:p")
nnoremap <F2> :OpenBrowserCurrent<CR>
nnoremap <F3> :PrevimOpen<CR>

"===============================================================================
" Jedi(python) Vim setting.
"===============================================================================
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 1

nnoremap [jedi] <Nop>
xnoremap [jedi] <Nop>
nmap <Leader>j [jedi]
xmap <Leader>j [jedi]

let g:jedi#completions_command      = "<C-Space>"
let g:jedi#goto_assignments_command = "<C-g>"
let g:jedi#goto_definitions_command = "<C-d>"
let g:jedi#documentation_command    = "<C-k>"
let g:jedi#rename_command           = "[jedi]r"
let g:jedi#usages_command           = "[jedi]n"
let g:jedi#popup_select_first       = 0
let g:jedi#popup_on_dot             = 0

autocmd FileType python setlocal completeopt-=preview
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled    = 0
let g:jedi#auto_vim_configuration = 0

"===============================================================================
" Indent guide setting
"===============================================================================
let g:indent_guides_enable_on_vim_startup = 1

"===============================================================================
" Auto completion setting for lexima.vim
"===============================================================================
let g:lexima_no_default_rules = 1
call lexima#set_default_rules()

function! s:set_lexima(rule)
    call lexima#add_rule(a:rule)
    let ignore_rule = a:rule
    let ignore_rule.syntax = ["String", "Comment"]
    let ignore_rule.input = ignore_rule.char
    call lexima#add_rule(ignore_rule)
endfunction

call s:set_lexima({'at': '\%#',     'char': '[',    'input': '[]<Left>'})
call s:set_lexima({'at': '\%#]',    'char': '[',    'input': '['})
call s:set_lexima({'at': '\[\%#\]', 'char': ']',    'input': '<Right>'})
call s:set_lexima({'at': '\[\%#\]', 'char': '[',    'input': '[]<Left>'})
call s:set_lexima({'at': '\[\%#\]', 'char': '<BS>', 'input': '<BS><Del>'})

for [begin, end] in [['(', ')'], ['{', '}']]
    let bracket = begin.end
    call s:set_lexima({'at': '\%#',     'char': begin, 'input': bracket.'<Left>'})
    call s:set_lexima({'at': '\%#'.end, 'char': begin, 'input': begin})

    call s:set_lexima({'at': begin.'\%#'.end, 'char': end,   'input': '<Right>'})
    call s:set_lexima({'at': begin.'\%#'.end, 'char': begin, 'input': bracket.'<Left>'})
    call s:set_lexima({'at': begin.'\%#'.end, 'char': '<BS>', 'input': '<BS><Del>'})
endfor

"===============================================================================
" vim -b : If open binary, vim change binary into xxd-format
"===============================================================================
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

"===============================================================================
" tagbar(ctags) plugin setting
"===============================================================================
nmap <C-t> :TagbarToggle<CR>

"===============================================================================
"  NERDTree(show directory tree) plugin setting
"===============================================================================
" map <C-d> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
map <C-d> <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=0
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"===============================================================================
" Paste setting(Indentation does not collapse when pasting).
"===============================================================================
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

"===============================================================================
" Setting for vim-anzu plugin.
"===============================================================================
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" statusline
set statusline=%{anzu#search_status()}

"===============================================================================
" Setting for vim-operator-flashy plugin.
"===============================================================================
map  y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

"===============================================================================
" Tab page Setting.
"===============================================================================
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " always show tab line.

" The prefix key for tab.
nnoremap    [Tag]   <Nop>
nmap        t [Tag]
" Tab jump. If you input t[1-9] in normal mode, change tab page to t[1-9].
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" Create tab page.
map <silent> [Tag]c :tablast <bar> tabnew<CR>
nnoremap <Leader>c  :tablast <bar> tabnew<CR>
" Create tab page and execute terminal(bash).
map <silent> [Tag]t :tablast <bar> tabnew<bar>:terminal<CR>
" Close tab page.
map <silent> [Tag]x :tabclose<CR>
" jump next tab(e.g. t1 -> t2)
nnoremap [Tag]n          :tabnext<CR>
nnoremap <Leader><Right> :tabnext<CR>
" jump previous tab(e.g. t2 -> t1)
nnoremap [Tag]b          :tabprevious<CR>
nnoremap <Leader><Left>  :tabprevious<CR>

"===============================================================================
" Window resize setting.
"===============================================================================
let g:winresizer_start_key = '<C-r>'

"===============================================================================
" GNU global command setting
"===============================================================================
let Gtags_Auto_Map = 0
map <C-f> :Gtags -f %<CR>      " show function & macro definition
map <C-k> :Gtags -r<Space>
map <C-j> :GtagsCursor<CR>     " jump function & macro definition
map <C-n> :cn<CR>              " show next definition
map <C-p> :cp<CR>              " show previous definition

"===============================================================================
" Setting for ALE(syntax check) plugin
"===============================================================================
" Always display the warning symbol displayed on the left side
let g:ale_sign_column_always = 1
" Setting for Error mark and Warning mark
let g:ale_sign_error   = '⨉'
let g:ale_sign_warning = '>>'
let g:lightline = {
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['readonly', 'filename', 'modified', 'ale'],
  \  ]
  \},
  \'component_function': {
  \  'ale': 'ALEGetStatusLine'
  \}
  \ }

"===============================================================================
" Setting for vim-trailing-whitespace plugin
"===============================================================================
" Delete whitespace at end of line
noremap <C-@> :FixWhitespace<CR>

"===============================================================================
" Setting for vim-shiny plugin
"===============================================================================
nmap p  <Plug>(shiny-p)
nmap P  <Plug>(shiny-P)
nmap gp <Plug>(shiny-gp)
nmap gP <Plug>(shiny-gP)

"===============================================================================
" Setting for vim-edgemotion plugin
"===============================================================================
map <C-Up>   <Plug>(edgemotion-k)
map <C-Down> <Plug>(edgemotion-j)

"===============================================================================
" Setting for quickrun(and vimproc) plugin
"===============================================================================
let g:quickrun_config = {
\   "_" : {
\       "runner"                          : 'vimproc',
\       "runner/vimproc/updatetime"       : 40,
\       "outputter"                       : 'error',
\       "outputter/error/success"         : 'buffer',
\       "outputter/error/error"           : 'quickfix',
\       "outputter/buffer/split"          : ':botright 8sp',
\       "outputter/buffer/close_on_empty" : 1
\   },
\}

let g:quickrun_no_default_key_mappings = 1
"  run quick run after saving
map <F5> :QuickRun -mode n<CR>
" q key close quickfix
nnoremap q     :<C-u>bw! \[quickrun\ output\]<CR>
" <C-c> stop quickrun
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

function! Execcmd(cmd)
        let l:proc = vimproc#popen2(a:cmd)
        let l:response = ''
        while !l:proc.stdout.eof
                let l:response .= l:proc.stdout.read()
        endwhile
        return l:response
endfunction
autocmd BufRead,BufNewFile *.java map <F7> :echo Execcmd('gradle build')<CR>
autocmd BufRead,BufNewFile *.c    map <F7> :echo Execcmd('make -j4')<CR>
autocmd BufRead,BufNewFile *.rs   map <F7> :echo Execcmd('cargo build')<CR>


"===============================================================================
" Setting for vim-parenmatch plugin
"===============================================================================
" disable default matchparen
let g:loaded_matchparen = 1

"===============================================================================
" Setting for vim-easy-align plugin
"===============================================================================
vmap <Enter> <Plug>(EasyAlign)=<CR>

"===============================================================================
" Setting for agit plugin
"===============================================================================
noremap <C-l> :Agit<CR>

"===============================================================================
" Setting for committia plugin
"===============================================================================
" You can get the information about the windows with first argument as a dictionary.
"
"   KEY              VALUE                      AVAILABILITY
"-----------------------------------------------------------------------------------
"   vcs            : vcs type (e.g. 'git')   -> all hooks
"   edit_winnr     : winnr of edit window    -> ditto
"   edit_bufnr     : bufnr of edit window    -> ditto
"   diff_winnr     : winnr of diff window    -> ditto
"   diff_bufnr     : bufnr of diff window    -> ditto
"   status_winnr   : winnr of status window  -> all hooks except for 'diff_open' hook
"   status_bufnr   : bufnr of status window  -> ditto
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Pl
endfunction

"===============================================================================
" Setting for ack plugin. Ack is fast grep command.
"===============================================================================
let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <Leader>g :Ack<Space>

"===============================================================================
" Setting for devicon(Font) plugin.
"===============================================================================
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

"===============================================================================
" Setting for Java plugin.
"===============================================================================
let java_highlight_functions = 1
autocmd FileType java :colorscheme monokain

"===============================================================================
" Setting for deoplete
"===============================================================================
let g:deoplete#enable_at_startup = 1
inoremap <expr><Tab> pumvisible() ? "\<DOWN>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<UP>" : "\<S-Tab>"
"inoremap <expr><CR> pumvisible() ? deoplete#close_popup() : "<CR>"

"===============================================================================
" Setting for vim racer plugin
"===============================================================================
let g:racer_cmd = "~/.cargo/bin/racer"
let g:rustfmt_command = '~/.cargo/bin/rustfmt'
let $RUST_SRC_PATH = '~/.cargo/registry/src/github.com-1ecc6299db9ec823/'
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
au FileType rust nmap <leader>d <Plug>(rust-def)
au FileType rust nmap <leader>s <Plug>(rust-def-split)
au FileType rust nmap <leader>x <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

"===============================================================================
" Setting for vim-closetag plugin
"===============================================================================
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.php,*.vue'
