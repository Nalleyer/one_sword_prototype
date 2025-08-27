import haxe.macro.Context;
import sys.FileSystem;
import sys.io.File;

class Build {
    public static function buildAssets() {
        // 定义项目根目录下的相对路径
        var stylPath = "meta_resource/style.styl";
        var cssPath = "res/style.css";
        trace("running build assets macro file");

        // 检查CSS文件是否存在，或者Stylus文件是否更新
        var needsRebuild = !FileSystem.exists(cssPath);
        if (!needsRebuild) {
            var stylModTime = FileSystem.stat(stylPath).mtime;
            var cssModTime = FileSystem.stat(cssPath).mtime;
            if (stylModTime.getTime() > cssModTime.getTime()) {
                needsRebuild = true;
            }
        }

        if (needsRebuild) {
            // 通知用户我们正在构建CSS
            trace('Building CSS: ${stylPath} -> ${cssPath}');

            // 执行stylus命令 (输出到目录而不是文件)
            var command = 'stylus ' + stylPath + ' -o res/';
            var exitCode = Sys.command(command);

            // 如果命令失败，停止编译并报错
            if (exitCode != 0) {
                Context.error('Stylus compilation failed with exit code ${exitCode}.', Context.currentPos());
            }
        }
    }
}
