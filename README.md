# Custom CLI Command Framework 🚀

This shell script creates a flexible framework for generating custom command-line interface (CLI) commands, initially focused on Docker but designed to be extensible for other tools like Ansible, Terraform, Kubernetes, and more. By generating executable scripts in `/usr/bin`, it provides shorthand aliases to streamline workflows for various DevOps and development tools. 🎉


## 🎬 Video Demonstration
[![Watch on Youtube](https://i.ytimg.com/vi/SeHL6ThEUk4/maxresdefault.jpg)](https://youtu.be/SeHL6ThEUk4)


## What It Does 🛠️

The script performs the following actions:
- **Defines a command path**: Sets `/usr/bin` as the destination for generated scripts.
- **Sets permissions**: Uses `chmod 777` to make scripts executable by all users (configurable for security).
- **Creates a help command**: Generates a `dhp` command to list all available aliases and their descriptions.
- **Supports Docker commands**: Includes aliases like `dpl` (docker pull), `dpi` (custom container listing), and `dup` (Docker Compose up).
- **Extensible framework**: Uses a dynamic `generate_command` function to create scripts for any CLI tool, such as Ansible (`ansible-playbook`), Terraform (`terraform apply`), or Kubernetes (`kubectl`).
- **Custom commands**: Includes specialized commands like `dhc` (Docker health check) and supports adding tool-specific customizations.

## Why It’s Useful 🌟

This framework is a productivity booster for developers, DevOps engineers, and system administrators who work with multiple CLI tools. Here’s why it stands out:
- **Saves time**: Short aliases reduce typing effort (e.g., `dpl` for `docker pull`, `tfa` for `terraform apply`).
- **Extensibility**: Easily add commands for tools like Ansible, Terraform, or Kubernetes by updating the `commands` array.
- **Consistency**: Standardizes commands across environments, reducing errors.
- **Customizability**: Supports custom formatting (e.g., `dpi` for Docker container listings) and tool-specific workflows.
- **Broad compatibility**: Includes fallbacks (e.g., `docker compose` vs. `docker-compose`) and can be adapted for other tools’ versioning needs. 🐳

Whether you're managing containers, infrastructure, or clusters, this framework simplifies repetitive tasks and scales with your toolset. 🚀

## Extending to Other Tools 🧰

The script’s `generate_docker_command` function can be renamed to `generate_command` and extended to support other tools. Examples of additional commands:
- **Ansible**: `apb` for `ansible-playbook playbook.yml`, `ainv` for `ansible-inventory`.
- **Terraform**: `tfa` for `terraform apply`, `tfp` for `terraform plan`.
- **Kubernetes**: `kget` for `kubectl get pods`, `kdesc` for `kubectl describe`.
- **Generic CLI**: Add any command by appending to the `commands` array, e.g., `gitc:git commit -m`.

To add a new tool, update the `commands` in the script(always use single command as a function):
```bash
commands=(
    "dpl:docker pull \$1"  # Docker example
    "apb:ansible-playbook \$1"  # Ansible example
    "tfa:terraform apply"  # Terraform example
    "kget:kubectl get pods --all-namespaces"  # Kubernetes example
)
```

## Comparison with Dotfiles and `.bash_profile` 📊

The framework serves a similar purpose to dotfiles and `.bash_profile` by customizing the shell environment, but its system-wide script generation and extensibility set it apart. Below is a comparison:

| Feature                     | Custom CLI Framework 🐳 | Dotfiles 📂 | `.bash_profile` ⚙️ |
|-----------------------------|-------------------------|-------------|--------------------|
| **Purpose**                 | Creates executable CLI scripts for multiple tools | Manages shell and tool configurations | Configures user-specific Bash settings |
| **Scope**                   | Tool-agnostic, supports Docker, Ansible, Terraform, etc. | Broad, covering multiple tools and settings | Specific to Bash shell initialization |
| **Location**                | Installs scripts in `/usr/bin` | Typically in `~/.dotfiles` or home directory | In user’s home directory (`~/.bash_profile`) |
| **Availability**                | Global (for all users)| User specific| User specific |
| **Execution**               | Standalone executable scripts | Sourced or linked to shell | Sourced during Bash login sessions |
| **Portability**             | System-wide, requires root for `/usr/bin` | Highly portable, often version-controlled | User-specific, less portable |
| **Ease of Extension**       | Add commands to `commands` array | Add new files or modify existing ones | Modify single file, but can get cluttered |
| **Permission Requirements** | Requires `chmod 777` (consider `755` for security) | Typically user-level permissions | User-level permissions only |
| **Use Case**                | Streamlining workflows for multiple CLI tools | General shell and tool customization | Bash-specific environment setup |
| **Version Controlled**                | No| Yes | No |
| **Auto Update**                | No| Yes | No |
| **Power 💪**                | ***| ***** (Winner) | **** |


### Key Differences Explained:
- **Dotfiles**: A collection of configuration files for various tools, ideal for version control and portability but less focused on standalone commands.
    ```
    https://github.com/meibraransari/dotfiles
    ```

- **`.bash_profile`**: Limited to Bash login shells, suitable for user-specific aliases but not ideal for system-wide or multi-tool command frameworks.
    ```
    https://github.com/meibraransari/bash_profile
    ```

- **Custom CLI Framework**: Installs system-wide commands for tools like Docker, Ansible, or Kubernetes, making them accessible to all users. Requires root privileges but offers a scalable structure.
    ```
    https://github.com/meibraransari/Custom-CLI-Commands
    ```


## Installation and Usage 🛠️

1. **Save the script**: Copy the [shell script](https://github.com/meibraransari/Custom-CLI-Commands/blob/main/config/custom_cli.sh) to a file (e.g., `custom_cli.sh`).
2. **Modify the commands array**: Add aliases for tools like Ansible, Terraform, or Kubernetes as needed.
3. **Run the script**: Execute with `sudo bash custom_cli.sh` to create commands in `/usr/bin`.
4. **Use the commands**: Run commands like `dpl nginx` (Docker), `apb playbook.yml` (Ansible), or `kget` (Kubernetes).

**Note**: Using `chmod 777` grants broad permissions. For better security, use `chmod 755`. 🔒

## Example Commands 🎮

- `dpl nginx`: Pulls the Nginx Docker image.
- `apb playbook.yml`: Runs an Ansible playbook.
- `tfa`: Applies a Terraform configuration.
- `kget`: Lists Kubernetes pods across all namespaces.
- `dpi`: Lists Docker containers in a custom table format.

## Contributing 🤝

Fork the script, add new tool commands, or enhance existing ones! Submit a pull request or open an issue for suggestions. Contributions to support more tools like Helm, Packer, or AWS CLI are welcome! 🌈

### 💼 Connect with me 👇👇 😊

- 🔥 [**Youtube**](https://www.youtube.com/@DevOpsinAction?sub_confirmation=1)
- ✍ [**Blog**](https://ibraransari.blogspot.com/)
- 💼 [**LinkedIn**](https://www.linkedin.com/in/ansariibrar/)
- 👨‍💻 [**Github**](https://github.com/meibraransari?tab=repositories)
- 💬 [**Telegram**](https://t.me/DevOpsinActionTelegram)
- 🐳 [**Docker**](https://hub.docker.com/u/ibraransaridocker)

# Hit the Star! ⭐
***If you are planning to use this repo for learning, please hit the star. Thanks!***
