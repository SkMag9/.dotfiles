# System Setup

```shell
sudo dnf upgrade -y
sudo dnf install -y ansible-core git 
git clone https://github.com/skmag9/.dotfiles ${HOME}/.dotfiles
cd .dotfiles && ansible-playbook main.yml
```
