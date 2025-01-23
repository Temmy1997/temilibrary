# Add this function to your .bashrc or .bash_profile
ctx() {
  kubectl config use-context "$1"
}

# Source the file to apply changes
source ~/.bashrc
