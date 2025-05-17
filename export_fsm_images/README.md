https://fsm2.onepub.dev/visualise-your-fsm

1) Install tool: https://fsm2.onepub.dev/visualise-your-fsm#install
Run:
```agsl
pub global activate fsm2
```
-> If cannot run: 
```agsl
flutter pub global run fsm2 --install
```

2) Install `fsm2`
```agsl
fsm2 --install
```

**Note**: If cannot run `fsm2` with error `zsh: command not found: fsm2`
```agsl
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

3) Convert `smcat` to `svg`
Run:
```agsl
fsm2 /path/to/file.smcat
```