# submodule_ln.sh
#!/bin/bash

CURRENT_DIR=$(pwd)
SUBMODULE_PATH="packages/web-target"
LINK_PATH="$CURRENT_DIR/packages/app/src" 
REPO_URL="git@github.com:yongheng2016/src-bex.git"
LINK_SOURCE="$CURRENT_DIR/$SUBMODULE_PATH/src" 

if git config --file .gitmodules --get-regexp "submodule\.$SUBMODULE_PATH\.url" | grep -q "$REPO_URL"; then
    echo "The submodule already exists, skip adding it."
else
    echo "Add submodule..."
    git submodule add "$REPO_URL" "$SUBMODULE_PATH"
    echo "The submodule is added."
fi

if [ -d "$LINK_SOURCE" ]; then
    while true; do
        if [ ! -L "$LINK_PATH" ]; then
            ln -s "$LINK_SOURCE" "$LINK_PATH"
            echo "A soft connection is created: $LINK_PATH -> $LINK_SOURCE"
            break 
        else
            echo "The soft connection already exists: $LINK_PATH, skip creating it."
            break  
        fi
        sleep 2 
    done
else
    echo "Error: submodule path does not exist: $LINK_SOURCE"
fi
