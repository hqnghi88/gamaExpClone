#!/bin/bash
git_push(){
    echo "git push new change of parent pom"
    git config --global user.email "travis@travis-ci.com"
    git config --global user.name "hqnghi88"
    git config --global push.default simple
    git remote rm origin
    git remote add origin https://hqnghi88:$HQN_KEY@github.com/hqnghi88/gamaExpClone.git
    git add -A
    git commit -m "[ci skip] generate parent pom"
    git push origin HEAD:master
}

generate_parent_pom(){
    header=$(<msi.gama.experimental.parent/pom_header.xml)
    current_modules=$(<msi.gama.experimental.parent/pom_modules.xml)
    footer=$(<msi.gama.experimental.parent/pom_footer.xml)

    modules=$'\n'$"<modules>"$'\n'
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
    if [[ "$current_modules" != "$modules" ]]; then
        echo "$modules" > msi.gama.experimental.parent/pom_modules.xml
        echo " $header $modules $footer " > msi.gama.experimental.parent/pom.xml
        git_push
    fi
}
generate_p2updatesite_category(){
    header=$(<msi.gama.experimental.p2updatesite/category_header.xml)
    current_modules=$(<msi.gama.experimental.p2updatesite/category_body.xml)
    footer=$(<msi.gama.experimental.p2updatesite/category_footer.xml)

    cate=$'\n'$" "$'\n'
    for file in *; do 
      if [[ -d "$file" && ! -L "$file" ]]; then
        echo "$file is a directory"; 
        if [ -f "$file/pom.xml" ]; then
            echo "File $file/pom.xml found!"        
            
            if [[ ${file} == *"feature"* ]]; then	
                versions=($(grep -oP '(?<=versions>)[^<]+' "$file/pom.xml"))
                artifactIds=($(grep -oP '(?<=artifactIds>)[^<]+' "$file/pom.xml"))
                for i in ${!version[*]}
                do
                    echo "$i" "${artifactId[$i]}"
                    echo "$i" "${version[$i]}"
                    if [[ ${file} == ${artifactId[$i]} ]]; then	
                        q=".qualifier"
                        version=${version[$i]}
                        version=${version/-SNAPSHOT/$q}
                        echo "$version" 
                    fi
                done
             
                
            fi
        fi
      fi; 
    done

    modules="$modules </modules>"$'\n'
    echo $modules
}


//generate_parent_pom
generate_p2updatesite_category
