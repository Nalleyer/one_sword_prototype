class SampleView extends h2d.Flow implements h2d.domkit.Object {

    static var SRC =
        <sample-view class="box" layout="vertical">
            <text class="label" text={"我是DomKit!"}/>
        </sample-view>

    public function new(tile:h2d.Tile,?parent) {
        super(parent);
        initComponent();
    }
}