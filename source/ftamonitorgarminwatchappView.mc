using Toybox.WatchUi as Ui;
using Toybox.System;

class ftamonitorgarminwatchappView extends Ui.View {

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

        var currentTime = System.getClockTime();
        var timeString = currentTime.hour.format("%20d") + ":" + currentTime.min.format("%02d");
        var clock = findDrawableById("time");
        clock.setText(timeString);

        var battery = findDrawableById("battery");
        battery.setText(System.getSystemStats().battery.format("%.0f") + "%");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
