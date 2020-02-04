# overlap-copy

 The purpose of this project is to allow handling of a large number of files, where naming 
 is not important (for now), while preventing overlapping file names. 


## Cloning

 As submodules are used to handle the libraries used, a recursive clone needs to be used.

```
git clone --recursive https://github.com/jorderator/overlap-copy.git
```

 After cloning, updates should be pulled with a special pull command too. As well as this,
 if new submodules have been added, they will need to be initialised, however this will often
 not be necessary.

```
git pull --recurse-submodules
git submodule update --init
```

 Lastly, the luarocks module `luafilesystem` is used, so that will need to be installed, and 
 luarocks configured, to enable it to work. This will vary according to the developer and 
 how they have luarocks configured, but for reference, I have `luafilesystem` installed 
 globally, with the following line in my `.bashrc` file adding luarocks directories to the 
 path variables.

```
eval "$(luarocks path)"
```


## Intended usage

 Initially it is run over a directory, to 'initialise' it to numbered file names. From there, 
 it can be run akin to a copy command, to take all the files from `source` directory, and add
 them, sorted, to `target` directory. It can also be rerun over the same directory, if files 
 have been added directly, appending those files to the list.
 
