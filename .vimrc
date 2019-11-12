" set the runtime path to include Vundle and initialize 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-rails'
Plugin 'scrooloose/nerdtree'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'dense-analysis/ale'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive' " Git(push, commit and outhers)
call vundle#end()            " required
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
autocmd Filetype python set omnifunc=pythoncomplete#Complete
set number
set relativenumber
set autoindent
set ts=4
set ic
set ignorecase "ignora maiúsculas e minúsculas na bucsca
set smartcase "se sua busca contiver maiúsculas ele passa a considera-las
set hlsearch "mostra o que está sendo buscado em cores
set incsearch "ativa a busca incremental
syntax on
colorscheme dracula
"declaração da função
function! Executar(arq)
    "o vim possui uma variável built-in chamada &filetype
    "seu conteúdo corresponde ao tipo de arquivo auto-detectado
    "executaremos os arquivos usando a chamada :exec seguida do
    "comando e o nome do arquivo que você está editando
    "
    "o parâmetro arq é passado à função via shellescape, que é
    "traduzido para o nome do arquivo que você está editando
    "
    "antes de começar a estrutura if-else, estou invocando o
    "comando :w para salvar o arquivo que você está editando
    "dessa forma o Vim terá acesso à versão atual do seu código,
    "mesmo que tenhas esquecido de salvá-lo

    "salvar edição atual
    :w

    if &filetype == 'html'
        :exec '!google-chrome' a:arq
    elseif &filetype == 'python'
        :exec '!python3' a:arq
    elseif &filetype == 'c'
        :exec '!gcc -o /tmp/a.out' a:arq ';/tmp/a.out'
    endif
endfunction

"mapear a tecla F5 para chamar a função Executar,
"passando como parâmetro o nome do arquivo em edição
nnoremap <F5> :call Executar(shellescape(@%, 1))<CR>
