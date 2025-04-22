source student.txt
teacher_login()
{

# check for teacher login
 	read -p "Enter Username: " user
	read -p "Enter passward: " pass
	echo " "
# already stored the teacher credentials
	if [[ "$pass" != "danger_round" ]]
	then
		echo "Invalid passward"
		return;
        fi
# i have implement an infinite loop untill teacher exits it
  while true
  do
	echo "**************************WELCOME back *****************"

	echo  "1. Add student"
	echo  "2. Delete student"
	echo  "3. update Marks"
	echo  "4. LIst of passing"
	echo  "5. LIst of fail "
	echo  "6. List of total students"
	echo  "7. Logout"
	read -p "Enter choice " choice

case "$choice" in 
	1) Add_student ;;
	2) Delete_student ;;
	3) Update_student;;
	4) List_Passed ;;
	5) List_Fail ;;
	6) List_total ;;
        7) return ;;
	*) echo "Invalid input"
esac
done
}
Ascending()
{
echo "Students in Ascending Order (by CGPA)"
 sort -t ':' -k5g student.txt

}
Descending()
{
echo "Students in Descending Order (by CGPA)"
 sort -t ':' -k5gr student.txt 

}

# All Student Record Function
List_total()
{
echo " How do you want Student to sort " 
echo "1. Ascending Order (by CGPA)"
echo "2. Descending Order (by CGPA)"
read -p "Enter choice " opt

case "$opt" in 

# it will print students in Ascending order
  1) Ascending ;;

 # it will print students in Descending order
  2) Descending ;;

 *) echo :"Invalid input plz Try Again" ;;

esac
}


# Function to print Fail Student
List_Fail()
{
echo "********  ::  List of Student Who are Failed  ::  **********"
echo " "
grep ":F:" student.txt
}


# Function to print Pass Student
List_Passed()
{
# check passed student on base of their grade
echo "********  ::  List of Passed Student   ::  **********"
echo " "
grep ":A:" student.txt
grep ":B:" student.txt
grep ":C:" student.txt
grep ":D:" student.txt

}
Update_student()
{
	total_students=$(wc -l student.txt);
	if [[ $total_student == 0 ]]
	then 
		echo "FIle empty\n"
		return;
	fi

	read -p "Enter rollno for update = " rollno

	found=$(grep "^$rollno" student.txt)
	
	# if rollno not present
	if [[ -z "$found" ]]
	then
	echo "Student not found"
	return;
	fi 

	data=$(grep "^$rollno:" student.txt)
	# get information of particular rollno 
	IFS=":" read rollno name marks grade gpa <<< $data
	
	echo  "1. update name"
	echo  "2. update Marks"
	read -p "Enter choice: " choice
	
	case "$choice" in 
		1)
			read -p "Enter new name: " name
			;;
		2)
			read -p "Enter new marks: " marks
			if [[ $marks -lt 50 ]]; then 
				grade='F'
			elif [[ $marks -ge 50 && $marks -lt 60 ]]; then 
				grade='D'
			elif [[ $marks -ge 60 && $marks -lt 70 ]]; then 
				grade='C'
			elif [[ $marks -ge 70 && $marks -lt 80 ]]; then 
				grade='B'
			else 
				grade='A'
			fi

			case "$grade" in
				A) gpa=4.0 ;;
				B) gpa=3.0 ;;
				C) gpa=2.0 ;;
				D) gpa=1.0 ;;
				F) gpa=0.0 ;;
			esac
			;;
		*)
			echo "Invalid input"
			return
			;;
	esac
	
	# remove line with given rollno 
	grep -v "^$rollno" student.txt > store.txt
	mv store.txt student.txt
	
	echo "$rollno:$name:$marks:$grade:$gpa" >> student.txt
	echo "Updated Successfully\n"
	
}
	
Delete_student()
{
	total_students=$(wc -l < student.txt);
	if [[ $total_student == 0 ]]
	then
		echo "File is empty "
		return;
	fi
	
	read -p "Enter rollno to delete : " rollno 
	
	found=$(grep "^$rollno" student.txt)
	
	if [[ -z "$found" ]]
	then
	echo "Student not found"
	return;
	fi 
	
	# remove student with given rollno 
	grep -v "^$rollno" student.txt > store.txt
	mv store.txt student.txt
	echo "Deleted successfully "
	
}

# fucntion to add a student
Add_student()
{
 # check for student count dont exceed 20
	total_student=$(wc -l  < student.txt)
	if [[ "$total_student" -ge 20 ]]
	then 
		echo "LImit excided. can't add more"
		return
	fi
	
	read -p "Enter rollno " rollno

# i have sued grep command for to check duplication in studen file
	if grep "^rollno:" student.txt 
	then 
		echo "Student with $rollno already exist"
		return 
	fi
	
	read -p "Enter name of student = " name
	read -p "Enter Marks of studnet = " marks
	if [[ $marks -lt 50 ]] 
    	then 
       		 grade='F'
    	elif [[ $marks -ge 50 && $marks -lt 60 ]]
    	then 
        	grade='D'
    	elif [[ $marks -ge 60 && $marks -lt 70 ]]
    	then 
        	grade='C'
    	elif [[ $marks -ge 70 && $marks -lt 80 ]]
    	then 
        	grade='B'
    	elif [[ $marks -ge 80 ]]
    	then 
        	grade='A'
    	fi
	
	
	#calculating CGPA
	if [[ $grade == 'A' ]]
	then
		gpa=4.0;
	elif [[ $grade == 'B' ]]
	then 
		gpa=3.0;
	elif [[ $grade == 'C' ]]
	then 
		gpa=2.0;
	elif [[ $grade == 'D' ]]
	then 
		gpa=1.0;
	elif [[ $grade == 'F' ]]
	then 
		gpa=0;
	fi
	
	echo "$rollno:$name:$marks:$grade:$gpa" >> student.txt
	
	echo "Student has been added successfully "
	
}

student_login()
{
	read -p "Enter Registration Number of student = " rollno

	found=$(grep "^$rollno" student.txt)
	
	if [[ -z "$found" ]]
	then
	echo "Student not found"
	return;
	fi 
	
	data=$(grep "^$rollno:" student.txt)
	IFS=":" read rollno name marks grade gpa <<< $data
	
	echo "Name = $name "
	echo "marks = $marks "
	echo "Grade = $grade "
	echo "GPA = $gpa"
}
