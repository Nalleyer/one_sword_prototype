# justfile 简单但是不知道增量
set shell := ["nu", "-c"]

# 默认任务
default: build

# 需要先做css，再做haxe
build: css haxe

# 构建CSS
css:
    stylus ./meta_resource/style.styl --out ./res/style.css

# 编译Haxe
haxe:
    haxe compile.hxml

# 运行游戏
run: build
    hl one_sword.hl

# 开发模式
dev: run

# 平台相关清理
clean:
    rm one_sword.hl
