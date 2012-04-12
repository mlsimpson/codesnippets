git reflog expire --expire=1.minute refs/heads/master
git fsck --unreachable
git prune
git gc
