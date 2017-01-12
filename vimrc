" Use Vim not vi
set nocompatible

" The default leader is '\', but many people prefer ',' as it's in a standard location
let g:mapleader = "\<Space>"                  " Use the <Space> key as leader, key size is reachable from anywhere and its default function is not very useful

" Define a group 'vimrc' to be used for all auto commands and initialize.
augroup vimrc
  autocmd!
augroup END

" Automatically Save/Load Fold states
" autocmd vimrc BufWinLeave * silent! mkview
" autocmd vimrc BufWinEnter * silent! loadview

" Spellcheck for Git Commit messages
autocmd vimrc FileType gitcommit setlocal spell
autocmd vimrc FileType gitcommit setlocal spelllang=en

" Deletes swapfiles for unmodified buffers -- Provided by tpope from #vim
autocmd vimrc CursorHold,BufWritePost,BufReadPost,BufLeave * if !$VIMSWAP && isdirectory(expand("<aMatch>:h")) | let &swapfile = &modified | endif

" VimUI {
  " Set my color scheme
  syntax on
  set background=dark
  colorscheme atom-dark                         " Make sure any custom colorschemes are in ~/.vim/colors ( jellybeans, ir_black, atom-dark and molokai )

  set guifont=Inconsolata\ for\ Powerline:h14   " Set Default Font ( Font included as a plugin, make sure to install into System )

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
    set breakindent                           " Wrap long lines at the same indent level ( Only available in Version 7.4.338~354+ / MacVim 7.4-Snapshot 74 )
    set nolist                                " list disables linebreak
    set textwidth=0                           " Prevent Vim from adding linebreaks for long lines
    set wrapmargin=0                          " Prevent Vim from adding linebreaks for long lines
    set scrolloff=6                           " Minimum lines to keep above and below cursor
    set sidescrolloff=15                      " Minimum lines to keep left and right of the cursor
    set sidescroll=1
    let &showbreak='↪ '                         " String to put at the start of lines that have been wrapped
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

  " Fuzzy Finding Files {
    " TODO: Search for nice implementation of vim-only finding, perhaps using fuzzy pathing
  " }

  " General Mappings {
    " Easy Split Window Pane Navigation
    nnoremap <C-h> <C-w>h
    nnoremap <Left> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <Down> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <Up> <C-w>k
    nnoremap <C-l> <C-w>l
    nnoremap <Right> <C-w>l

    " Move visual block
    " Source: https://vimrcfu.com/snippet/77
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv

    " Change the Shift+k function to something more useful: The opposite of doing Shift+j
    nnoremap K i<CR><Esc>^

    " Map to change the working directory to the same directory of the current file
    nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

    " Map to remove highlighted search terms
    nnoremap <Leader>l :noh<CR><C-l>
    nnoremap <Leader><Space> :noh<CR><C-l>

    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :

    " Stupid shift key fixes
    cnoreabbrev W w
    cnoreabbrev WQ wq
    cnoreabbrev wQ wq
    cnoreabbrev Q q
    cnoremap Tabe tabe

    " Make Ctrl-e jump to the end of the current line in the insert mode. This is
    " handy when you are in the middle of a line and would like to go to its end
    " without switching to the normal mode.
    inoremap <C-e> <C-o>$

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Yank without Jank
    " Source: http://ddrscott.github.io/blog/2016/yank-without-jank/
    vnoremap <expr>y "my\"" . v:register . "y`y"
    vnoremap <expr>Y "my\"" . v:register . "y`y"

    " Move up and down visually, not linewise. Useful for wrapped lines.
    " Extra logic to keep 5k or 3j functionality using relative numbers.
    " Sources: http://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/
    " http://stackoverflow.com/a/21000307/185731
    noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
    noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

    " Highlight last pasted text in visual mode
    nnoremap gp `[v`]

    " Stay in visual mode when indenting. You will never have to run gv after
    " performing an indentation.
    vnoremap < <gv
    vnoremap > >gv

    " Go to last yank marker
    nnoremap gy 'y

    " Make a new Tab with the current buffer ( Similar to :vs and :split )
    nnoremap <Leader>t :tabe %<CR>

    " Follow current file's symlink to edit the source file instead
    nnoremap <Leader>L :<C-u>execute 'file '.fnameescape(resolve(expand('%:p')))<Bar>
      \ call fugitive#detect(fnameescape(expand('%:p:h')))<CR>:AirlineRefresh<CR>
      \ :echo "Followed Symlink to: '<C-r>=expand('%:p')<CR>'"<CR>

    " Edit or Reload vimrc on the fly
    nnoremap <Leader>ve :tabedit <C-r>=resolve($MYVIMRC)<CR><CR>
    nnoremap <Leader>vr :source <C-r>=resolve($MYVIMRC)<CR><CR>:echo "Reloaded."<CR>

    " Quickly Debug Vim within a log
    nnoremap <Leader>LL :profile start vim.log<CR> :profile func *<CR> :profile file *<CR> :echo "Ready to debug..."<CR>
    nnoremap <Leader>LS :profile pause<CR> :echo "Debugging Paused, Quit Vim to Generate Log." <CR>

    " For when you forget sudo.. Really Write the file.
    cnoremap w!! w !sudo tee % >/dev/null

    " Auto indent entire file and :retab
    nnoremap <Leader>= :exec "normal! gg=G"<CR>

    " Quick Bash command (that also uses the login_shell and its profiles and aliases
    nnoremap !! :Bash 

    " Commands & Functions {
      " Convert Tabs to Spaces
      :command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

      " Use bash command as if it were invoked by the login shell
      " This allows aliases and functions from .bashrc/.bash_profile/.profile to be used
      :command! -nargs=* Bash !bash -c -l "<Args>"

      " Allow the ability to execute a Macro over a Visual Line Range
      " Source: https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
      xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

      function! ExecuteMacroOverVisualRange()
        echo "@".getcmdline()
        execute ":'<,'>normal @".nr2char(getchar())
      endfunction
    " }
  " }

  " GUI Specifc {
    if has("gui_running")
      " Removing the toolbar
      set guioptions=mrg

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
  autocmd vimrc VimEnter * PlugInstall
