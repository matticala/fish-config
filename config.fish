set fish_greeting

# PATH first
set -l paths \
  "{$HOME}/.cargo" \
  "{$HOME}/.bin" \
  "{$HOME}/.local/bin" \
  "/usr/local/sbin" \
  "/usr/local/opt/openssl@1.1/bin" \


for path in $paths
  test -d $path && set -g fish_user_paths $path $fish_user_paths || true
end

type -q go && set -g fish_user_paths (go env GOPATH)/bin $fish_user_paths || true

# Then completions
type -q zoxide && zoxide init fish | source || true
type -q direnv && direnv hook fish | source || true
type -q starship && starship init fish | source || true
type -q deno && deno completions fish | source || true

# iTerm2
set -l iterm2_shell_integration {$HOME}/.iterm2_shell_integration.fish
test -e $iterm2_shell_integration && source $iterm2_shell_integration || true

# fundle manager: https://github.com/danhper/fundle
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

# fundle plugins
set -l plugins \
  'edc/bass' \
  'laughedelic/pisces' \
  'FabioAntunes/fish-nvm' \
  # 'reitzig/sdkman-for-fish' \
  'acomagu/fish-async-prompt' \


for plugin in $plugins
  fundle plugin $plugin
end
fundle init

# Added by Krypton
set -x GPG_TTY (tty)
