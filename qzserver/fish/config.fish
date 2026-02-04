# 1. 交互模式下的配置（只在打开终端时运行）
if status is-interactive

	fastfetch --file-raw ~/.config/logo_qz.txt 

    # 注入 Starship 灵魂（如果你之前安装了 starship）
    starship init fish | source
    # 1. 确保 PATH 包含 fnm (如果上面执行过 fish_add_path，这行可以不写，但写上更稳)
    set -gx PATH "$HOME/.local/share/fnm" $PATH

    # 2. 初始化 fnm 环境
    fnm env --use-on-cd --shell fish | source
end


# 3. 别名设置 (Alias)
# 语法：alias 名字 '命令'
alias ls 'lsd'
alias ll 'lsd -l'
alias la 'lsd -a'
alias lt 'lsd --tree'
alias cat 'bat'

# 用 fd 替换 find (更快，语法更简单)
alias find='fd'

# 用 ripgrep 替换 grep (性能之王)
alias grep='rg'

# 如果你安装了 bat-extras，这个会非常爽
alias help='batman' # 需要安装 bat-extras

# 4. 这里的路径根据你的实际情况添加
# 如果你有特殊的脚本目录，可以在这里加
# 代理开关函数


function proxy
    set -gx http_proxy http://127.0.0.1:7897
    set -gx https_proxy http://127.0.0.1:7897
    set -gx all_proxy socks5://127.0.0.1:7897 # 建议加上 all_proxy，很多工具走这个

    set -gx HTTP_PROXY http://127.0.0.1:7897
    set -gx HTTPS_PROXY http://127.0.0.1:7897

    echo "终端代理已开启 (127.0.0.1:7897)"
end

function unproxy
    set -e http_proxy
    set -e https_proxy
    set -e all_proxy
    set -e HTTP_PROXY
    set -e HTTPS_PROXY
    echo "终端代理已关闭"
end

# 3. 辅助：快速查看当前代理状态
alias pxy='env | grep -i proxy'


# 开启 Vi 模式
fish_vi_key_bindings

# 隐藏 Fish 默认的模式提示符（Starship 会接管它）
function fish_mode_prompt; end

# 设置光标形状随模式改变 (WezTerm 支持此功能)
set -g fish_cursor_default block      # 普通模式用方块
set -g fish_cursor_insert line       # 插入模式用竖线
set -g fish_cursor_replace_one underscore # 替换模式用下划线




export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
fastfetch --logo-type command --logo "toilet -f block -F metal QZ"

# pnpm
set -gx PNPM_HOME "/home/qizhao/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
