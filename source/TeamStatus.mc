class TeamStatusManager {
    // All variables are of type TeamStatus
    public var Blue1Status;
    public var Blue2Status;
    public var Blue3Status;

    public var Red1Status;
    public var Red2Status;
    public var Red3Status;

    public var Blue1Number;
    public var Blue2Number;
    public var Blue3Number;

    public var Red1Number;
    public var Red2Number;
    public var Red3Number;

    function initialize() {
        Blue1Status = TeamStatus.ETH;
        Blue2Status = TeamStatus.ETH;
        Blue3Status = TeamStatus.ETH;
        Red1Status = TeamStatus.ETH;
        Red2Status = TeamStatus.ETH;
        Red3Status = TeamStatus.ETH;

        Blue1Number = 1;
        Blue2Number = 2;
        Blue3Number = 3;
        Red1Number = 4;
        Red2Number = 5;
        Red3Number = 6;
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
