" Use Vim not vi
set nocompatible

" The default leader is '\', but many people prefer ',' as it's in a standard location
let mapleader = ','

augroup generalAutoCommands
  autocmd!

  " Reload vimrc if there are any changes.
  " autocmd bufwritepost .vimrc source $MYVIMRC

  " Automatically Save/Load Fold states
  " autocmd BufWinLeave * silent! mkview
  " autocmd BufWinEnter * silent! loadview

  " Trailing Whitespace Autofix
  autocmd BufWritePre *.{rb,py,js,php,html,xml,css,less} StripWhitespace

  " Spellcheck for Git Commit messages
  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitcommit setlocal spelllang=en

  " Deletes swapfiles for unmodified buffers -- Provided by #vim, source from tpope
  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave * if !$VIMSWAP && isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
augroup END

" VimUI {
  " Set my color scheme
  syntax on
  set background=dark
  " colorscheme ir_black                      " Make sure ir_black is in ~/.vim
  colorscheme jellybeans                      " Make sure jellybeans is in ~/.vim

  set guifont=Inconsolata\ for\ Powerline:h14 " Set Default Font ( Font included as a plugin, make sure to install into System )

  " Indent Settings {
    set tabstop=2 shiftwidth=2 expandtab      " Make my tabs be 2 spaces **BE CAREFUL WITH THIS SETTING**
    set softtabstop=2                         " Let backspace delete indent
    set autoindent                            " Indent at the same level of the previous line
    set copyindent                            " Copy the indentation of the previous line if auto indent doesn't know what to do
  " }

  " Line Numbers {
    " Setting both of these in order enables a Hybrid Line Number mode
    set relativenumber                        " Relative Line Numbers
    set number                                " Normal Line Numbers
  " } Hybrid Mode only works in Vim 7.4+

  " Margin and Wrapping settings {
    set wrap                                  " Enable wrapping
    set whichwrap=b,s,h,l,<,>,[,]             " Backspace and cursor keys wrap too
    set linebreak                             " Only Visually wrap lines at the breakat option
    " set breakindent                           " Wrap long lines at the same indent level ( Only available in Version 7.4.338~354+ / MacVim 7.4-Snapshot 74 )
    set nolist                                " list disables linebreak
    set textwidth=0                           " Prevent Vim from adding linebreaks for long lines
    set wrapmargin=0                          " Prevent Vim from adding linebreaks for long lines
    set scrolloff=6                           " Minimum lines to keep above and below cursor
    set sidescrolloff=15                      " Minimum lines to keep left and right of the cursor
    set sidescroll=1
  " }

  " Search Settings {
    set hlsearch                              " Highlight search terms
    set incsearch                             " Find as you type search
    set ignorecase                            " Ignore case when searching
    set smartcase                             " ...unless there's a capital letter in the query
  " }

  " General Settings {
    set cursorline                            " Highlight cursor line
    set showmatch                             " Show matching brackets/parenthesis
    set wildmenu                              " Show list instead of just completing
    set wildmode=list:longest,full            " Command <Tab> completion, list matches, then longest common part, then all.
    set foldenable                            " Auto fold code
    set hidden                                " Dont unload buffer when it is abandoned
    set visualbell                            " Use a Visual Bell instead of an audible one
    set undolevels=1000                       " More undos
    set title                                 " Vim can set the title of the terminal window
    set t_Co=256                              " Tell vim that your terminal supports 256 colors
  " }

  let &showbreak='↪ '                         "  String to put at the start of lines that have been wrapped

  " General Mappings {
    " Easy Split Window Pane Navigation
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Map to change the working directory to the same directory of the current file
    nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

    " Map to remove highlighted search terms
    nnoremap <leader>l :noh<CR><C-l>
    nnoremap <space> :noh<CR><C-l>

    " Change the Shift+k function to something more useful: The opposite of doing Shift+j
    nnoremap K i<CR><Esc>^

    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :

    " Stupid shift key fixes
    cnoreabbrev W w
    cnoreabbrev WQ wq
    cnoreabbrev wQ wq
    cnoreabbrev Q q
    cnoremap Tabe tabe

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Highlight last pasted text in visual mode
    nnoremap gp `[v`]

    " Make a new Tab with the current buffer ( Similar to :vs and :split )
    nnoremap <Leader>t :tabe %<CR>

    " Edit or Reload vimrc on the fly
    nnoremap <leader>ve :tabedit $MYVIMRC<CR>
    nnoremap <leader>vr :source $MYVIMRC<CR>:echo "Reloaded."<cr>

    " Quickly Debug Vim within a log
    nnoremap <leader>LL :profile start vim.log<CR> :profile func *<CR> :profile file *<CR> :echo "Ready to debug..."<CR>
    nnoremap <leader>LS :profile pause<CR> :echo "Debugging Paused, Quit Vim to Generate Log." <CR>

    " For when you forget sudo.. Really Write the file.
    cnoremap w!! w !sudo tee % >/dev/null

    " Auto indent entire file and :retab
    nnoremap <leader>= :call Preserve("normal gg=G")<CR>

    " Quick Bash command (that also uses the login_shell and its profiles and aliases
    nnoremap !! :Bash 

    " Commands & Functions {
      " Convert Tabs to Spaces
      :command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

      " Use bash command as if it were invoked by the login shell
      " This allows aliases and functions from .bashrc/.bash_profile/.profile to be used
      :command! -nargs=* Bash !bash -c -l "<args>"

      function! Preserve(command)
        " Use this function to go back to the starting position of the cursor
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        execute a:command
        " Clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
      endfunction
    " }
  " }

  " Saved Macros {
    " Take a line and add all browser css prefixes to it e.g.: -webkit-
    let @b = 'qzq"zyy"zPI-webkit-"zPI-moz-"zPi-ms-"zPi-o-^4jqzq'
  " }

  " GUI Specifc {
    if has("gui_running")
      " Removing the toolbar
      set guioptions=egmrt

      " normal mode mappings
      nnoremap <silent> <D-j> :call SwapWithNext()<CR>
      nnoremap <silent> <D-k> :call SwapWithPrevious()<CR>

      " Set Default Window Size
      set lines=80 columns=200

      " MacVim Specifc {
      if has("gui_macvim")
        "Set my transparency
        set transparency=10
      endif
      " }
    endif
  " }
