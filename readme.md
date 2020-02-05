# overlap-copy

 The purpose of this project is to allow handling of a large number of files, where naming 
 is not important (for now), while preventing overlapping file names. 

 Currently, this project is only developed for linux. It is being developed with future use
 on other systems in mind, but nothing has been tested yet, and won't be just yet either, 
 so there are no promises. 


## Cloning

 As submodules are used to handle the libraries in this project, a recursive clone needs to 
 be used.

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
 

## Known issues

 In one folder I use this on, with a large number of image files, after a period of use I
 looked through, and found a sequence of images that had been in order for the first few 
 uses, now split up and in incorrect order. I am unsure what circumstances cause this to 
 happen, and have been unsuccessful in recreating the behaviour. Any further information
 regarding this would be greatly appreciated. 

 As well as this, files with an extension greater than three characters will cause 
 unintended behaviour. I plan to fix this soon, but it is not high priority yet.
 
 If more than 999,999 files are being handled, there will also be unintended behaviour,
 as the number exceeds the default length of the zeroes used to ensure correct ordering.
 My next goal is to implement options with values in the arg-handler library, which will
 allow setting the amount of zeroes to use at runtime, to avoid this issue.
