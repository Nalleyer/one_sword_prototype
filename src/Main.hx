import hxsl.Types.Vec4;
import format.png.Data.Color;
import hxd.App;
import hxd.Res;
import h2d.Text;

class Main extends App {
	private var font: h2d.Font;

	static function main() {
		#if (linux)
		Sys.putEnv("SDL_VIDEO_WINDOW_POS", "center"); // 居中显示
		Sys.putEnv("SDL_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR", "0"); // 禁用合成器绕过
		#end

        hxd.Res.initEmbed();

		new Main();
	}

	override function init() {
		super.init();

		// 加载字体
		font = hxd.Res.fusion8.toSdfFont(32, h2d.Font.SDFChannel.MultiChannel);

		var text = new h2d.Text(font);
		text.text = "我是中文字abc哦";
		text.color = new Vec4(0, 1, 1, 1);
		text.scale(1);

		s2d.addChild(text);

		// 直接在这里指定窗口模式
		var window = hxd.Window.getInstance();
		window.resize(800, 600);
		trace("init window ok");
		// 设置SDL窗口标志

		// window.displayMode = Fullscreen;
		// window.displayMode = Windowed;
		engine.backgroundColor = 0x202020;
	}

	override function update(dt:Float) {
		// 简单渲染
	}
}
