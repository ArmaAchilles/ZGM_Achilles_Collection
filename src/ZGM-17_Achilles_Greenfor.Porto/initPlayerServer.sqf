params["_player"];
waitUntil {not isNull _player};
{_x addCuratorEditableObjects [[_player],true]} forEach allCurators;