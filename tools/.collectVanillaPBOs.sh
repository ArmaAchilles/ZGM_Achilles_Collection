#!/usr/bin/env bash
folder_prefix=ZGM-17_Achilles
map_name_list=(Altis Stratis Tanoa Malden)
map_postfix_list=(Altis Stratis Tanoa Malden)
side_name_list=(blufor opfor greenfor)

cd ../pbo/
mkdir -p vanilla
for i_map in "${!map_name_list[@]}"; do
	for i_side in "${!side_name_list[@]}"; do
		folder_name="${folder_prefix}_${side_name_list[$i_side]^}.${map_postfix_list[$i_map]}.pbo"
		cp $folder_name vanilla/.
	done
done
