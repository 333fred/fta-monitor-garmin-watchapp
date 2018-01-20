using Toybox.WatchUi as Ui;

class StatusViewDelegate extends Ui.InputDelegate {

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

    function onSwipe(swipeEvent) {
        var direction = swipeEvent.getDirection();
        if (direction == Ui.SWIPE_UP) {
            System.println("Swiped up");
        } else if (direction == Ui.SWIPE_DOWN) {
            System.println("Swiped down");
        }

        return false;
    }
}
