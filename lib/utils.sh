# Shared by the bin/ scripts (sourced, POSIX sh).

QUARZ_REPO="${ASDF_QUARZ_REPO:-https://github.com/quarz-lang/quarz.git}"

fail() {
  echo "asdf-quarz: $*" >&2
  exit 1
}

# The versions released, from the repository's tags `vX.Y.Z[-pre]`,
# oldest first, one a line.
list_versions() {
  tags=$(git ls-remote --tags --refs "$QUARZ_REPO" 'v*') ||
    fail "cannot list the tags of $QUARZ_REPO"
  printf '%s\n' "$tags" |
    sed -n 's|^[^	]*	refs/tags/v||p' |
    grep -E '^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$' |
    sort_versions
}

# Sorts X.Y.Z[-pre] versions, a prerelease before its release.
sort_versions() {
  sed 'h; s/[+-]/./g; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4 -k 5,5n |
    awk '{print $2}'
}
