#!/bin/sh

user_rules="rules/user"
system_rules="rules/system"
pre_install_folder="_pre"
post_install_folder="_post"

# detect if something has changed
changed=""

base_folder=$(dirname $(realpath $0))

# only perform actions when called inside the script folder
if [[ "$(pwd)" != "$(dirname $(realpath $0))" ]]; then
    echo "please run this script inside $(dirname $(realpath $0))"
    exit 1
fi

safe_diff(){
    link=$1
    target=$2
    ret="X"
    if [[ -f $link ]]; then
        ret=$(diff $target $link)
    fi  
    echo "$ret"
}

make_link(){
    target=$1
    link=$2
    ln -f $target $link ||
        (echo "FAILED physical link, making symbolic link..." &&
        ln -s $target $link ||
            (sudo ln -s $target $link) || true)
}

install_to() {
    dst_folder="$1"
    src_folder="$base_folder/$2"

    # Attempt mkdir of the destination folder if it not exixst
    if [[ ! -d $dst_folder ]]; then
        echo "MISSING: $dst; attempting mkdir"
        echo "mkdir -p $dst"
    fi

    for file in $src_folder/*; do
        #get target and link full path
        target="$src_folder/$(basename $file)"
        link="$dst_folder/$(basename $file)"
        file_different=$(safe_diff $link $target)
        if [[ -n "$file_different" ]]; then
           make_link $target $link
           changed="X"
        fi
    done
}

# Run all the scripts inside the specified folder
run_folder() {
    folder=$1
    for file in $folder/*; do
        if [[ -f $file ]]; then
	    echo "Running $file"
            chmod 755 $file
            ./$file
        fi;
    done
}

user_install() {
    links_file=$1
    dst_prefix=$2
    if [[ -n "$2" ]]; then
        dst_prefix="$2/"
    fi
    while read line; do
        if [[ -n $line ]]; then
            src="$(echo $line | awk '{print $1}')"
            dst="$dst_prefix$(echo $line | awk '{print $2}')"
            echo "Installing all from $src to $dst"
            install_to $dst $src
        fi
    done < "$links_file"
}

# Run all the pre-install script
run_folder $pre_install_folder

# May be needed to not exclude some files
shopt -s dotglob

echo "==user config=="
user_install $user_rules "$HOME"

echo "==syst config=="
user_install $system_rules ""

# Only run postscript if some file has changed
if [[ -n $changed ]]; then
    run_folder $post_install_folder
fi
