using Toybox.WatchUi as Ui;
using Toybox.System;

class ftamonitorgarminwatchappView extends Ui.View {

    // Views
    private var _timeView;
    private var _batteryView;
    private var _lastTime;
    private var _blue1;
    private var _blue2;
    private var _blue3;
    private var _red1;
    private var _red2;
    private var _red3;

    // Status of things
    private var _teamStatus;

    function initialize(teamStatus) {
        View.initialize();
        _teamStatus = teamStatus;
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

        _blue1 = findDrawableById("blue_1");
        _blue2 = findDrawableById("blue_2");
        _blue3 = findDrawableById("blue_3");
        _red1 = findDrawableById("red_1");
        _red2 = findDrawableById("red_2");
        _red3 = findDrawableById("red_3");
        updateTeams();
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
        updateTeams();
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

    private function updateTeams() {
        _blue1.setText(TeamStatus.getStatusString(_teamStatus.Blue1));
        _blue2.setText(TeamStatus.getStatusString(_teamStatus.Blue2));
        _blue3.setText(TeamStatus.getStatusString(_teamStatus.Blue3));
        _red1.setText(TeamStatus.getStatusString(_teamStatus.Red1));
        _red2.setText(TeamStatus.getStatusString(_teamStatus.Red2));
        _red3.setText(TeamStatus.getStatusString(_teamStatus.Red3));
    }
}
