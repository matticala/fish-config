# PATH first
if type -q go
  set -xg PATH (go env GOPATH)/bin $PATH
end

if type -q cargo
  set -xg PATH $HOME/.cargo/bin $PATH
end

if test -d $HOME/.bin
  set -xg PATH $HOME/.bin $PATH
end

if test -d $HOME/.local/bin
  set -xg PATH $HOME/.local/bin $PATH
end

# Then plug-ins
if type -q direnv
  direnv hook fish | source
end
if type -q starship
  eval (starship init fish)
end