" }

" Setting up vim-plug - the vim plugin bundler
" If vim-plug doesn't exist, download it.
if empty( glob('~/.vim/autoload/plug.vim') )
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Begin vim-plug!
call plug#begin('~/.vim/bundle')

" Plugins, Bundles, Mappings, Settings, etc... {
  " File Navigation {
    " CtrlP {
      " Fuzzy Finding File Navigator
      Plug 'kien/ctrlp.vim'

      " Invoke CtrlP File Finder and Flush mapping
      nnoremap <leader>f :CtrlP<cr>

      " Invoke CtrlP Buffer Finder
      nnoremap <leader>b :CtrlPBuffer<cr>

      " CtrlP relative working path
      let g:ctrlp_working_path_mode = 'ra'

      " Exclude files or directories using CtrlP's own g:ctrlp_custom_ignore
      let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
        \ 'file': '\v\.(exe|so|dll|swp|DS_Store|zip|png|jpg|pdf|gif)$',
        \ 'link': 'some_bad_symbolic_links',
      \ }
    " }

    " NerdTree {
      " Fast File/Directory Navigation
      Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

      "noremap <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
      nnoremap <leader>e :NERDTreeToggle<CR>
      nnoremap <leader>nt :NERDTreeFind<CR>

      let NERDTreeShowBookmarks=1
      let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
      let NERDTreeChDirMode=0
      let NERDTreeQuitOnOpen=1
      let NERDTreeShowHidden=1
      let NERDTreeKeepTreeInNewTab=1
    " }
  " }

  " Utilities {
    " Fugitive (Git) {
      " Vim Git Wrapper
      Plug 'tpope/vim-fugitive'

      augroup fugitiveAutoCommands
        autocmd!

        " Auto-delete vim buffers when browsing git object history using Fugitive
        autocmd BufReadPost fugitive://* set bufhidden=delete

        " Fancy Status Line using git branch
        autocmd user Fugitive set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
      augroup END

      " Mappings for most used commands
      nnoremap <leader>gs :Gstatus<CR>
      nnoremap <leader>gc :Gcommit<CR>
      nnoremap <leader>gC :Gcommit -S<CR>
      nnoremap <leader>gd :Gdiff<CR>
      nnoremap <leader>dg :diffget<CR>
      nnoremap <leader>dp :diffput<CR>
    " }

    " vim-gitgutter {
      " Provides easy Git Diff patching within a document
      Plug 'airblade/vim-gitgutter'
    " }

    " YouCompleteMe {
      " Auto/Omni Completion
      Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
    " }

    " Ultisnips {
      " Easily accessible, configurable and reusable snippets of code.
      " Track the engine.
      Plug 'SirVer/ultisnips'

      " Snippets are separated from the engine.
      " Add default snippets.
      Plug 'honza/vim-snippets'

      " Add additional use-case snippets
      Plug 'bonsaiben/bootstrap-snippets'

      " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
      let g:UltiSnipsExpandTrigger = '<c-l>'
      let g:UltiSnipsJumpForwardTrigger = '<c-j>'
      let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
      let g:UltiSnipsListSnippets = '<c-tab>'

      " If you want :UltiSnipsEdit to split your window.
      let g:UltiSnipsEditSplit="vertical"
    " }

    " vim-multiple-cursors {
      " Sublime-Style Multiple Cursors

      " Plug 'terryma/vim-multiple-cursors'

      " Using maintained fork of original repo
      Plug 'kristijanhusak/vim-multiple-cursors'

      " Set default modal exit key
      " let g:multi_cursor_quit_key = '<Esc>'

      " pressing g:multi_cursor_quit_key in Visual mode will not quit and delete all existing cursors
      let g:multi_cursor_exit_from_visual_mode = 0

      " pressing g:multi_cursor_quit_key in Insert mode will not quit and delete all existing cursors
      let g:multi_cursor_exit_from_insert_mode = 0

      " Quickly enter RegExp mode
      xnoremap <leader>n :MultipleCursorsFind
      nnoremap <leader>n V:MultipleCursorsFind
    " }

    " vim-easy-align {
      " Text filtering and alignment
      Plug 'junegunn/vim-easy-align'

      " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
      vmap <Enter> <Plug>(EasyAlign)

      " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
      nmap <Leader>a <Plug>(EasyAlign)
    " }

    " LargeFile {
      " Edit large files quickly ( default: 100mb files )
      Plug 'vim-scripts/LargeFile'
    " }

    " vim-better-whitespace {
      " Better whitespace highlighting and stripping for Vim
      Plug 'ntpeters/vim-better-whitespace'

      augroup vimBetterWhitespaceAutoCommands
        autocmd!

        " Use Syntax Based highlighting to reduce performance hit
        autocmd VimEnter * silent! CurrentLineWhitespaceOff soft
      augroup END

      " Define custom highlight color ( Based on 'DiffDelete' color group in :highlight list )
      highlight ExtraWhitespace term=bold ctermfg=16 ctermbg=52 guifg=#40000A guibg=#700009

      " Strip Trailing Whitespace
      nnoremap <leader>$ :StripWhitespace<CR>
      xnoremap <leader>$ :StripWhitespace<CR>
    " }
  " }

  " Plugs that extend basic Vim functions {
    " Repeat.vim {
      " Use . repeat command that works with plugins
      Plug 'tpope/vim-repeat'
    " }

    " Abolish {
      " Advanced Search and Replace, 'Subvert'
      Plug 'tpope/vim-abolish'
    " }

    " vim-indent-object {
      " Text-Object for indented blocks
      Plug 'michaeljsmith/vim-indent-object'
    " }

    " targets.vim {
      " Gives additional text objects and allows you to manipulate said objects in a
      " way that makes sense within their context's.
      Plug 'wellle/targets.vim'

      " Mappings do not work if they are non-recursive
      nmap "" cI"
      nmap '' cI'
    " }

    " vim-unimpaired {
      " Provides many key bindings and functions for vim
      Plug 'tpope/vim-unimpaired'


      " Mappings do not work if they are non-recursive
      " Paste System Clipboard on a new line and Indent Pasted text
      nmap <leader>p "+=p
      nmap <leader>P "+=P
      xmap <leader>p d"+=P
      xmap <leader>P d"+=P
    " }

    " vim-commentary {
      " Comment stuff out with a single command for many languages plus extendability "
      Plug 'tpope/vim-commentary'
    " }

    " vim-over {
      " Search & Replace preview
      Plug 'osyo-manga/vim-over'

      nnoremap <leader>s :OverCommandLine<CR>s/
      nnoremap <leader>S :OverCommandLine<CR>%s/
      xnoremap <leader>s :OverCommandLine<CR>s/
    " }

    " vim-sneak {
      " The missing motion for Vim
      Plug 'justinmk/vim-sneak'

      " Mappings do not work if they are non-recursive

      " Remap Next and Previous since ; and , are already used
      nmap <Tab> <Plug>SneakNext
      xmap <Tab> <Plug>VSneakNext
      nmap <S-Tab> <Plug>SneakPrevious
      xmap <S-Tab> <Plug>VSneakPrevious

      " Replace 'f' with inclusive 1-char Sneak
      nmap f <Plug>Sneak_f
      nmap F <Plug>Sneak_F
      xmap f <Plug>Sneak_f
      xmap F <Plug>Sneak_F
      omap f <Plug>Sneak_f
      omap F <Plug>Sneak_F

      " Replace 't' with exclusive 1-char Sneak
      nmap t <Plug>Sneak_t
      nmap T <Plug>Sneak_T
      xmap t <Plug>Sneak_t
      xmap T <Plug>Sneak_T
      omap t <Plug>Sneak_t
      omap T <Plug>Sneak_T
    " }

    " splitjoin.vim {
      " A vim plugin that simplifies the transition between multiline and single-line code
      Plug 'AndrewRadev/splitjoin.vim'
    " }

    " vim-grep-operator {
      " Bring motion and visual selection to the :grep command
      Plug 'inside/vim-grep-operator'

      " Use Git's grep instead
      set grepprg=git\ grep\ -n\ $*

      " Suggested mappings
      nmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
      vmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
      nmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
      vmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
    " }

    " vim-signature {
      " A plugin to place, toggle and display marks.
      Plug 'kshenoy/vim-signature'
    " }
  " }

  " Syntax Helpers {
    " Matchem {
      " Fixes Edge-Case delimitMate problems
      Plug 'ervandew/matchem'

      " Delimitmate {
      " autocmd FileType * let b:delimitMate_autoclose = 1

      " If using html auto complete (complete closing tag)
      " autocmd FileType xml,html,xhtml let b:delimitMate_matchpairs = \"(:),[:],{:}"
      " }
    " }

    " Surround {
      " Dynamic Custom Surround ability
      Plug 'tpope/vim-surround'

      " CSS style commenting ( 99 ASCII for 'c' ) e.g.: yssc
      let g:surround_99 = "/* \r */"

      augroup surroundAutoCommands
        autocmd!

        " PHP {
          " Enable PHP tag Surrounds ( 112 ASCII for 'p' ) e.g.: yssp
          autocmd FileType php let b:surround_112 = "<?php \r ?>"

          " Enable easy PHP var_dump() ( 108 ASCII for 'l' ) e.g.: yssl
          autocmd FileType php let b:surround_108 = "var_dump( \r );"
        " }

        " JS {
          " Enable easy JS console.log() ( 108 ASCII for 'l' ) e.g.: yssl
          autocmd FileType javascript let b:surround_108 = "console.log( \r );"
        " }
      augroup END

      " Surround Specifc Mappings {
        " Add spaces inside () quickly
        nmap <Space><Space> vi(S<Space><Space>
      " }
    " }

    " Syntastic {
      " Syntax Checking
      Plug 'scrooloose/syntastic'
    " }

    " HTML-AutoCloseTag {
      " Auto-Close HTML Tags
      Plug 'vim-scripts/HTML-AutoCloseTag'

      augroup htmlAutoCloseTagsAutoCommands
        autocmd!

        " Make it so AutoCloseTag works for xml and xhtml files as well
        autocmd FileType xhtml,xml,php so ~/.vim/bundle/HTML-AutoCloseTag/ftplugin/html_autoclosetag.vim
      augroup END
    " }
  " }

  " Aesthetic Plugs {
    " Colour Schemes {
      " LESS {
        Plug 'groenewege/vim-less'
      " }
    " }

    " vim-search-pulse {
      " This plugin will 'pulse' the cursor line (by default) or the search pattern thus requiring your eyes attention.
      Plug 'inside/vim-search-pulse'

      " Set the pulse mode ( cursor_line / pattern )
      let g:vim_search_pulse_mode = 'cursor_line'

      " Set animation/pulse speed
      let g:vim_search_pulse_duration = 100

      " Enable plugin
      set cursorline
    " }

    " vim-indent-guides {
      " Shows semi-opaque markings to indicate indent levels
      Plug 'nathanaelkane/vim-indent-guides'

      let g:indent_guides_start_level = 2
      let g:indent_guides_guide_size = 1

      augroup indentGuidesAutoCommands
        autocmd!

        " Enable Indent Guides when opening a file
        autocmd VimEnter * IndentGuidesEnable
      augroup END
    " }

    " vim-airline {
      " Pretty looking Status Line
      Plug 'bling/vim-airline'

      if has("gui_running")
        let g:airline_powerline_fonts = 1
        set laststatus=2 " Always display the statusline in all windows
        set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
      endif

      " Enable Smarter Tab Line
      let g:airline#extensions#tabline#enabled = 1
    " }

    " promptline.vim {
      " Consistent colorscheme for Vim and bash/zsh shell based on airline
      " themes and powerline fonts
      Plug 'edkolev/promptline.vim'
    " }
  " }

  " Extras {
    " Powerline pre-patched Fonts {
      " Special Glyphs for pretty powerline status line
      Plug 'Lokaltog/powerline-fonts'
    " }
  " }
" }

" vim-plug is done!
call plug#end()
