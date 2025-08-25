import hxsl.Types.Vec4;
import format.png.Data.Color;
import hxd.App;
import hxd.Res;
import h2d.Text;

class Main extends App {
	private var font:h2d.Font;

	private var style:h2d.domkit.Style;

	private var counter: Int = 0;
	private var debugLabel:h2d.Text;

	static inline final TEXT_SCALE = 4;
	// 因为ui里面不能调整字体大小，只能缩放字体倍数了
	static inline final UI_SCALE = 4;
	static inline final LOGIC_SCALE = 8;

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
		font = hxd.Res.fusion8.toFont();

		var text = new h2d.Text(font);
		text.text = "我是中文字abc哦l两情相悦老套，。不是吧。模拟，糯米，囊攮齉";
		text.smooth = false;
		text.dropShadow = {
			dx: 1,
			dy: 1,
			color: 0x030303,
			alpha: 0.8
		};
		text.color = new Vec4(0.75, 1, 1, 1);
		text.x = l2s(120);
		text.y = l2s(8);
		text.scale(TEXT_SCALE);

		s2d.addChild(text);

		debugLabel = text;

		// 直接在这里指定窗口模式
		var window = hxd.Window.getInstance();
		window.resize(240 * LOGIC_SCALE, 136 * LOGIC_SCALE);
		trace("init window ok");

		// 试试 ui(DomKit)
		var view = new SampleView(h2d.Tile.fromColor(0xFF, 32, 32), s2d);
		//view.mybmp.alpha = 0.8;
		view.scale(UI_SCALE);

		view.testBtn.label = "点我";
		view.testBtn.onClick = function() {
			counter += 1;
		}

		style = new h2d.domkit.Style();
		// resource referencing res/style.css (see Heaps Resources documentation)
		style.load(hxd.Res.style);
		style.addObject(view);
		// debug
		style.allowInspect = true;

		engine.backgroundColor = 0x638799;
	}

	override function update(dt:Float) {
		// 简单渲染
		debugLabel.text = "点击次数: " + counter;
		// 这行很关键，不然hover之类的样式无法刷新生效
		style.sync();
	}

	private function l2s(pos:Float):Float {
		return pos * 8;
	}
}
