using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Timer;

class ftamonitorgarminwatchappApp extends App.AppBase {

    private var _timer;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
        _timer = new Timer.Timer();
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
        if (_timer != null) {
            _timer.stop();
            _timer = null;
        }
    }

    // Return the initial view of your application here
    function getInitialView() {

        var view = new ftamonitorgarminwatchappView();
        var viewArray = [ view, new ftamonitorgarminwatchappDelegate() ];
        _timer.start(new Lang.Method(Ui, :requestUpdate), 60000, true);
        return viewArray;
    }

}
