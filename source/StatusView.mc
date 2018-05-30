using Toybox.Attention as Attention;
using Toybox.Lang;
using Toybox.Graphics;
using Toybox.System;
using Toybox.WatchUi as Ui;

module ViewStatus {
    enum {
        TEAM_STATUS,
        TEAM_NUMBER,
        BATTERY
    }
}

class StatusView extends Ui.View {
    // Device dimensions
    private var _deviceWidth;
    private var _deviceHeight;

    // Views
    private var _timeView;
    private var _batteryView;
    private var _lastTime;
    private var _blue1Text;
    private var _blue2Text;
    private var _blue3Text;
    private var _red1Text;
    private var _red2Text;
    private var _red3Text;
    private var _matchStatus;

    // Status of things
    private var _teamStatus;
    // ViewStatus.TEAM_STATUS/TEAM_NUMBER/BATTERY
    private var _displayStatus;

    function initialize(teamStatus) {
        View.initialize();
        _teamStatus = teamStatus;
        _displayStatus = ViewStatus.TEAM_STATUS;
    }

    // Load your resources here
    function onLayout(dc) {
        _deviceWidth = dc.getWidth();
        _deviceHeight = dc.getHeight();

        // Split the X dimension into quarters, the numbers
        // will be set on the dividers between the quarters
        var halfWidth = (_deviceWidth / 2).toNumber();

        // 1/4 of the screen on left
        var leftCentered = (halfWidth / 2).toNumber();
        // 3/4 of the screen on the right
        var rightCentered = halfWidth + leftCentered;

        var numberHeight = (_deviceHeight / 4).toNumber();
        var numberTextAdjustment = (numberHeight / 2).toNumber();
        var menuHeight = numberHeight;
        var row2Start = menuHeight + numberHeight;
        var row3Start = row2Start + numberHeight;

        var menuRow2 = (menuHeight / 3).toNumber();
        var menuRow3 = menuRow2 * 2;
        var menuTextAdjustment = (menuHeight / 6).toNumber();

        _timeView = new Ui.Text({
            :text=>"Time",
            :color=>Graphics.COLOR_BLACK,
            :font=>Graphics.FONT_TINY,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX=>halfWidth,
            :locY=>menuTextAdjustment
        });

        _matchStatus = new Ui.Text({
            :text=>"Time",
            :color=>Graphics.COLOR_BLACK,
            :font=>Graphics.FONT_TINY,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX=>halfWidth,
            :locY=>menuRow2 + menuTextAdjustment
        });

        _batteryView = new Ui.Text({
            :text=>"Battery",
            :color=>Graphics.COLOR_BLACK,
            :font=>Graphics.FONT_TINY,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX=>halfWidth,
            :locY=>menuRow3 + menuTextAdjustment
        });

        _blue1Text = new Ui.Text({
            :text=>"Blue1",
            :color=>Graphics.COLOR_BLACK,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX=>leftCentered,
            :locY=>menuHeight + numberTextAdjustment
        });

        _blue2Text = new Ui.Text({
            :text=>"Blue2",
            :color=>Graphics.COLOR_BLACK,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX=>leftCentered,
            :locY=>row2Start + numberTextAdjustment
        });

        _blue3Text = new Ui.Text({
            :text=>"Blue3",
            :color=>Graphics.COLOR_BLACK,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX=>leftCentered,
            :locY=>row3Start + numberTextAdjustment
        });

        _red1Text = new Ui.Text({
            :text=>"Red1",
            :color=>Graphics.COLOR_BLACK,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX=>rightCentered,
            :locY=>menuHeight + numberTextAdjustment
        });

        _red2Text = new Ui.Text({
            :text=>"Red2",
            :color=>Graphics.COLOR_BLACK,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX=>rightCentered,
            :locY=>row2Start + numberTextAdjustment
        });

        _red3Text = new Ui.Text({
            :text=>"Red3",
            :color=>Graphics.COLOR_BLACK,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX=>rightCentered,
            :locY=>row3Start + numberTextAdjustment
        });
        _timeView.draw(dc);
        _matchStatus.draw(dc);
        _batteryView.draw(dc);
        _blue1Text.draw(dc);
        _blue2Text.draw(dc);
        _blue3Text.draw(dc);
        _red1Text.draw(dc);
        _red2Text.draw(dc);
        _red3Text.draw(dc);

        //setLayout(Rez.Layouts.MainLayout(dc));

        //var blueHeader = findDrawableById("blue_header");
        //var redHeader = findDrawableById("red_header");
        //blueHeader.setText(Rez.Strings.blue);
        //redHeader.setText(Rez.Strings.red);

        //_timeView = findDrawableById("time");
        //_batteryView = findDrawableById("battery");
        //_matchStatus = findDrawableById("match_status");
        //updateTime();

        //_blue1 = findDrawableById("blue_1");
        //_blue2 = findDrawableById("blue_2");
        //_blue3 = findDrawableById("blue_3");
        //_red1 = findDrawableById("red_1");
        //_red2 = findDrawableById("red_2");
        //_red3 = findDrawableById("red_3");
        //updateTeams();
   }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        //updateTime();
        //updateTeams();
        //View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    function vibrate() {
        if (Attention has :vibrate) {
            var vibrateData = [
                    new Attention.VibeProfile(50, 500),
                ];

            Attention.vibrate(vibrateData);
        } else {
            System.println("Vibe not supported");
        }
    }

    public function setViewStatus(status) {
        _displayStatus = status;
        Ui.requestUpdate();
    }

    private function updateTime() {
        var currentTime = System.getClockTime();
        var timeString = currentTime.hour.format("%20d") + ":" + currentTime.min.format("%02d");
        _timeView.setText(timeString);

        _batteryView.setText(System.getSystemStats().battery.format("%.0f") + "%");

        _matchStatus.setText(MatchState.getStatusString(_teamStatus.MatchStatus));
    }

    private function updateTeams() {
        if (_displayStatus == ViewStatus.TEAM_STATUS) {
            _blue1.setText(TeamStatus.getStatusString(_teamStatus.Blue1Status));
            _blue2.setText(TeamStatus.getStatusString(_teamStatus.Blue2Status));
            _blue3.setText(TeamStatus.getStatusString(_teamStatus.Blue3Status));
            _red1.setText(TeamStatus.getStatusString(_teamStatus.Red1Status));
            _red2.setText(TeamStatus.getStatusString(_teamStatus.Red2Status));
            _red3.setText(TeamStatus.getStatusString(_teamStatus.Red3Status));
        } else if (_displayStatus == ViewStatus.TEAM_NUMBER) {
            _blue1.setText(_teamStatus.Blue1Number.format("%d"));
            _blue2.setText(_teamStatus.Blue2Number.format("%d"));
            _blue3.setText(_teamStatus.Blue3Number.format("%d"));
            _red1.setText(_teamStatus.Red1Number.format("%d"));
            _red2.setText(_teamStatus.Red2Number.format("%d"));
            _red3.setText(_teamStatus.Red3Number.format("%d"));
        } else {
            _blue1.setText(TeamStatus.formatBattery(_teamStatus.Blue1Battery));
            _blue2.setText(TeamStatus.formatBattery(_teamStatus.Blue2Battery));
            _blue3.setText(TeamStatus.formatBattery(_teamStatus.Blue3Battery));
            _red1.setText(TeamStatus.formatBattery(_teamStatus.Red1Battery));
            _red2.setText(TeamStatus.formatBattery(_teamStatus.Red2Battery));
            _red3.setText(TeamStatus.formatBattery(_teamStatus.Red3Battery));
        }
    }
}
