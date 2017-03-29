#!/bin/bash
header=$(<msi.gama.experimental.parent/pom_header.xml)

footer=$(<msi.gama.experimental.parent/pom_header.xml)

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
echo " $header $modules $footer " > msi.gama.experimental.parent/pom.xml


git config --global push.default simple
git remote rm origin
git remote add origin https://hqnghi88:$HQN_KEY@github.com/hqnghi88/gamaExpClone.git
git add -A
git commit -m "[ci skip] generate parent pom"
git push origin HEAD:master
