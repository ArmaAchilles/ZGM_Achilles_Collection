template_folder="ZGM-17_Achilles_Blufor.Altis"
side_name_list=(blufor opfor greenfor)
map_name_list=(Altis Stratis Tanoa Malden Bukovina Bystrica Chernarus Chernarus_Summer Desert Desert_Island Everon Kolgujev Malden Nogova Porto Proving_Grounds Rahmadi Sahrani Shapur Southern_Sahrani Takistan Takistan_Mountains United_Sahrani Utes Zargabad)


function Achilles_Bash_fnc_genMission {
	i_side=$1
	i_map=$2

	template_folder="ZGM-17_Achilles_Blufor.Altis"
	template_image_name="achilles_blufor"
	template_ext_mission_name="Zeus 16+1 Achilles Altis"
	template_sqm_mission_name="Zeus 16+1 Achilles Altis (BLUFOR)"
	template_side="WEST"
	template_soldier="B_Soldier_Universal_F"

	folder_prefix=ZGM-17_Achilles
	image_name_prefix=achilles
	name_prefix="Zeus 16+1 Achilles"
	map_name_list=(Altis Stratis Tanoa Malden Bukovina Bystrica Chernarus Chernarus_Summer Desert Desert_Island Everon Kolgujev Malden Nogova Porto Proving_Grounds Rahmadi Sahrani Shapur Southern_Sahrani Takistan Takistan_Mountains United_Sahrani Utes Zargabad)
	map_postfix_list=(Altis Stratis Tanoa Malden Bootcamp_ACR Woodland_ACR Chernarus Chernarus_Summer Desert_E Desert_Island eden cain abel noe Porto ProvingGrounds_PMC Intro Sara Shapur_BAF SaraLite Takistan Mountains_ACR Sara_dbe1 Utes Zargabad)
	side_name_list=(blufor opfor greenfor)
	side_list=(WEST EAST GUER)
	soldier_list=(B_Soldier_Universal_F O_Soldier_Universal_F I_Soldier_Universal_F)

	map_name=${map_name_list[$i_map]//_/ }
	map_postfix=${map_postfix_list[$i_map]}
	image_name=${image_name_prefix}_${side_name_list[$i_side]}
	ext_mission_name="${name_prefix} ${map_name}"
	sqm_mission_name="${ext_mission_name} (${side_name_list[$i_side]^^})"
	folder_name="${folder_prefix}_${side_name_list[$i_side]^}.${map_postfix}"
	if [ $folder_name != $template_folder ]; then
		rm -r -f $folder_name
		echo Generating $folder_name ...
		cp -r $template_folder $folder_name
		cd $folder_name
		rm -f images/$template_image_name.jpg
		cp ../images/$image_name.jpg images/.
		sed -i "s|${template_ext_mission_name}|${ext_mission_name}|; s|${template_image_name}|$image_name|" description.ext
		sed -i "s|${template_sqm_mission_name}|${sqm_mission_name}|; s|${template_side}|${side_list[$i_side]}|; s|${template_soldier}|${soldier_list[$i_side]}|" mission.sqm
		cd ..
	fi
	nohup AddonBuilder "$(cygpath -w "$PWD/$folder_name")" "$(cygpath -w "$PWD/../pbo")" -temp="$(cygpath -w "$PWD")"
}
export -f Achilles_Bash_fnc_genMission

rm -f "tmp/*"
nohup AddonBuilder "$(cygpath -w "$PWD/$template_folder")" "$(cygpath -w "$PWD/../pbo")" -temp="$(cygpath -w "$PWD")"

for i_side in "${!side_name_list[@]}"; do
	printf "%s\n" ${!map_name_list[@]} | xargs -i --max-procs=4 bash -c "Achilles_Bash_fnc_genMission $i_side {}"
done
echo Procedure completed!
