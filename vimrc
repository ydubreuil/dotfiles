" most configuration taken here: https://github.com/justinforce/dotfiles/blob/master/files/vimrc

" put this line first in ~/.vimrc
set nocompatible | filetype indent plugin on | syn on

au BufReadPost *.adoc set syntax=asciidoc

set number                                                " show absolute line number of the current line
set scrolloff=10                                          " scroll the window so we can always see 10 lines around the cursor
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent
autocmd filetype c,asm,python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType make setlocal noexpandtab
