#!/usr/bin/env python3

import json
import os
import platform
import re
import shutil
import subprocess
import sys

FOLDER_PREFIX = 'ZGM-21_Zeus_Enhanced'
IMAGE_NAME_PREFIX = 'zen'
NAME_PREFIX = 'Zeus 20+1 Zeus Enhanced'

TEMPLATE_FOLDER = FOLDER_PREFIX + '_Blufor.Altis'
TEMPLATE_IMAGE_NAME = IMAGE_NAME_PREFIX + '_blufor'
TEMPLATE_EXT_MISSION_NAME = NAME_PREFIX + ' Altis'
TEMPLATE_SQM_MISSION_NAME = NAME_PREFIX + ' Altis (BLUFOR)'
TEMPLATE_SIDE = 'WEST'
TEMPLATE_SOLDIER = 'B_Soldier_F'

SIDE_NAMES = ['blufor', 'opfor', 'greenfor']
SIDES = ['WEST', 'EAST', 'GUER']
SOLDIERS = ['B_Soldier_F', 'O_Soldier_F', 'I_Soldier_F']

map_keys = []
map_names = []


def get_map_keys_and_names():
    with open('mapWhitelist.json') as f:
        whitelist = json.load(f)

        for map_key in whitelist:
            map_keys.append(map_key)
            map_names.append(whitelist[map_key])


def generate_mission(armake: str, side_index: int, map_index: int):
    side = SIDES[side_index]
    side_name = SIDE_NAMES[side_index]
    side_capitalized = side_name.capitalize()
    side_upper = side_name.upper()

    map_key = map_keys[map_index]
    map_name = map_names[map_index]

    image_name = f'{IMAGE_NAME_PREFIX}_{side_name}'
    ext_mission_name = f'{NAME_PREFIX} {map_name}'
    sqm_mission_name = f'{ext_mission_name} ({side_upper})'

    soldier = SOLDIERS[side_index]

    pbo_name = f'{FOLDER_PREFIX}_{side_capitalized}.{map_key}'

    dir_tmp = os.path.join('./tmp', pbo_name)
    dir_src = os.path.join('./src')

    print('Generating {}'.format(pbo_name))

    if pbo_name != TEMPLATE_FOLDER:
        # Copy the template
        shutil.copytree(os.path.join(dir_src, TEMPLATE_FOLDER), dir_tmp)

        # Change the image to the right one
        os.remove(os.path.join(dir_tmp, 'images',
                               f'{TEMPLATE_IMAGE_NAME}.paa'))
        shutil.copy(os.path.join(dir_src, 'images', f'{image_name}.paa'),
                    os.path.join(dir_tmp, 'images', f'{image_name}.paa'))

        # Update description.ext
        with open(os.path.join(dir_tmp, 'description.ext'), 'r+') as f:
            content = f.read()

            content = re.sub(re.escape(TEMPLATE_EXT_MISSION_NAME),
                             ext_mission_name, content)
            content = re.sub(TEMPLATE_IMAGE_NAME, image_name, content)

            f.seek(0)
            f.write(content)

        # Update mission.sqm
        with open(os.path.join(dir_tmp, 'mission.sqm'), 'r+') as f:
            content = f.read()

            content = re.sub(re.escape(TEMPLATE_SQM_MISSION_NAME),
                             sqm_mission_name, content)
            content = re.sub(TEMPLATE_SOLDIER, soldier, content)
            content = re.sub(TEMPLATE_SIDE, side, content)

            f.seek(0)
            f.write(content)
    else:
        shutil.copytree(os.path.join(dir_src, pbo_name), dir_tmp)

    # Append to the mission whitelist
    try:
        with open('missionWhitelist.dat', 'a') as f:
            comma = ''

            if len(SIDES) != side_index and len(map_keys) != map_index:
                comma = ','

            f.write(f'"{pbo_name}"{comma}\n')
    except FileNotFoundError:
        with open('missionWhitelist.dat', 'w') as f:
            f.write(f'"{pbo_name}",\n')

    subprocess.call([armake, 'build', '-p', dir_tmp,
                     os.path.join('dist', f'{pbo_name}.pbo')])


def main():
    root_dir = '..'
    if os.path.exists('src'):
        root_dir = '.'

    os.chdir(root_dir)

    get_map_keys_and_names()

    # Clear the tmp dir
    if os.path.isdir('./tmp'):
        shutil.rmtree('./tmp')
    os.mkdir('./tmp')

    # Clear the dist dir
    if os.path.isdir('./dist'):
        shutil.rmtree('./dist')
    os.mkdir('./dist')

    if os.path.isfile('./missionWhitelist.dat'):
        os.remove('./missionWhitelist.dat')

    os_platform = platform.system()

    if os_platform == 'Windows':
        armake = './tools/armake.exe'
    elif os_platform == 'Linux':
        armake = './tools/armake'
    elif os_platform.startswith('CYGWIN'):
        armake = './tools/armake.exe'
    else:
        raise OSError('Unable to build the PBOs for your platform.')

    # Generate all the pbos into a tmp folder
    for side_index in range(len(SIDES)):
        for map_index in range(len(map_keys)):
            generate_mission(armake, side_index, map_index)

    shutil.rmtree('./tmp')


if __name__ == '__main__':
    sys.exit(main())
