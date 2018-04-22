#!/usr/bin/env bash
# creates map list

# switch to project root
cd ..
# clear file
> mapWhitelist.dat
map_name_list=(Altis Stratis Tanoa Malden Bukovina Bystrica Chernarus Chernarus_Summer Desert Desert_Island Everon Kolgujev Malden Nogova Porto Proving_Grounds Rahmadi Sahrani Shapur Southern_Sahrani Takistan Takistan_Mountains United_Sahrani Utes Zargabad)
map_postfix_list=(Altis Stratis Tanoa Malden Bootcamp_ACR Woodland_ACR Chernarus Chernarus_Summer Desert_E Desert_Island eden cain abel noe Porto ProvingGrounds_PMC Intro Sara Shapur_BAF SaraLite Takistan Mountains_ACR Sara_dbe1 Utes Zargabad)
for i in "${!map_name_list[@]}"; do
	printf "%-20s%s\n" ${map_name_list[$i]} ${map_postfix_list[$i]} >> mapWhitelist.dat
done
mkdir -p tmp
sort mapWhitelist.dat > tmp/mapWhitelist.dat
mv tmp/mapWhitelist.dat mapWhitelist.dat
rm -r tmp
