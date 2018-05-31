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
    private var _matchStatus;
    private var _blueHeader;
    private var _redHeader;
    private var _blue1Text;
    private var _blue2Text;
    private var _blue3Text;
    private var _red1Text;
    private var _red2Text;
    private var _red3Text;
    private var _blueCellStart;
    private var _redCellStart;

    // Cell positions
    private var _thirdRowBackgroundYStart;
    private var _thirdRowHeight;
    private var _cellHeight;
    private var _cell1YStart;
    private var _cell1YEnd;
    private var _cell2YStart;
    private var _cell2YEnd;
    private var _cell3YStart;
    private var _cell3YEnd;
    private var _cellWidth;
    private var _radius = 3;

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

        // The heights of the text we need to do math on.
        var xTinyHeight = dc.getFontHeight(Graphics.FONT_XTINY);
        var xTinyHeightOffset= (xTinyHeight / 2).toNumber();
        var tinyHeight = dc.getFontHeight(Graphics.FONT_TINY);
        var tinyHeightOffset = (tinyHeight / 2).toNumber();

        // Top Marging
        var margin = 2;
        var firstRowY = margin + xTinyHeightOffset;
        var secondRowStart = 1 + xTinyHeight;
        var secondRowY = secondRowStart + tinyHeightOffset;
        _thirdRowBackgroundYStart = secondRowStart + tinyHeight + margin;
        var thirdRowY = _thirdRowBackgroundYStart + tinyHeightOffset;
        var thirdRowBackgroundYEnd = _thirdRowBackgroundYStart + tinyHeight + 1;
        _thirdRowHeight = thirdRowBackgroundYEnd - _thirdRowBackgroundYStart;

        // Height to split among the rest of the cells
        var gridHeight = _deviceHeight - thirdRowBackgroundYEnd - 1;
        _cellHeight = (gridHeight / 3).toNumber() - 2;
        var cellTextOffset = (_cellHeight / 2).toNumber();

        _cell1YStart = thirdRowBackgroundYEnd + 2;
        _cell1YEnd = _cell1YStart + _cellHeight;
        var cell1Text = _cell1YStart + cellTextOffset;

        _cell2YStart = _cell1YEnd + 2;
        _cell2YEnd = _cell2YStart + _cellHeight;
        var cell2Text = _cell2YStart + cellTextOffset;

        _cell3YStart = _cell2YEnd + 2;
        _cell3YEnd = _cell3YStart + _cellHeight;
        var cell3Text = _cell3YStart + cellTextOffset;

        var totallyCentered = Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER;

        // Split the X dimension into quarters, the numbers
        // will be set on the dividers between the quarters
        var halfWidth = (_deviceWidth / 2).toNumber();
        _blueCellStart = 2;
        _redCellStart = halfWidth + 1;
        _cellWidth = halfWidth - 3;

        // 1/4 of the screen on left
        var leftCentered = (halfWidth / 2).toNumber();
        // 3/4 of the screen on the right
        var rightCentered = halfWidth + leftCentered;

        _timeView = new Ui.Text({
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_XTINY,
            :justification=>Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER,
            :locX=>margin,
            :locY=>firstRowY
        });

        _batteryView = new Ui.Text({
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_XTINY,
            :justification=>Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER,
            :locX=>_deviceWidth - margin,
            :locY=>firstRowY
        });

        _matchStatus = new Ui.Text({
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_TINY,
            :justification=>totallyCentered,
            :locX=>halfWidth,
            :locY=>secondRowY
        });

        _blueHeader = new Ui.Text({
            :text=>"Blue",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_TINY,
            :justification=>totallyCentered,
            :locX=>leftCentered,
            :locY=>thirdRowY
        });

        _redHeader = new Ui.Text({
            :text=>"Red",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_TINY,
            :justification=>totallyCentered,
            :locX=>rightCentered,
            :locY=>thirdRowY
        });

        _blue1Text = new Ui.Text({
            :color=>Graphics.COLOR_WHITE,
            :justification=>totallyCentered,
            :locX=>leftCentered,
            :locY=>cell1Text
        });

        _blue2Text = new Ui.Text({
            :color=>Graphics.COLOR_WHITE,
            :justification=>totallyCentered,
            :locX=>leftCentered,
            :locY=>cell2Text
        });

        _blue3Text = new Ui.Text({
            :color=>Graphics.COLOR_WHITE,
            :text=>"Blue3",
            //:color=>Graphics.COLOR_BLACK,
            :justification=>totallyCentered,
            :locX=>leftCentered,
            :locY=>cell3Text
        });

        _red1Text = new Ui.Text({
            :color=>Graphics.COLOR_WHITE,
            :justification=>totallyCentered,
            :locX=>rightCentered,
            :locY=>cell1Text
        });

        _red2Text = new Ui.Text({
            :color=>Graphics.COLOR_WHITE,
            :justification=>totallyCentered,
            :locX=>rightCentered,
            :locY=>cell2Text
        });

        _red3Text = new Ui.Text({
            :color=>Graphics.COLOR_WHITE,
            :justification=>totallyCentered,
            :locX=>rightCentered,
            :locY=>cell3Text
        });
        updateTimeAndBattery();
        updateTeams();
        drawUi(dc);
    }

    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        updateTimeAndBattery();
        updateTeams();
        drawUi(dc);
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

    private function updateTimeAndBattery() {
        var currentTime = System.getClockTime();
        var timeString = currentTime.hour.format("%02d") + ":" + currentTime.min.format("%02d");
        _timeView.setText(timeString);
        _batteryView.setText(System.getSystemStats().battery.format("%.0f") + "%");
        _matchStatus.setText(MatchState.getStatusString(_teamStatus.MatchStatus));
    }

    private function updateTeams() {
        if (_displayStatus == ViewStatus.TEAM_STATUS) {
            _blue1Text.setText(TeamStatus.getStatusString(_teamStatus.Blue1Status));
            _blue2Text.setText(TeamStatus.getStatusString(_teamStatus.Blue2Status));
            _blue3Text.setText(TeamStatus.getStatusString(_teamStatus.Blue3Status));
            _red1Text.setText(TeamStatus.getStatusString(_teamStatus.Red1Status));
            _red2Text.setText(TeamStatus.getStatusString(_teamStatus.Red2Status));
            _red3Text.setText(TeamStatus.getStatusString(_teamStatus.Red3Status));
        } else if (_displayStatus == ViewStatus.TEAM_NUMBER) {
            _blue1Text.setText(_teamStatus.Blue1Number.format("%d"));
            _blue2Text.setText(_teamStatus.Blue2Number.format("%d"));
            _blue3Text.setText(_teamStatus.Blue3Number.format("%d"));
            _red1Text.setText(_teamStatus.Red1Number.format("%d"));
            _red2Text.setText(_teamStatus.Red2Number.format("%d"));
            _red3Text.setText(_teamStatus.Red3Number.format("%d"));
        } else {
            _blue1Text.setText(TeamStatus.formatBattery(_teamStatus.Blue1Battery));
            _blue2Text.setText(TeamStatus.formatBattery(_teamStatus.Blue2Battery));
            _blue3Text.setText(TeamStatus.formatBattery(_teamStatus.Blue3Battery));
            _red1Text.setText(TeamStatus.formatBattery(_teamStatus.Red1Battery));
            _red2Text.setText(TeamStatus.formatBattery(_teamStatus.Red2Battery));
            _red3Text.setText(TeamStatus.formatBattery(_teamStatus.Red3Battery));
        }
    }

    private function drawUi(dc) {
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
        dc.clear();
        dc.fillRoundedRectangle(_blueCellStart, _thirdRowBackgroundYStart, _cellWidth, _thirdRowHeight, _radius);
        dc.fillRoundedRectangle(_blueCellStart, _cell1YStart, _cellWidth, _cellHeight, _radius);
        dc.fillRoundedRectangle(_blueCellStart, _cell2YStart, _cellWidth, _cellHeight, _radius);
        dc.fillRoundedRectangle(_blueCellStart, _cell3YStart, _cellWidth, _cellHeight, _radius);
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        dc.fillRoundedRectangle(_redCellStart, _thirdRowBackgroundYStart, _cellWidth, _thirdRowHeight, _radius);
        dc.fillRoundedRectangle(_redCellStart, _cell1YStart, _cellWidth, _cellHeight, _radius);
        dc.fillRoundedRectangle(_redCellStart, _cell2YStart, _cellWidth, _cellHeight, _radius);
        dc.fillRoundedRectangle(_redCellStart, _cell3YStart, _cellWidth, _cellHeight, _radius);
        _matchStatus.draw(dc);
        _blueHeader.draw(dc);
        _redHeader.draw(dc);
        _blue1Text.draw(dc);
        _blue2Text.draw(dc);
        _blue3Text.draw(dc);
        _red1Text.draw(dc);
        _red2Text.draw(dc);
        _red3Text.draw(dc);
        _timeView.draw(dc);
        _batteryView.draw(dc);
    }
}
