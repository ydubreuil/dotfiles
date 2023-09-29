gclone() {
  local remote_url="${1%/}"
  local remote_repo_name="${remote_url##*/}"
  if [[ -z "$remote_url" || -z "$remote_repo_name" ]]; then
    echo "URL missing"
    return
  fi
  local target_path="${remote_repo_name}.git"
  mkdir -p "$target_path" || return
  cd "$target_path" || return
  git clone --bare "$remote_url" .bare || return
  echo "gitdir: ./.bare" > .git
  git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
  git config --add core.logallrefupdates true
  git fetch
  git branch -f main origin/main
  git worktree add main main
}

gpr() {
	local pr_id="$1"
	if [[ -z "$pr_id" ]]; then
		return
	fi
	if ! git rev-parse --show-toplevel ; then
		echo "Can't fetch PR, not a git repo"
		return
	fi

	cd "$(git rev-parse --show-toplevel)"
	local repo="$(basename "$(pwd)")"
	local worktree="../PR-${pr_id}"
	git worktree add "${worktree}" -d
	cd "$worktree"
	gh pr checkout "$pr_id"
}
