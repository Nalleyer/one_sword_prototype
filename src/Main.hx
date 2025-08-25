import TicColors.TIC_DARK_CYAN;
import TicColors.TIC_LIGHT_GRAY;
import TicColors.TIC_WHITE;
import TicColors.TIC_LIGHT_BLUE;
import TicColors.TIC_DARK_BLUE;
import TicColors.TIC_DARK_GRAY;
import hxsl.Types.Vec4;
import format.png.Data.Color;
import hxd.App;
import hxd.Res;
import h2d.Text;

class Main extends App {
	private var font:h2d.Font;

	private var style:h2d.domkit.Style;

	private var counter: Int = 0;
	private var debug_label:h2d.Text;

	static inline final SCREEN_WIDTH = 240;
	static inline final SCREEN_HEIGHT = 136;

	static inline final TEXT_SCALE = 0.5;

	var leftCharacter:Character;
	var rightCharacter:Character;

	static function main() {
		#if hlsdl
		Sys.putEnv("SDL_VIDEO_WINDOW_POS", "center"); // 居中显示
		Sys.putEnv("SDL_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR", "0"); // 禁用合成器绕过
		#end

		hxd.Res.initEmbed();

		new Main();
	}

	override function init() {
		super.init();

		// 固定加一个背景
		var bgGraphic = new h2d.Graphics(s2d);
		bgGraphic.beginFill(TIC_WHITE);
		bgGraphic.drawRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
		bgGraphic.endFill();

		// 加载字体
		font = hxd.Res.fusion8.toFont();

		var text = new h2d.Text(font);
		text.text = "";
		text.smooth = false;
		text.color = hexToVec4(TIC_DARK_GRAY);
		text.dropShadow = {
			dx: 0.3,
			dy: 0.3,
			color: TIC_LIGHT_GRAY,
			alpha: 1,
		};
		text.x = SCREEN_WIDTH / 4;
		text.y = 8;
		text.scale(TEXT_SCALE);

		s2d.addChild(text);


		debug_label = text;

		// 直接在这里指定窗口模式
		var window = hxd.Window.getInstance();
		window.resize(SCREEN_WIDTH * 8, SCREEN_HEIGHT * 8);
		s2d.scaleMode = LetterBox(SCREEN_WIDTH, SCREEN_HEIGHT);
		trace("init window ok");

		// 试试 ui(DomKit)
		var view = new SampleView(h2d.Tile.fromColor(0xFF, 32, 32), s2d);
		view.scale(TEXT_SCALE);

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

		engine.backgroundColor = 0x000000;
	}

	override function update(dt:Float) {
		// 简单渲染
		debug_label.text = "我是中文字体。ABCOo1029847382956了这么多下： " + counter;
		// 这行很关键，不然hover之类的样式无法刷新生效
		style.sync();
	}

	function hexToVec4(hex:Int):Vec4 {
		var r = ((hex >> 16) & 0xFF) / 255.0;
		var g = ((hex >> 8) & 0xFF) / 255.0;
		var b = (hex & 0xFF) / 255.0;
		return new Vec4(r, g, b, 1.0);
	}
}
