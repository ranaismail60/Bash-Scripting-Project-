source Authentication.sh

main_menu()
{
while true
do
	echo " ----------------student Management system------"
	echo "1. Login as Teacher"
	echo "2. Login as student"
	echo "3. exit"

	read -p "Enter choice : " choice 
case "$choice" in
	1) teacher_login ;;
	2) student_login;;
	3) exit 0 ;;
	*) echo "Invalid option"; 
	sleep 2;
	main_menu ;;
	esac
done
}

main_menu
