# nixosConfig

Maxwell's multi-host NixOS flake repository, currently containing:

- `thinkpad-x1c13`: physical laptop configuration
- `nixos-wsl`: WSL configuration
- `darwin`: nix-darwin skeleton for macOS hosts

## Directory Structure

```text
.
├── flake.nix
├── flake.lock
├── home
│   ├── base.nix
│   ├── default.nix
│   ├── darwin.nix
│   └── gui.nix
└── hosts
    ├── darwin
    │   ├── configuration.nix
    │   └── home.nix
    ├── wsl
    │   ├── configuration.nix
    │   └── home.nix
    └── x1c13
        ├── configuration.nix
        ├── hardware-configuration.nix
        └── home.nix
```

## Design Notes

- `home/base.nix` contains shared headless/base Home Manager configuration
- `home/gui.nix` contains Linux GUI-oriented packages and environment variables
- `home/darwin.nix` is reserved for Darwin-specific Home Manager additions
- `home/default.nix` composes `base + gui` for GUI-capable Linux machines
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

Darwin:

```bash
darwin-rebuild switch --flake ~/nixosConfig#darwin
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

The shared configuration is split by capability:

- `home/base.nix`: common CLI/development tools and shell setup for headless systems, WSL, and servers
- `home/gui.nix`: Linux GUI packages for desktop/laptop machines
- `home/darwin.nix`: a Darwin-specific layer for future macOS hosts; currently reserved and not yet wired into `nix-darwin`
- `home/default.nix`: the default GUI Linux composition used by the laptop host

Examples of the host-specific wrappers:

- `hosts/x1c13/home.nix` imports `../../home` to get `base + gui`
- `hosts/wsl/home.nix` imports `../../home/base.nix` to stay headless
- `hosts/darwin/home.nix` imports `../../home/base.nix` and `../../home/darwin.nix`

This allows the same Home Manager repository to be reused while keeping GUI packages off WSL and server-style hosts.

## Use `base` On Non-NixOS Machines

Install nix:

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
```

Then:

```bash
nix run ~/nixosConfig#homeConfigurations.base.activationPackage --impure
```

Why `--impure` is required:

- `homeConfigurations.base` reads the current machine's `USER`, `HOME`, and system architecture during evaluation.
- That keeps `base` itself generic, instead of forcing every non-NixOS machine to add its own `hosts/<name>/home.nix` wrapper.

What this gives you:

- `home/base/default.nix` as the reusable shared CLI/development layer
- automatic `home.username = $USER`
- automatic `home.homeDirectory = $HOME`
- automatic package selection for the current Linux architecture

Notes:

- `home/default.nix` is still `base + gui`, intended for Linux machines with a desktop session.
- `home/base/default.nix` remains the safer entrypoint for servers, WSL, and generic non-NixOS Linux.
- The direct `#base` target intentionally does not enable `my.rebuild`, because a generic entry cannot safely assume where the repository is cloned on every machine.
- If you want local overrides on top of `base`, add your own `homeConfigurations.<name>` later and import `self.homeManagerModules.base` there.

## Darwin Notes

- The current Darwin host is a skeleton named `darwin`
- It is configured for `aarch64-darwin`; change this in `flake.nix` if your Mac is Intel
- `home/darwin.nix` is intentionally minimal right now and does not manage `vscode` or `zed`
