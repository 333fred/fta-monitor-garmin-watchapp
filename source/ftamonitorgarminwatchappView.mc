using Toybox.WatchUi as Ui;
using Toybox.System;

class ftamonitorgarminwatchappView extends Ui.View {

    private var _timeView;
    private var _batteryView;
    private var _lastTime;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));

        var blueHeader = findDrawableById("blue_header");
        var redHeader = findDrawableById("red_header");
        blueHeader.setText(Rez.Strings.blue);
        redHeader.setText(Rez.Strings.red);

        _timeView = findDrawableById("time");
        _batteryView = findDrawableById("battery");
        updateTime();
   }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        updateTime();
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    private function updateTime() {
        var currentTime = System.getClockTime();
        var timeString = currentTime.hour.format("%20d") + ":" + currentTime.min.format("%02d");
        _timeView.setText(timeString);

        _batteryView.setText(System.getSystemStats().battery.format("%.0f") + "%");
    }
}
