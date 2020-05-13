#include "paramDefault.hpp"

params ["_unit", "_old_body"];
// add new unit to curator
if (isNil "bis_curatorUnit" or {_unit != bis_curatorUnit}) then
{
	[[_unit], {{_x addCuratorEditableObjects [_this,true]} forEach allCurators}] remoteExecCall ["call", 2];
};