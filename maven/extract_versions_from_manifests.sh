#!/bin/bash

function _extract_version_from_manifest () {

    line_with_version="<artifact "

    while read line
    do

        if [[ $line =~ $line_with_version ]]; then

            project=${line##*projectName=\"}
            project=${project%%\"*}

            if [ "$project" == "\${project.name}" ]; then
                project=${line##*artifactId=\"}
                project=${project%%\"*}
            fi

            version=${line##*version=\"}
            version=${version%%\"*}

            echo "$project : $version"

            break
        fi

    done < $1

}

for i in $(find . -name "*manifest*")
do
    _extract_version_from_manifest "$i"
done

exit 0

