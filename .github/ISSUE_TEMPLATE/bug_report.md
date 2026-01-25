name: 🐛 Bug Report
description: File a bug report to help us improve
labels: ["bug"]
body:
  - type: textarea
    id: description
    attributes:
      label: Describe the bug
      description: A clear and concise description of what the bug is.
    validations:
      required: true
  - type: input
    id: version
    attributes:
      label: App Version
      placeholder: e.g. 1.0.0
  - type: dropdown
    id: platform
    attributes:
      label: Platform
      options:
        - Android
        - iOS
        - Backend
  - type: textarea
    id: steps
    attributes:
      label: Steps to Reproduce
      description: 1. Go to '...'
    validations:
      required: true
  - type: textarea
    id: expected
    attributes:
      label: Expected Behavior
      description: A clear and concise description of what you expected to happen.
  - type: textarea
    id: actual
    attributes:
      label: Actual Behavior
      description: A clear and concise description of what actually happened.
