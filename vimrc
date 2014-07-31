" most configuration taken here: https://github.com/justinforce/dotfiles/blob/master/files/vimrc

" put this line first in ~/.vimrc
set nocompatible | filetype indent plugin on | syn on

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 https://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif
  call vam#ActivateAddons([], {'auto_install' : 0})
endfun

call SetupVAM()

VAMActivate Solarized
VAMActivate trailing-whitespace

au BufReadPost *.adoc set syntax=asciidoc

set number                                                " show absolute line number of the current line
set scrolloff=10                                          " scroll the window so we can always see 10 lines around the cursor
set textwidth=80                                          " show a vertical line at the 79th character
set guioptions-=T                                         " turn off GUI toolbar (icons)
set guioptions-=r                                         " turn off GUI right scrollbar
set guioptions-=L                                         " turn off GUI left scrollbar
set winaltkeys=no                                         " turn off stupid fucking alt shortcuts
set laststatus=2                                          " always show status bar

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_running")
  set guifont=Ubuntu\ Mono\ 11
  set columns=120

  " Use the first available colorscheme in this list
  for scheme in [ 'solarized', 'molokai', 'desert' ]
    try
      execute 'colorscheme '.scheme
      break
    catch
      continue
    endtry
  endfor
endif

" highlight the 80th column
"
" In Vim >= 7.3, also highlight columns 120+
if exists('+colorcolumn')
  " (I picked 120-320 because you have to provide an upper bound and 500 seems
  " to be enough.)
  let &colorcolumn="80,".join(range(120,500),",")
else
  " fallback for Vim < v7.3
  autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent
autocmd filetype c,asm,python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType make setlocal noexpandtab
