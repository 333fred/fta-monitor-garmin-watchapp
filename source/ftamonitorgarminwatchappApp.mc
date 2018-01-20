using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Timer;

class ftamonitorgarminwatchappApp extends App.AppBase {

    private var _timer;
    private var _testingTimer;
    private var _teamStatus;

    function initialize() {
        AppBase.initialize();
        _teamStatus = new TeamStatusManager();
    }

    // onStart() is called on application start up
    function onStart(state) {
        _timer = new Timer.Timer();
        _testingTimer = new Timer.Timer();
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
        if (_timer != null) {
            _timer.stop();
            _timer = null;
            _testingTimer.stop();
            _testingTimer = null;
        }
    }

    // Return the initial view of your application here
    function getInitialView() {

        var view = new ftamonitorgarminwatchappView(_teamStatus);
        var viewArray = [ view, new ftamonitorgarminwatchappDelegate() ];
        _timer.start(new Lang.Method(Ui, :requestUpdate), 60000, true);
        _testingTimer.start(method(:tester), 1000, true);
        return viewArray;
    }

    function tester() {
        _teamStatus.Blue1 = incrementStatus(_teamStatus.Blue1);
        _teamStatus.Blue2 = incrementStatus(_teamStatus.Blue2);
        _teamStatus.Blue3 = incrementStatus(_teamStatus.Blue3);
        _teamStatus.Red1 = incrementStatus(_teamStatus.Red1);
        _teamStatus.Red2 = incrementStatus(_teamStatus.Red2);
        _teamStatus.Red3 = incrementStatus(_teamStatus.Red3);
        Ui.requestUpdate();
    }

    private function incrementStatus(status) {
        if (status == TeamStatus.BAT) {
            return TeamStatus.ETH;
        } else {
            return status + 1;
        }
    }
}
