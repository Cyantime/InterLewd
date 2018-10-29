/datum/preferences
	var/has_dong = 0
	var/dong_size = 0
	var/has_vag = 0

/datum/category_item/player_setup_item/lewd
	name = "Lewd"
	sort_order = 7

/datum/category_item/player_setup_item/lewd/load_character(var/savefile/S)
	S["has_dong"]			>> pref.has_dong
	S["dong_size"]			>> pref.dong_size
	S["has_vag"]			>> pref.has_vag

/datum/category_item/player_setup_item/lewd/save_character(var/savefile/S)
	S["has_dong"]			<< pref.has_dong
	S["dong_size"]			<< pref.dong_size
	S["has_vag"]			<< pref.has_vag

/datum/category_item/player_setup_item/lewd/sanitize_character(var/savefile/S)
	pref.has_dong	 = sanitize_bool(pref.has_dong, initial(pref.has_dong))
	pref.dong_size	 = sanitize_integer(pref.dong_size, 0, 35, initial(pref.dong_size))
	pref.has_vag	 = sanitize_bool(pref.has_vag, initial(pref.has_vag))

/datum/category_item/player_setup_item/lewd/content()
	. = list()
	. += "Has a penis? <a href='?src=\ref[src];toggle_dong=1'>[pref.has_dong?"Yes.":"No."]</A><br>"
	. += "Penis Length: <a href='?src=\ref[src];set_dong_size=1'>[pref.dong_size?"[pref.dong_size] cm.":"Random."]</a><br>"
	. += "Has a vagina? <a href='?src=\ref[src];toggle_vag=1'>[pref.has_vag?"Yes.":"No."]</A><br>"
	. = jointext(.,null)

/datum/category_item/player_setup_item/lewd/OnTopic(var/href,var/list/href_list, var/mob/user)
	if(href_list["toggle_dong"])
		pref.has_dong = !pref.has_dong
		return TOPIC_REFRESH

	if(href_list["set_dong_size"])
		var/new_size = input(user, "Choose your character's penis length in centimeters:\n(0 for random length)", "Character Preference", pref.dong_size) as num|null
		if(isnum(new_size) && CanUseTopic(user))
			pref.dong_size = max(min(round(text2num(new_size)), 35), 0)
			return TOPIC_REFRESH

	if(href_list["toggle_vag"])
		pref.has_vag = !pref.has_vag
		return TOPIC_REFRESH