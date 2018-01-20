using Toybox.WatchUi as Ui;

class ftamonitorgarminwatchappDelegate extends Ui.InputDelegate {

    private var _ui;

    function initialize(ui) {
        _ui = ui;
        InputDelegate.initialize();
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == Ui.KEY_ENTER) {
            _ui.switchDisplay();
            return true;
        }

        return false;
    }
}
