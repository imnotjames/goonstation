/datum/component/death_confetti
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/confetti_mode = null

/datum/component/death_confetti/Initialize(var/confetti_mode = null)
	if(!istype(parent, /atom/movable))
		return COMPONENT_INCOMPATIBLE

	src.confetti_mode = confetti_mode

	RegisterSignal(parent, COMSIG_OBJ_CRITTER_DEATH, .proc/the_confetti)
	RegisterSignal(parent, COMSIG_MOB_DEATH, .proc/the_confetti)
	RegisterSignal(parent, COMSIG_MOB_FAKE_DEATH, .proc/the_confetti)

/datum/component/death_confetti/proc/the_confetti()
	var/atom/movable/AM = parent
	var/turf/T = get_turf(AM)

	if (confetti_mode == "mentor")
		particleMaster.SpawnSystem(new /datum/particleSystem/confetti/question(T))
	else
		particleMaster.SpawnSystem(new /datum/particleSystem/confetti(T))
	SPAWN_DBG(1 SECOND)
		playsound(T, "sound/voice/yayyy.ogg", 50, 1)

/datum/component/death_confetti/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_OBJ_CRITTER_DEATH)
	UnregisterSignal(parent, COMSIG_MOB_DEATH)
	UnregisterSignal(parent, COMSIG_MOB_FAKE_DEATH)
	. = ..()
