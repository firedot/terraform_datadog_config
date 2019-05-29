export DD_API_KEY=''
which curl > /dev/null 2>&1
if [ $? -eq 1 ]; then
    sudo apt update -y
    sudo apt install curl -y
fi
bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