endif

" Begin vim-plug!
call plug#begin('~/.vim/bundle')

" Plugins, and their Mappings, Settings, etc... {
  " Utilities {
    " Git {
      " Fugitive {
        " Vim Git Wrapper
        Plug 'tpope/vim-fugitive'

        " Auto-delete vim buffers when browsing git object history using Fugitive
        autocmd vimrc BufReadPost fugitive://* set bufhidden=delete

        " Fancy Status Line using git branch
        autocmd vimrc User Fugitive set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

        " Mappings for most used commands
        nnoremap <Leader>gs :Gstatus<CR>
        nnoremap <Leader>gw :Gwrite<CR>
        nnoremap <Leader>gC :Gcommit<CR>
        nnoremap <Leader>gc :Gcommit -S<CR>
        nnoremap <Leader>gd :Gdiff<CR>
        nnoremap <Leader>gp :Gpush<CR>
        nnoremap <Leader>gP :Gpull<CR>
        nnoremap <Leader>dg :diffget<CR>
        nnoremap <Leader>dp :diffput<CR>
      " }

      " vim-gitgutter {
        " Provides easy Git Diff patching within a document
        Plug 'airblade/vim-gitgutter'
      " }
    " }

    " vim-signature {
      " A plugin to place, toggle and display marks.
      Plug 'kshenoy/vim-signature'
    " }

    " Ultisnips {
      " TODO: Get Ultisnips to work with VimCompletesMe like it worked with YCM
      " Easily accessible, configurable and reusable snippets of code.
      " Track the engine.
      Plug 'SirVer/ultisnips'

      " Snippets are separated from the engine.
      " Add default snippets.
      Plug 'honza/vim-snippets'

      " Add additional use-case snippets
      Plug 'bonsaiben/bootstrap-snippets'

      " Trigger configuration. Do not use <Tab> if you use https://github.com/Valloric/YouCompleteMe.
      let g:UltiSnipsExpandTrigger = '<C-l>'
      let g:UltiSnipsJumpForwardTrigger = '<C-j>'
      let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
      let g:UltiSnipsListSnippets = '<C-Tab>'
      let g:ulti_expand_or_jump_res = 0

      " Allow Enter to Expand a Snippet within YCM's autocomplete list
      " Source: https://github.com/Valloric/YouCompleteMe/issues/420#issuecomment-55940039
      function! ExpandSnippetOrCarriageReturn()
        let snippet = UltiSnips#ExpandSnippetOrJump()
        if g:ulti_expand_or_jump_res > 0
          return snippet
        else
          return "\<CR>"
        endif
      endfunction
      inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

      " If you want :UltiSnipsEdit to split your window.
      let g:UltiSnipsEditSplit="vertical"
    " }

    " vim-better-whitespace {
      " Better whitespace highlighting and stripping for Vim
      Plug 'ntpeters/vim-better-whitespace'

      " Use Syntax Based highlighting to reduce performance hit
      autocmd vimrc VimEnter * silent! CurrentLineWhitespaceOff soft

      " Trailing Whitespace Autofix
      autocmd vimrc BufWritePre *.{rb,py,js,php,html,xml,css,less} StripWhitespace

      " Define custom highlight color ( Based on 'DiffDelete' color group in :highlight list )
      highlight ExtraWhitespace term=bold ctermfg=16 ctermbg=52 guifg=#40000A guibg=#700009

      " Strip Trailing Whitespace
      nnoremap <Leader>$ :StripWhitespace<CR>
      xnoremap <Leader>$ :StripWhitespace<CR>
    " }

    " lion.vim {
      Plug 'tommcdo/vim-lion'
    " }
  " }

  " Plugs that extend basic Vim functions {
    " vim-unimpaired {
      " Provides many key bindings and functions for vim
      Plug 'tpope/vim-unimpaired'

      " Mappings do not work if they are non-recursive
      " Paste System Clipboard on a new line and Indent Pasted text
      nmap <Leader>p "+=p
      nmap <Leader>P "+=P
      xmap <Leader>p d"+=P
      xmap <Leader>P d"+=P
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

    " vim-gutentags {
      " A Vim plugin that manages your tag files
      "
      " DEPENDENCY: Exuberant Ctags
      " DESCRIPTION: Ctags generates an index (or tag) file of language objects found in source files that allows these items to be quickly and easily located by a text editor or other utility. A tag signifies a language object for which an index entry is available (or, alternatively, the index entry created for that object).
      " INSTALLATION: brew install ctags
      " SOURCE: http://ctags.sourceforge.net/

      Plug 'ludovicchabant/vim-gutentags'
    " }

    " splitjoin.vim {
      " A vim plugin that simplifies the transition between multiline and single-line code
      Plug 'AndrewRadev/splitjoin.vim'
    " }


    " vim-bbye {
      " Delete buffers and close files in Vim without closing your windows or messing up your layout.
      Plug 'moll/vim-bbye'
      nnoremap <Leader>bd :Bdelete<CR>
    " }

    " Repeat.vim {
      " Use . repeat command that works with plugins
      Plug 'tpope/vim-repeat'
    " }

    " Searching {
      " vim-over {
        " Search & Replace preview
        Plug 'osyo-manga/vim-over'

        nnoremap <Leader>s :OverCommandLine<CR>s/
        nnoremap <Leader>S :OverCommandLine<CR>%s/
        xnoremap <Leader>s :OverCommandLine<CR>s/
        nnoremap <Leader>/ :OverCommandLine<CR>/
      " }

      " incsearch.vim {
        " Similar to vim-over except for searching only
        Plug 'haya14busa/incsearch.vim'

        " Mappings do not work if they are non-recursive

        " Replace default mapping to use fancier search
        map /  <Plug>(incsearch-forward)
        map ?  <Plug>(incsearch-backward)
        map g/ <Plug>(incsearch-stay)
      " }

      " Abolish {
        " Advanced Search and Replace, 'Subvert'
        Plug 'tpope/vim-abolish'
      " }

      " ctrlsf.vim {
        " An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
        " DEPENDENCY: The Silver Searcher (Ag)
        " DESCRIPTION: A code-searching tool similar to ack, but faster. http://geoff.greer.fm/ag/
        " INSTALLATION: brew install the_silver_searcher
        " SOURCE: https://github.com/ggreer/the_silver_searcher#installing
        Plug 'dyng/ctrlsf.vim'

        " Use Project Directory as root by searching VCS directory (.git, .hg, etc.) 
        let g:ctrlsf_default_root = 'project'

        " Use CtrlSF RegEx Mode by default
        let g:ctrlsf_regex_pattern = 1

        " Mappings do not work if they are non-recursive
        nmap     <Leader>F <Plug>CtrlSFPrompt
        " nmap     <Leader>FF <Plug>CtrlSFCwordPath
        nmap     <Leader>FF <Plug>CtrlSFCwordExec
        " vmap     <Leader>F <Plug>CtrlSFVwordPath
        vmap     <Leader>F <Plug>CtrlSFVwordExec
        nmap     <Leader>Fp <Plug>CtrlSFPwordPath

        nnoremap <Leader>Fo :CtrlSFOpen<CR>
        nnoremap <Leader>Ft :CtrlSFToggle<CR>
      " }
    " }

    " Completion {
      " vim-mucomplete {
        " A super simple, super minimal, super light-weight tab completion plugin for Vim.
        " Chained completion that works the way you want!
        Plug 'lifepillar/vim-mucomplete'

        " Config shared by dza from #vim
        " set completeopt+=menu,menuone
        " both are recommended by mucomplete but menu,preview is already set
        " so leave out menu below;
        set completeopt+=menuone
        set completeopt-=preview

        " see :help shortmess TODO: customize this
        set shortmess+=c

        " add UltiSnips to chains
        let g:mucomplete#chains = {'vim': ['file', 'cmd', 'keyn'], 'default': ['file', 'omni', 'keyn', 'dict', 'ulti']}

        " toggle auto completion
        function! s:toggle_completeopt()
          if exists('#MUcompleteAuto')
            set completeopt+=noinsert,noselect
          else
            set completeopt-=noinsert,noselect
          endif
        endfunction

        command! MUcompleteAutoToggle call mucomplete#toggle_auto()
              \  | call <SID>toggle_completeopt()
        command! MUcompleteAutoOn     call mucomplete#enable_auto()
              \  | call <SID>toggle_completeopt()
        command! MUcompleteAutoOff    call mucomplete#disable_auto()
              \  | call <SID>toggle_completeopt()

        " make right/left switch completion methods
        imap <expr> <Right> pumvisible() ? "<Plug>(MUcompleteCycFwd)" : "\<Right>"
        imap <expr> <Left> pumvisible() ? "<Plug>(MUcompleteCycBwd)" : "\<Left>"

        " Use down/up in completion popup
        " http://vim.wikia.com/wiki/Improve_completion_popup_menu
        inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"

        " CTRL+Y select item without newline in popup
        " and prevent newline/CR on selecting completion
        " http://superuser.com/a/941082/141399
        imap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
      " }

      " phpcomplete.vim {
        Plug 'shawncplus/phpcomplete.vim'
      " }

      " vim-better-javascript-completion {
        Plug '1995eaton/vim-better-javascript-completion'
      " }

      " csscomplete.vim {
        " Update the bult-in CSS complete function to latest CSS standard.
        Plug 'othree/csscomplete.vim'

        autocmd vimrc FileType css,less,scss set omnifunc=csscomplete#CompleteCSS noci
      " }
    " }

    " Custom Operators {
      " sad.vim {
        " Quick Search and Replace for Vim
        " Similar to using 'cgn'
        Plug 'hauleth/sad.vim'

        nmap c <Plug>(sad-change-forward)
        nmap C <Plug>(sad-change-forward)$
        nmap cc 0<Plug>(sad-change-forward)$

        xmap c <Plug>(sad-change-forward)
        xmap C <Plug>(sad-change-backward)
      " }

      " vim-surround {
        " Surround - quoting/parenthesizing made simple
        Plug 'tpope/vim-surround'

        " CSS style commenting ( 99 ASCII for 'c' ) e.g.: yssc
        let g:surround_99 = "/* \r */"

        " PHP {
          " Enable PHP tag Surrounds ( 112 ASCII for 'p' ) e.g.: yssp
          autocmd vimrc FileType php let b:surround_112 = "<?php \r ?>"

          " Enable easy PHP var_dump() ( 108 ASCII for 'l' ) e.g.: yssl
          autocmd vimrc FileType php let b:surround_108 = "var_dump( \r );"
        " }

        " JS {
          " Enable easy JS console.log() ( 108 ASCII for 'l' ) e.g.: yssl
          autocmd vimrc FileType javascript let b:surround_108 = "console.log( \r );"
        " }

        " Surround Specifc Mappings {
          " Add spaces inside () quickly
          nmap (( vi(S<Space><Space>
        " }
      " }

      " vim-commentary {
        " Comment stuff out with a single command for many languages plus extendability
        Plug 'tpope/vim-commentary'
      " }

      " vim-exchange {
        " Easy text exchange operator for Vim.
        Plug 'tommcdo/vim-exchange'
      " }
    " }

    " Custom Text Objects {
      " targets.vim {
        " Gives additional text objects and allows you to manipulate said objects in a
        " way that makes sense within their context's.
        Plug 'wellle/targets.vim'

        " Mappings do not work if they are non-recursive
        nmap "" cI"
        nmap '' cI'

        " Change inside ( foobar ) quickly
        nmap )) cI(
      " }

      " vim-textobj-user {
        " Create your own text objects
        " Is a dependency for other custom text objects
        Plug 'kana/vim-textobj-user'
      " }

      " vim-textobj-line {
        " Text Object for Lines
        " e.g.: dil is equivalent to ^dg_
        Plug 'kana/vim-textobj-line'
      " }

      " vim-indent-object {
        " Text Object for Indented Blocks
        Plug 'michaeljsmith/vim-indent-object'
      " }
    " }
  " }

  " Syntax Helpers {
    " ALE {
      " Asynchronous Lint Engine
      Plug 'w0rp/ale'
    " }

    " Matchem {
      " Fixes Edge-Case delimitMate problems
      Plug 'ervandew/matchem'
    " }
  " }

  " A E S T H E T I C S {
    " Colour Schemes {
      " LESS {
        Plug 'groenewege/vim-less'
      " }
    " }

    " vim-indent-guides {
      " Shows semi-opaque markings to indicate indent levels
      " TODO: https://github.com/nathanaelkane/vim-indent-guides/issues/55
      Plug 'nathanaelkane/vim-indent-guides'

      let g:indent_guides_enable_on_vim_startup = 1
      let g:indent_guides_start_level = 2
      let g:indent_guides_guide_size = 1
    " }

    " vim-airline {
      " Pretty looking Status Line
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'

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
