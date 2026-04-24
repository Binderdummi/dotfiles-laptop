# ============================================
#  Fish — config.fish
# ============================================


# ── Disable greeting ─────────────────────────
set -U fish_greeting


# ── Aliases ──────────────────────────────────
abbr -a n    nvim
abbr -a ll   'ls -lah'
abbr -a la   'ls -A'
abbr -a ..   'cd ..'
abbr -a ...  'cd ../..'
abbr -a g    git
abbr -a gs   'git status'
abbr -a gc   'git commit'
abbr -a gp   'git push'
abbr -a gpl  'git pull'


# ── Environment ──────────────────────────────
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER  less


# ── PATH ─────────────────────────────────────
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.go/bin


# ── Prompt ───────────────────────────────────
function fish_prompt
    set -l last_status $status
    set -l cwd (prompt_pwd --full-length-dirs 2 2>/dev/null || basename (pwd))

    # Git branch
    set -l git_branch ""
    if command -q git
        set -l branch (git symbolic-ref --short HEAD 2>/dev/null)
        if test -n "$branch"
            # Dirty check
            if not git diff --quiet 2>/dev/null; or not git diff --cached --quiet 2>/dev/null
                set git_branch " 󰊢 $branch*"
            else
                set git_branch " 󰊢 $branch"
            end
        end
    end

    # Status indicator
    set -l arrow "❯"
    set -l arrow_color (set_color blue)
    if test $last_status -ne 0
        set arrow_color (set_color red)
    end

    # Build prompt
    echo -s (set_color cyan) $cwd (set_color 7d7d7d) $git_branch (set_color normal)
    echo -s $arrow_color $arrow " " (set_color normal)
end


# ── Right prompt — execution time ────────────
function fish_right_prompt
    # Show last command duration if > 3s
    if test $CMD_DURATION -gt 3000
        set -l secs (math -s1 $CMD_DURATION / 1000)
        printf '%s󰔛 %ss%s' (set_color 636366) $secs (set_color normal)
    end
end


# ── Title ────────────────────────────────────
function fish_title
    echo (prompt_pwd --full-length-dirs 2 2>/dev/null || basename (pwd))
end

# opencode
fish_add_path /home/achibald/.opencode/bin
