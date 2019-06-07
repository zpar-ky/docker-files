# Default values
DIR="/home/zparky/compose-files"
# yeah it's hardcoded ¯\_(ツ)_/¯
SERVICES=("ethercalc" "fireflyiii" "kanboard" "linx" "miniflux" "trilium")

echo ""
echo "This program is used to (re)start docker services easily."
echo "Checking status of services, this may take a moment...   "

# Check statuses
for i in ${!SERVICES[@]}; do
  if [ "$1" == "-v" ] ; then echo "Checking ${SERVICES[$i]}, $[i+1]/6"; fi
  SERVICES_STATUS[$i]="Up"
  cd "$DIR/${SERVICES[$i]}"
  if docker-compose ps | grep -q 'Exit'; then
    SERVICES_STATUS[$i]="Down"
  fi
  cd "$DIR"
done

echo "Here is the current list of Docker services in this dir: "
echo "  #  | Name        | Status  "
echo " [0] | EtherCalc   | ${SERVICES_STATUS[0]}"
echo " [1] | Firefly III | ${SERVICES_STATUS[1]}"
echo " [2] | Kanboard    | ${SERVICES_STATUS[2]}"
echo " [3] | Linx        | ${SERVICES_STATUS[3]}"
echo " [4] | Miniflux    | ${SERVICES_STATUS[4]}"
echo " [5] | Trilium     | ${SERVICES_STATUS[5]}"
echo ""
echo "Choose a service to start or restart, or press q to exit"
read input

if [ "$input" == "q" ] ; then
  exit
fi

# Up selected service
cd "$DIR/${SERVICES[$input]}"
docker-compose up -d
cd "$DIR"

exit
