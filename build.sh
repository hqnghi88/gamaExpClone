#!/bin/bash
modules = "<modules>\n"
for file in *; do 
  if [[ -d "$file" && ! -L "$file" ]]; then
    echo "$file is a directory"; 
    if [ -f "$file/pom.xml" ]; then
        echo "File $file/pom.xml found!"        
        modules="$modules <module>$file/pom.xml</module>\n"
    fi
  fi; 
modules="$modules </modules>"
echo $modules
done
