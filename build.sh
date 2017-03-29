#!/bin/bash
header=$(<msi.gama.experimental.parent/pom_header.xml)
echo "$header"
footer=$(<msi.gama.experimental.parent/pom_header.xml)
echo "$footer"
modules=$"<modules>"$'\n'
for file in *; do 
  if [[ -d "$file" && ! -L "$file" ]]; then
    echo "$file is a directory"; 
    if [ -f "$file/pom.xml" ]; then
        echo "File $file/pom.xml found!"        
        modules="$modules <module>../$file</module> "$'\n'
    fi
  fi; 
done

modules="$modules </modules>"$'\n'
echo $modules
echo $modules > msi.gama.experimental.parent/pom_modules.xml
cat $header $modules $footer > msi.gama.experimental.parent/pom.xml
