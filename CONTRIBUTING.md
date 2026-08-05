# Contributing to Griffin

We welcome contributions from the community to make Griffin even better! Whether you're a seasoned developer or just starting out, your contributions are valuable.

## How to Contribute

There are several ways you can contribute to Griffin:

*   **Report Bugs:** If you encounter any bugs or unexpected behavior, please open an issue on the [GitHub repository](https://github.com/TerrorSquad/griffin). Provide detailed information about the issue, including steps to reproduce it.
*   **Suggest Enhancements:** Have an idea for a new feature or improvement? Feel free to open an issue to discuss it.
*   **Improve Documentation:** Help us make the documentation clearer and more comprehensive. You can suggest edits, fix typos, or add new sections.
*   **Submit Code:** If you're comfortable with Ansible and want to contribute code, you can fork the repository, make your changes, and submit a pull request.

## Pull Request Guidelines

Before submitting a pull request, please ensure:

*   **Linting**: Run `ansible-lint` to check for style issues.
*   **Testing**: Run local tests using `molecule test` (in `post-installation/` directory) if you modified the role logic.
*   **Documentation**: Update relevant documentation if you added new features or changed variables.
*   **Conventions**: Follow the project's coding style and commit message conventions (Conventional Commits).

## Development Setup

1.  **Install Dependencies**:
    ```bash
    pip install ansible ansible-lint molecule molecule-plugins[docker]
    ```

2.  **Run Local Tests**:
    ```bash
    cd post-installation
    molecule test
    ```

## Code of Conduct

Please note that this project adheres to a [Code of Conduct](code-of-conduct). By participating, you are expected to uphold this code.

## Getting Help

If you have any questions or need assistance, feel free to create an issue in the [GitHub repository](https://github.com/TerrorSquad/griffin).

## Thank You!

We appreciate your interest in contributing to Griffin. Your contributions help make this project a success!
