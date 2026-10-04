set -euo pipefail

have() {
	command -v "$1" >/dev/null 2>&1
	}

echo "
..........................................................................
"
echo "SPRAWDZAM CZY NARZĘDZIA SĄ ZAINSTALOWANE:"

echo "
..........................................................................
"
if have git \ ; then
	echo " STATUS: Git jest zainstalowany."
	else 
	sudo apt install -y git
	echo " >>> UPDATE: Git został zainstalowany <<< "

	echo "
.........................................................................

"
fi

if have curl; then
	echo " STATUS: Curl jest zainstalowany."
	else 
	sudo apt install -y curl
	echo ">>> UPDATE: CURL został zainstalowany <<<"

	echo "
........................................................................

"
fi

if have wget; then
	echo " STATUS: WGET jest zainstalowany."
	else 
	sudo apt install -y wget
	echo ">>> UPDATE: WGET został zainstalowany. <<<"
	
	echo "
.........................................................................
"
fi

if have unzip; then
	echo " STATUS: UNZIP jest zainstalowany."
	else 
	sudo apt install -y unzip
	echo ">>> UPDATE: UNZIP zoastał zainstalowany. <<<"

	echo "
.........................................................................
"
fi

if have htop; then
	echo " STATUS: HTOP jest zainstalowany."
	else 
	sudo apt install -y htop
	echo ">>> UPDATE: HTOP został zainstalowany. <<<"

	echo "
..........................................................................
"
fi

if have tree; then
	echo " STATUS: TREE jest zainstalowany."
	else 
	sudo apt install -y tree
	echo ">>> UPDATE: TREE zosatł zainstalowany. <<<"

	echo "
..........................................................................
"
fi

echo "
..........................................................................
"
exit 1
