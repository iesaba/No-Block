#include <sourcemod>

public Plugin:myinfo =
{
	name        = "No Block",
	author      = "sslice (v1.1.0.0 by k725)",
	description = "Removes player collisions...useful for mod-tastic servers running surf maps, etc.",
	version     = "1.1.0.0",
	url         = ""
};

new g_offsCollisionGroup;

public OnPluginStart()
{
	g_offsCollisionGroup = FindSendPropOffs("CBaseEntity", "m_CollisionGroup");
	if (g_offsCollisionGroup == -1)
		PrintToServer("* FATAL ERROR: Failed to get offset for CBaseEntity::m_CollisionGroup");
	else
		HookEvent("player_spawn", OnSpawn, EventHookMode_Post);
}

public OnSpawn(Handle:event, const String:name[], bool:dontBroadcast)
{
	new userid = GetEventInt(event, "userid");
	new entity = GetClientOfUserId(userid);

	SetEntData(entity, g_offsCollisionGroup, 2, 4, true);
}
