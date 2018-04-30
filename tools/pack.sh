#!/usr/bin/env bash
# Generates all maps from the template map and packs them as PBOs

# switch to project root
cd ..
# create the pbo and tmp folders if they do not yet exist
mkdir -p pbo
mkdir -p tmp

# Define template params
export template_folder="ZGM-17_Achilles_Blufor.Altis"
export template_image_name="achilles_blufor"
export template_ext_mission_name="Zeus 16+1 Achilles Altis"
export template_sqm_mission_name="Zeus 16+1 Achilles Altis (BLUFOR)"
export template_side="WEST"
export template_soldier="B_Soldier_Universal_F"

# Define general params
export folder_prefix=ZGM-17_Achilles
export image_name_prefix=achilles
export name_prefix="Zeus 16+1 Achilles"

# Define side related array params
side_name_list=(blufor opfor greenfor)
side_list=(WEST EAST GUER)
soldier_list=(B_Soldier_Universal_F O_Soldier_Universal_F I_Soldier_Universal_F)
# import map list
map_name_list=($(cat mapWhitelist.dat | awk '{print $1}'))
map_postfix_list=($(cat mapWhitelist.dat | awk '{print $2}'))
# this is a workaround for the issue that arrays cannot be exported in bash
>tmp/.import_arrays
declare -p map_name_list >> tmp/.import_arrays
declare -p map_postfix_list >> tmp/.import_arrays
declare -p side_name_list >> tmp/.import_arrays
declare -p side_list >> tmp/.import_arrays
declare -p soldier_list >> tmp/.import_arrays

# Define packing function
# Creates a new mission from the template mission with at least a different faction or a different map
function Achilles_Bash_fnc_genMission {
	i_side=$1
	i_map=$2
	
	# this is a workaround for the issue that arrays cannot be exported in bash
	source tmp/.import_arrays
	# define names and paths
	map_name=${map_name_list[$i_map]//_/ }
	map_postfix=${map_postfix_list[$i_map]}
	image_name=${image_name_prefix}_${side_name_list[$i_side]}
	ext_mission_name="${name_prefix} ${map_name}"
	sqm_mission_name="${ext_mission_name} (${side_name_list[$i_side]^^})"
	folder_name="${folder_prefix}_${side_name_list[$i_side]^}.${map_postfix}"
	if [ $folder_name != $template_folder ]; then
		echo "Generating and packing $folder_name ..."
		cp -rT src/$template_folder tmp/$folder_name
		rm -f tmp/$folder_name/images/$template_image_name.jpg
		cp src/images/$image_name.jpg tmp/$folder_name/images/.
		sed -i "s|${template_ext_mission_name}|${ext_mission_name}|; s|${template_image_name}|$image_name|" tmp/$folder_name/description.ext
		sed -i "s|${template_sqm_mission_name}|${sqm_mission_name}|; s|${template_side}|${side_list[$i_side]}|; s|${template_soldier}|${soldier_list[$i_side]}|" tmp/$folder_name/mission.sqm
	fi
	AddonBuilder "$(cygpath -w "$PWD/tmp/$folder_name")" "$(cygpath -w "$PWD/pbo")" "-temp=$(cygpath -w "$PWD/tmp")" 1>/dev/null 2>&1
}
export -f Achilles_Bash_fnc_genMission

# pack the template mission
AddonBuilder "$(cygpath -w "$PWD/src/$template_folder")" "$(cygpath -w "$PWD/pbo")" "-temp=$(cygpath -w "$PWD/src")" 1>/dev/null 2>&1
echo "Packing $template_folder ..."
# generate all other missions from the template mission
for i_side in "${!side_name_list[@]}"; do
	printf "%s\n" ${!map_name_list[@]} | xargs -i --max-procs=4 bash -c "Achilles_Bash_fnc_genMission $i_side {}"
done
# updating mission whitelist
cd tools
./.createMissionWhitelist.sh
./.collectVanillaPBOs.sh
echo Procedure completed!
