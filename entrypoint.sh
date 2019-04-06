#!/bin/bash

# check for the environment variable GITHUB_EVENT_PATH
# if this variable is not zero length, then the entrypoint script is being
# run as a GitHub Action.
#
# GITHUB_EVENT_PATH contiains the path to the JSON data
# for the event that triggered the WorkFlow
#
# set EVENT_DATA_PATH = $GITHUB_EVENT_PATH
#
if [ ! -z "$GITHUB_EVENT_PATH" ];
then
    EVENT_PATH=$GITHUB_EVENT_PATH
#
# If the entrypoint script is not being run as an Action, check for
# a local file with sample data for testing.
#
# set EVENT_DATA_PATH = the local file with sample data
# set LOCAL_TEST = true so a release is not attempted
#
elif [ -f ./sample_push_event.json ];
then
    EVENT_PATH='./sample_push_event.json'
    LOCAL_TEST=true

#
# If no file is available for processing, exit with an error
#
else
    echo "No JSON data to process! :("
    exit 1
fi

echo "-----------------------------------------------------------"
echo "Processing $EVENT_PATH"
echo "-----------------------------------------------------------"

# check for the keyword in the event's commit messages
# use JQ to filter out the messages
# grep for the keyword in the messages found by JQ
# `grep -iq` tells grep to ignore case and operate in quiet mode
if $( jq '.commits[].message, .head_commit.message' < $EVENT_PATH  | grep -iq $* );
then
    VERSION=$(date +%F.%s)
    DATA=$(printf '{"tag_name":"v%s","target_commitish":"master","name":"v%s","body":"Automated release based on keyword: %s","draft":false,"prerelease":false}' $VERSION $VERSION "$*")
    URL="https://api.github.com/repos/${GITHUB_REPOSITORY}/releases?access_token=${GITHUB_TOKEN}"

    CMD="echo $DATA | http POST $URL | jq ."

    echo "Keyword = $*"
    echo
    echo "Version = $VERSION"
    echo
    echo "Data    = $DATA"
    echo
    echo "URL     = $URL"
    echo
    echo "CMD     = $CMD"

    if [ LOCAL_TEST="true" ];
    then
        echo
        echo "##"
        echo "## [TESTING] No release was created."
        echo "##"
        echo
    else
        $CMD
    fi
else
    echo "Not creating a release because The following keyword was not present: $*"
fi
