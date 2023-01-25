# Aware Vehicles for Adv3Lite
This extension goes right into your TADS 3 Adv3Lite project folder.
You can include it with the following line:

```
#include "awareVehicles.t"
```

## Disclaimer
This extension **does not** add functionality to vehicles to allow them to travel onto platforms.
***However***, should a vehicle ever find itself so capable, this extension *does* provide a clearer method of showing its position in the status bar.

## Helpers
This extension adds a few extra helper classes for creating new vehicles:
1. `GenericVehicle`: A vehicle that assumes nothing about how control is assumed (boarding vs entering vs other).
2. `CoveredVehicle`: A vehicle that someone can ENTER, which is assumed to not open or close.
3. `EnclosedVehicle`: A `CoveredVehicle` which can open and close.
4. `RidingVehicle`: A vehicle that someone can BOARD.

## Location Reporting
Another feature of this extension is a small change to the status string of a room.
In addition to showing the player being in a vehicle in a room, the location of the vehicle is also listed.
This is to accomodate vehicles which have a wide degree of maneuverability, such as a horse or exo-suit.

**For example, let's say the player on a horse, on a stage, in a room (called the "Showroom").**

Normally, the status bar would show something like:
>**Showroom (on the horse)**

With the Aware Vehicles extension, you will instead see something like:
>**Showroom (on the horse) (on the stage)**

## Compatibility
For those who are overriding or modify the `statusName(actor)` method of a `Room`, ***it is advised to include this extension before any project code which might override the aforementioned method***.
This extension stays as close as possible to the original functionality of the method, so it will undo any modifications to `Room.statusName(actor)`, if `awareVehicles.t` is included *last*.

## Custom Messages and Modification
This extension is ***not*** compatible with custom messages, but provides options to provide *more* flexibility than custom messages.

Location-based status messages can be altered by modifying the following object:
```
modify awareVehicleCache {
    ...
}
```

**The following properties are provided for printing modification:**

- `showVehiclePosition`: (default = `true`) This detemines if vehicle locations are listed in addition to the player's position. By setting this to `nil`, it effectively disables the primary function of this extention. (This is only checked if `showVehicleOnFloorOnly` is set to `nil`.)
- `showVehicleOnFloorOnly`: (default = `nil`) If this is set to `true`, then the status bar only shows **one** additional location. If the player is aboard a vehicle, then the vehicle's position will be printed, ***unless the vehicle is on the floor***, in which case the player's position aboard the vehicle will be printed instead. (If the player is not aboard a vehicle, then locations are printed as normal.)
- `useStackedPositions`: (default = `true`) If this is set to `true`, then position is printed with `stackedStatusMsg`, in situations where the player is aboard a vehicle, which is also not on the floor of a room. This merges player position messages and vehicle position messages into a single string, for neatness. If this is set to `nil`, then player position and vehicle position are always printed in two separate strings. (This is only checked if `showVehicleOnFloorOnly` is set to `nil`.)

**The following properties are provided for string modification:**

- `actorStatusMsg`: The string which contains the player's position, when not simply standing on the floor of a room. By default, it is evaluated from the following sequence of secondary string properties:
 - `actorStatusPrefix` (default = `(' (')`)
 - `actorPrep` (default = `(actor.location.objInPrep)`)
 - `actorStatusDivider` (default = `(' ')`)
 - `actorLoc` (default = `(actor.location.theName)`)
 - `actorStatusSuffix` (default = `(')')`)
- `vehicleStatusMsg`: The string which contains the vehicle's position, when not simply resting on the floor of a room. By default, it is evaluated from the following sequence of secondary string properties:
 - `vehicleStatusPrefix` (default = `(' (')`)
 - `vehiclePrep` (default = `(vehicle.location.objInPrep)`)
 - `vehicleStatusDivider` (default = `(' ')`)
 - `vehicleLoc` (default = `(vehicle.location.theName)`)
 - `vehicleStatusSuffix` (default = `(')')`)
- `stackedStatusMsg`: The string which contains a combination of the player's position, and the vehicle's position (when applicable). By default, it is evaluated from the following sequence of secondary string properties:
 - `actorStatusPrefix` (default = `(' (')`)
 - `actorPrep` (default = `(actor.location.objInPrep)`)
 - `actorStatusDivider` (default = `(' ')`)
 - `actorLoc` (default = `(actor.location.theName)`)
 - `stackedDivider` (default = `(', which is ')`)
 - `vehiclePrep` (default = `(vehicle.location.objInPrep)`)
 - `vehicleStatusDivider` (default = `(' ')`)
 - `vehicleLoc` (default = `(vehicle.location.theName)`)
 - `vehicleStatusSuffix` (default = `(')')`)
