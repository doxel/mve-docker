# mve-docker

Run MVE related commands in docker containers.

[MVE](https://github.com/simonfuhrmann/mve) and related projects [SMVS](https://github.com/flanggut/smvs), [PoissonRecon](https://github.com/mkazhdan/PoissonRecon), [mvs-texturing](https://github.com/nmoehrle/mvs-texturing)

Copyright (C) 2018 [Alsenet SA](http://www.alsenet.com)
                     
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
                     
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.
                 
You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

## BUILD
```
make
```

## INSTALL
```
PREFIX=$HOME make install
```

## USE

See available commands with:
```
docker run -it --rm mve-docker ls bin
```

For example:
```
smvsrecon <param> ...
```
or:
```
DOCKER_OPTIONS="-v /mnt:/mnt -it --rm=true" smvsrecon <param> ...
```

## NOTES
You can set various docker-run options using DOCKER_OPTIONS environment variable ie: --cpus 0.5

Default docker-run options are:
```
DOCKER_OPTIONS="-v /mnt:/mnt -it --rm=true"
```

