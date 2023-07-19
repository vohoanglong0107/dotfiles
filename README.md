# Dotfiles

## Setup

Create `.chezmoidata/emails.json`:

```json
{
  "emails": [
    {
      "name": "account1",
      "email": "account1@example.exe",
      "password": "passwd"
    },
    {
      "name": "account2",
      "email": "account2@example.exe",
      "password": "passwd2"
    }
  ]
}
```

Then

```bash
chezmoi --verbose apply
```
