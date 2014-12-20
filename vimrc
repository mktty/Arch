" 配色方案
colorscheme molokai

"iab if(){  if{<CR><TAB>}<ESC>i 

" 编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

" 设置菜单语言
"set langmenu=zh_CN.UTF-8

" 导入删除菜单脚本，删除乱码的菜单
source $VIMRUNTIME/delmenu.vim

" 导入正常的菜单脚本
source $VIMRUNTIME/menu.vim

" 设置提示信息语言
language messages zh_CN.utf-8

" 字体设置
"set guifont=Monaco:h12:cANSI
:set guifont=consolas:h14  

" 语法高亮
syntax enable
set syntax=on
set ai!
" 自动缩进
set autoindent

" C语言方式缩进
set cindent

" 智能缩进
set smartindent

" 统一缩进为4
set softtabstop=4
set shiftwidth=4

" 默认窗口大小
set lines=30 columns=82

" 自动换行
set wrap

" 整词换行
set linebreak

" 显示行号
"set number
set nu

" 高亮显示匹配的括号
set showmatch

" 搜索逐字符高亮和实时搜索
set hlsearch
set incsearch

" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5

" 显示括号配对情况
set showmatch

" 代码折叠
" set fdm=indent

" 选择代码折叠类型
set foldmethod=syntax

" 禁止自动折叠
set foldlevel=100

" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2

" 历史记录数
set history=1000

" 侦测文件类型
filetype on

" 为特定文件类型载入相关缩进格式
filetype indent on

" 为特定的文件类型载入对应的插件
filetype plugin on
filetype plugin indent on

" 不与vi兼容
set nocp

" vim目录树插件
map <F10> :NERDTreeToggle<CR>

" 保存全局变量
set viminfo+=!

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 字符间插入的像素行数目
set linespace=0

" 增强模式中的命令行自动完成操作
set wildmenu

" PHP语法提示
autocmd FileType php set omnifunc=phpcomplete

" 禁止生成临时文件
set nobackup
set noswapfile

" 设置退格键可用
set backspace=2

" 快捷键自定义
map <C-s> :w<CR>
imap <C-s> <C-o>:w<CR>

" 隐藏工具栏，可用快捷键F2切换
"set guioptions-=T
"map <silent> <F2> :if &guioptions =~# 'T' <Bar>
"set guioptions-=T <Bar>
"else <Bar>
"set guioptions+=T <Bar>
"endif<CR>

" 能够漂亮地显示.NFO文件
set encoding=utf-8
function! SetFileEncodings(encodings)
let b:myfileencodingsbak=&fileencodings
let &fileencodings=a:encodings
endfunction
function! RestoreFileEncodings()
let &fileencodings=b:myfileencodingsbak
unlet b:myfileencodingsbak
endfunction
au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()

" F5编译和运行C程序，F6编译和运行C++程序
" C的编译和运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
exec "!gcc -Wall % -o %<"
exec "! ./%<"
endfunc

" C++的编译和运行
map <F6> :call CompileRunGpp()<CR>
func! CompileRunGpp()
exec "w"
exec "!g++ -Wall % -o %<"
exec "! ./%<"
endfunc

" Gvim标签定制
set guitablabel=%{ShortTabLabel()}
function ShortTabLabel ()
let bufnrlist = tabpagebuflist (v:lnum)
let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
let filename = fnamemodify (label, ':t')
return filename
endfunction

" ######### 一键保存和编译 ######### "
 "编译C源文件
func! CompileGcc()
exec "w"
let compilecmd="!gcc -Wall -std=c99 "
let compileflag="-o %<"
exec compilecmd." % ".compileflag
endfunc

" 编译C++源文件
func! CompileCpp()
exec "w"
let compilecmd="!g++ -Wall "
let compileflag="-o %<"
exec compilecmd." % ".compileflag
endfunc

" 编译&链接Go源文件
func! CompileGo()
exec "w"
exec "!8g %"
exec "!8l -o %<.exe %<.8"
endfunc

" 编译Haskell源文件
func! CompileHaskell()
exec "w"
let compilecmd="!ghc --make "
let compileflag="-o %<"
exec compilecmd." % ".compileflag
endfunc

" 编译Java源文件
func! CompileJava()
exec "w"
exec "!javac %"
endfunc

" 编译C#源文件
func! CompileCs()
exec "w"
exec "!csc %"
endfunc

" 编译Gas源文件
func! CompileGas()
exec "w"
exec "!gcc -Wall -ggdb -o %< %"
endfunc

" 运行Shell源文件
func! RunShell()
exec "w"
exec "!sh %"
endfunc

" 运行Lua源文件
func! RunLua()
exec "w"
exec "!lua %"
endfunc

" 运行Perl源文件
func! RunPerl()
exec "w"
exec "!perl %"
endfunc

" 运行Python源文件
func! RunPython()
exec "w"
exec "!python %"
endfunc

" 运行Ruby源文件
func! RunRuby()
exec "w"
exec "!ruby %"
endfunc

" 根据文件类型自动选择相应的编译函数
func! CompileCode()
exec "w"
if &filetype == "c"
exec "call CompileGcc()"
elseif &filetype == "cpp"
exec "call CompileCpp()"
elseif &filetype == "go"
exec "call CompileGo()"
elseif &filetype == "haskell"
exec "call CompileHaskell()"
elseif &filetype == "java"
exec "call CompileJava()"
elseif &filetype == "cs"
exec "call CompileCs()"
elseif &filetype == "asm"
exec "call CompileGas()"
elseif &filetype == "sh"
exec "call RunShell()"
elseif &filetype == "lua"
exec "call RunLua()"
elseif &filetype == "perl"
exec "call RunPerl()"
elseif &filetype == "python"
exec "call RunPython()"
elseif &filetype == "ruby"
exec "call RunRuby()"
endif
endfunc

" 运行可执行文件
func! RunResult()
exec "w"
if &filetype == "c"
exec "! %<"
elseif &filetype == "cpp"
exec "! %<"
elseif &filetype == "go"
exec "! %<"
elseif &filetype == "haskell"
exec "! %<"
elseif &filetype == "java"
exec "!java %<"
elseif &filetype == "cs"
exec "! %<"
elseif &filetype == "asm"
exec "! %<"
elseif &filetype == "sh"
exec "!sh %<.sh"
elseif &filetype == "lua"
exec "!lua %<.lua"
elseif &filetype == "perl"
exec "!perl %<.pl"
elseif &filetype == "python"
exec "!python %<.py"
elseif &filetype == "ruby"
exec "!ruby %<.rb"
endif
endfunc
