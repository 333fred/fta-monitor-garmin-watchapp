using Toybox.WatchUi as Ui;

class ftamonitorgarminwatchappDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new ftamonitorgarminwatchappMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }

}