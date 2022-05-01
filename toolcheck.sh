function testTools() {

    echo -e "[ ${YELLOW}STATUS${NC} ]: Checking tools now..."

    tools=(
        ${AMASS}
        ${SUBLISTER}
        ${ASSETFINDER}
        ${SUBFINDER}
        ${HTTPROBE}
        ${AQUATONE}
        ${GAU}
        ${WAYBACK}
        ${LINKFINDER}
        ${DNSCAN}
        ${SUBJACK}
        ${NAABU}
        #wappalyzer -- having issues with
        dig
        whois
        nslookup
        curl
    )

    # Increment remaining and get file size

    for tool in "${tools[@]}" ; do
        if ! $(command -v ${tool} -h &> /dev/null) ; then
                echo -e "[ ${RED}FAILED${NC} ] ${tool} not found!"


        elif $(command -v ${tool} -h &> /dev/null) ; then
            echo -e "[ ${GREEN}PASSED${NC} ]: ${tool} passed!"
        fi
    done



    #echo ""
    #echo -e "[ ${GREEN}PASSED${NC} ]: Tool Check passed!"
}

function checkConfigurations() {

    if [ -z ${AMASS_CONFIG} ] ; then
        echo -e "[ ${YELLOW}INFO${NC} ]: Warning: amass config is empty. This is optional and is not needed."
    fi

    if [ ! -f ${SUBJACK_FINGERPRINTS} ] ; then
        echo -e "[ ${RED}FAILED${NC} ]: Could not located subjack fingerprints.json. Please verify path."
    fi
}

function checkPortOptions() {

    if [ -z ${AQUATONE_PORTS} ] ; then
        echo -e "[ ${RED}FAILED${NC} ]: No port option found for aquatone!"

    else
        echo -e "[ ${GREEN}PASS${NC} ]: Aquatone ports option set at: ${AQUATONE_PORTS}"

    fi

    if [ -z ${NAABU_PORTS} ] ; then
        echo -e "[ ${RED}FAILED${NC} ]: No port option found for naabu!"

    else
        echo -e "[ ${GREEN}PASS${NC} ]: Naabu ports option set at: ${NAABU_PORTS}"

    fi

    if [ -z ${HTTPROBE_PORTS} ] ; then
        echo -e "[ ${RED}FAILED${NC} ]: No port option found for httprobe!"

    else
        echo -e "[ ${GREEN}PASS${NC} ]: Httprobe ports option set at: ${HTTPROBE_PORTS}"

    fi

}

function checkOptimizations() {
    if [ -z ${HTTPROBE_THREADS} ] ; then
        echo -e "[ ${RED}FAILED${NC} ]: Concurrency not set for httprobe!"

    else
        echo -e "[ ${GREEN}PASS${NC} ]: Httprobe concurrency option set at: ${HTTPROBE_THREADS}"

    fi

    if [ -z ${AQUATONE_THREADS} ] ; then
        echo -e "[ ${RED}FAILED${NC} ]: Concurrency not set for aquatone!"

    else
        echo -e "[ ${GREEN}PASS${NC} ]: Aquatone concurrency option set at: ${AQUATONE_THREADS}"

    fi

    if [ -z ${FFUF_THREADS} ] ; then
        echo -e "[ ${RED}FAILED${NC} ]: Concurrency not set for ffuf!"

    else
        echo -e "[ ${GREEN}PASS${NC} ]: Ffuf concurrency option set at: ${FFUF_THREADS}"

    fi

    if [ -z ${NAABU_THREADS} ] ; then
        echo -e "[ ${RED}FAILED${NC} ]: Concurrency not set for naabu!"

    else
        echo -e "[ ${GREEN}PASS${NC} ]: Naabu concurrency option set at: ${NAABU_THREADS}"

    fi

}

function checkWordlists() {
    if [ ! -f ${AMASS_BRUTE_WORDLIST} ] ; then
        echo -e "[ ${RED}FAILED${NC} ]: No wordlist found for amass!"

    else
        echo -e "[ ${GREEN}PASS${NC} ]: Amass wordlist option set at: ${AMASS_BRUTE_WORDLIST}"

    fi

    if [ ! -f ${FFUF_WORDLIST} ] ; then
        echo -e "[ ${RED}FAILED${NC} ]: No wordlist found for ffuf!"

    else
        echo -e "[ ${GREEN}PASS${NC} ]: ffuf wordlist option set at: ${FFUF_WORDLIST}"

    fi
    
}


function main() {
    
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    NC='\033[0m'

    date=$(date)

    testTools
    checkConfigurations
    checkPortOptions
    checkOptimizations
    checkWordlists
}

# grab directory script is being run in
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# source directory script is in with config file
. ${SCRIPT_DIR}/config.sh

main
