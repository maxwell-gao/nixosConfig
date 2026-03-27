# nixosConfig

Maxwell's multi-host NixOS flake repository, currently containing:

- `thinkpad-x1c13`: physical laptop configuration
- `nixos-wsl`: WSL configuration

## Directory Structure

```text
.
├── flake.nix
├── flake.lock
├── home.nix
└── hosts
    ├── wsl
    │   ├── configuration.nix
    │   └── home.nix
    └── x1c13
        ├── configuration.nix
        ├── hardware-configuration.nix
        └── home.nix
```

    ## Design Notes

    - The top-level `home.nix` contains shared Home Manager configuration
    - Each host-specific `hosts/<name>/home.nix` only contains user identity and a small amount of host-specific differences
    - Each host-specific `hosts/<name>/configuration.nix` contains system-level configuration

    ## Flake Input Strategy

    To reduce the impact of GitHub API rate limits on `nix flake` as much as possible, the top-level flake inputs in this repository use the `git+https` form instead of the `github:` shorthand.

    Current top-level inputs:

- `nixpkgs`
- `home-manager`
- `nixos-hardware`
- `nixos-wsl`

    Note: one of `nixos-wsl`'s upstream dependencies is `flake-compat`, which is defined by that upstream project and still appears as a `github` type. The top-level inputs in this repository have already been unified, but this kind of transitive dependency cannot be fully removed without overriding the upstream dependency graph.

    ## Common Commands

    When using this on a new machine for the first time, if flakes are not enabled yet:

```bash
NIX_CONFIG="experimental-features = nix-command flakes" sudo nixos-rebuild switch --flake ~/nixosConfig#thinkpad-x1c13
```

ThinkPad:

```bash
sudo nixos-rebuild switch --flake ~/nixosConfig#thinkpad-x1c13
```

WSL:

```bash
sudo nixos-rebuild switch --flake ~/nixosConfig#nixos-wsl
```

Update the lock file:

```bash
nix flake update
```

Validate the configuration:

```bash
nix flake check
```

## Home Manager Reuse Pattern

The shared configuration lives in the top-level `home.nix`:

- Common development tools
- Common zsh base configuration
- `starship`
- Common environment variables

Examples of the host-specific wrappers:

- `hosts/x1c13/home.nix` binds the user `max`
- `hosts/wsl/home.nix` binds the user `nixos`

This allows the same Home Manager configuration to be reused while still preserving each machine's own username, home path, and aliases.
