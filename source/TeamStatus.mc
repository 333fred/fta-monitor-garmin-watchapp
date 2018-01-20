class TeamStatusManager {
    // All variables are of type TeamStatus
    public var Blue1;
    public var Blue2;
    public var Blue3;

    public var Red1;
    public var Red2;
    public var Red3;

    function initialize() {
        Blue1 = TeamStatus.ETH;
        Blue2 = TeamStatus.ETH;
        Blue3 = TeamStatus.ETH;
        Red1 = TeamStatus.ETH;
        Red2 = TeamStatus.ETH;
        Red3 = TeamStatus.ETH;
    }
}

module TeamStatus {
    enum {
        ETH = 0,
        DS = 1,
        RADIO = 2,
        RIO = 3,
        CODE = 4,
        ESTOP = 5,
        GOOD = 6,
        BWU = 7,
        BYP = 8,
        BAT = 9
    }

    function getStatusString(status) {
        switch (status) {
            case ETH:
                return Rez.Strings.ethernet;
            case DS:
                return Rez.Strings.driverstation;
            case RADIO:
                return Rez.Strings.radio;
            case RIO:
                return Rez.Strings.rio;
            case CODE:
                return Rez.Strings.code;
            case ESTOP:
                return Rez.Strings.estop;
            case GOOD:
                return Rez.Strings.good;
            case BWU:
                return Rez.Strings.bandwidth;
            case BYP:
                return Rez.Strings.bypassed;
            case BAT:
                return Rez.Strings.battery;
        }
    }
}
