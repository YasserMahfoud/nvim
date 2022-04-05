runtime! debian.vim

call plug#begin('~/.local/share/nvim/plugged')
Plug 'sainnhe/sonokai'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'kien/rainbow_parentheses.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'dhruvasagar/vim-table-mode'
Plug 'liuchengxu/vista.vim'
Plug 'lervag/vimtex'
Plug 'vimwiki/vimwiki'
Plug 'tibabit/vim-templates'
Plug 'conornewton/vim-pandoc-markdown-preview'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
call plug#end()

" Color and syntax
if has('termguicolors')
	set termguicolors
endif

filetype plugin on
syntax on

let g:sonokai_style = 'shusia'

color sonokai
set number
set relativenumber
set smartindent
set tabstop=4 softtabstop=4
set shiftwidth=4
set noswapfile

" CoC.Nvim
" ============================================================
" ============================================================
" Use <c-space> to trigger completion.

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)


" Vimwiki
" ============================================================
" ============================================================
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]

hi VimwikiHeader1 guifg=#FF0000
hi VimwikiHeader2 guifg=#00FF00
hi VimwikiHeader3 guifg=#FF00FF
hi VimwikiHeader4 guifg=#00FFFF
hi VimwikiHeader5 guifg=#FFFF00

"let g:vimwiki_conceal_pre=1 "switch to 1 to fold code blocks

function! VimwikiLinkHandler(link)
  " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
  "   1) [[vfile:~/Code/PythonProject/abc123.py]]
  "   2) [[vfile:./|Wiki Home]]
  let link = a:link
  if link =~# '^vfile:'
    let link = link[1:]
  else
    return 0
  endif
  let link_infos = vimwiki#base#resolve_link(link)
  if link_infos.filename == ""
    echomsg 'Vimwiki Error: Unable to resolve link!'
    return 0
  else
    " ISSURE HERE <-------------------------------------------XXX
    " right now the file link only works for the
    " files that are in the same directory as the
    " vimwiki file

    " This was the original code
    "exe 'tabnew ' . fnameescape(link_infos.filename)
    
    " This is the fix proposed
    exe 'tabnew ' . fnameescape(split(link_infos.filename,"/")[-1])
    return 1
  endif
endfunction


" Vimtex 
" ============================================================
" ============================================================
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer = 'texworks'
let g:vimtex_quickfix_mode=0
au BufEnter *.tex setl tw=80 spell spelllang=en_us


" Rainbow Parentheses
" ============================================================
" ============================================================
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadRound


" Vista
" ============================================================
" ============================================================
nmap <F8> :Vista coc<CR>
let g:vista_sidebar_width = 40
let g:vista_icon_indent = [">", ""]
let g:vista#renderer#enable_icon = 0


" Templates
" ============================================================
" ============================================================
let g:tmpl_search_paths = ['~/.config/nvim/templates/']
let g:tmpl_author_name = 'Yasser Mahfoud'


" vim-pandoc-markdown-preview
" ============================================================
" ============================================================
let g:md_pdf_viewer = 'texworks'


" Remaps
" ============================================================
" ============================================================
nnoremap Y y$

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv


autocmd filetype python nnoremap <F5> :term ipython3 -i %<CR>
autocmd filetype fortran nnoremap <F5> :term gfortran -fdefault-real-8 -O3 % -lblas -llapack && ./a.out<CR>
