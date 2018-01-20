using Toybox.WatchUi as Ui;

class StatusViewDelegate extends Ui.InputDelegate {

    private var _ui;

    private var _currentState;

    function initialize(ui) {
        _ui = ui;
        InputDelegate.initialize();
    }

    function onSwipe(swipeEvent) {
        var direction = swipeEvent.getDirection();

        switch (direction) {
            case Ui.SWIPE_UP:
            case Ui.SWIPE_DOWN:
                handleNumber();
                return true;
            case Ui.SWIPE_LEFT:
            case Ui.SWIPE_RIGHT:
                handleBattery();
                return true;
        }

        return false;
    }

    function handleNumber() {
        if (_currentState == ViewStatus.TEAM_NUMBER) {
            _currentState = ViewStatus.TEAM_STATUS;
        } else {
            _currentState = ViewStatus.TEAM_NUMBER;
        }
        _ui.setViewStatus(_currentState);
    }

    function handleBattery() {
        if (_currentState == ViewStatus.BATTERY) {
            _currentState = ViewStatus.TEAM_STATUS;
        } else {
            _currentState = ViewStatus.BATTERY;
        }
        _ui.setViewStatus(_currentState);
    }
}
