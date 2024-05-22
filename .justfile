# See flake.nix and ./parts/just-flake.nix (just-flake)
import 'just-flake.just'

# Displays this list
default:
    @just --list --unsorted 
