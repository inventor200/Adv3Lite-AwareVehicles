/* 
 * Aware Vehicles
 * by Joseph Cramsey
 * (Compatible with Adv3Lite only!)
 */

class CoveredVehicle: Thing {
    isEnterable = true
    isVehicle = true
    stagingLocation = (location)
    contType = In
}

class EnclosedVehicle: Thing {
    isEnterable = true
    isVehicle = true
    stagingLocation = (location)
    contType = In
    isOpenable = true
}

class RidableVehicle: Thing {
    isBoardable = true
    isVehicle = true
    stagingLocation = (location)
    contType = On
}

modify Room {
    statusName(actor) {
        local nestedLoc = '';
        local vehicleLoc = '';

        local traveler = actor;
        local potentialVehicle = actor.location;
        while(potentialVehicle != nil && !potentialVehicle.ofKind(Room)) {
            if(potentialVehicle.isVehicle) {
                traveler = potentialVehicle;
                break;
            }
            potentialVehicle = potentialVehicle.location;
        }

        if (!actor.location.ofKind(Room)) {
            nestedLoc =
                ' (<<actor.location.objInPrep>> <<actor.location.theName>>)';
        }

        if (traveler != actor) {
            if (!traveler.location.ofKind(Room)) {
                vehicleLoc =
                    ' (<<traveler.location.objInPrep>> <<traveler.location.theName>>)';
            }
        }

        if(isIlluminated) {
            "<<roomTitle>><<nestedLoc>><<vehicleLoc>>";
        }
        else {
            "<<darkName>><<nestedLoc>><<vehicleLoc>>";
        }
    }
}