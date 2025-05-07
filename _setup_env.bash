# This is meant to be sourced from other scripts.

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
STUDY_DIR="$(realpath "${SCRIPT_DIR}"/..)"
STUDY_NAME="$(basename "${STUDY_DIR}")"

# Really, is it a valid docker image tag
is_valid_study_name() {
    [[ "$1" =~ ^[a-zA-Z_][a-zA-Z0-9_.-]*$ ]]
}

if ! is_valid_study_name "${STUDY_NAME}"; then
    echo "Warning: Study directory \"${STUDY_NAME}\" has characters that may cause problems!"
    echo "Try to rename it to only have numbers, letters, ., _, and -"
fi
