params ["_unit"];

#define SMALL_BLOOD ["BloodSplatter_01_Medium_New_F"]
#define LARGE_BLOOD ["BloodPool_01_Large_New_F"]

private _smallBloodPool = createVehicle [(selectRandom SMALL_BLOOD), getPosATL _unit, [], 0, "CAN_COLLIDE"];
_smallBloodPool setDir (random 360);

sleep 120;

private _largeBloodPool = createVehicle [(selectRandom LARGE_BLOOD), getPosATL _unit, [], 0, "CAN_COLLIDE"];
_largeBloodPool setDir (random 360);