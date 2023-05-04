<h1 align="center">pefcl-esx</h1>

**This is a compatibility resource that enables PEFCL to function properly with ESX. Please ensure that you have the latest version
of PEFCL and ESX installed**

## Installation Steps:

1. Download this repository and place it in the `resources` directory
2. Add `ensure pefcl-esx` to your `server.cfg`. Start this resource BEFORE `PEFCL`.
3. Navigate to the `config.json` in `PEFCL` and change the following settings:
   - Under `frameworkIntegration`
     - `enabled`: `true`
     - `resource`: `pefcl-esx`
