name: 🚀 Feature Request
description: Suggest an idea for this project
labels: ["enhancement"]
body:
  - type: textarea
    id: problem
    attributes:
      label: Is your feature request related to a problem?
      description: A clear and concise description of what the problem is.
    validations:
      required: true
  - type: textarea
    id: solution
    attributes:
      label: Describe the solution you'd like
      description: A clear and concise description of what you want to happen.
    validations:
      required: true
  - type: textarea
    id: design
    attributes:
      label: UI/UX Considerations
      description: How does this align with the "Emerald Night" theme?
  - type: checkboxes
    id: checklist
    attributes:
      label: Requirements
      options:
        - label: I have checked existing issues to avoid duplicates.
        - label: This falls within the MVP scope defined in PRD.
