# User defined function to calculate the average
function calculate_average(total, count){
	return total/count;
}

BEGIN {
       	FS=","
	max_score=0;
	min_score=999999;
}
{
	if(NR > 1 && NR > 0) { #Skip header row
		total = $3 + $4 + $5;	# 1. Sum of grades
		student[$2] = total;	# Store the sum of grades in an associative array

		avg = calculate_average(total, 3);	#2. Calculate average
		avg_score[$2] = avg;

		status = (avg >= 70) ? "Pass" : "Fail";	#Determine status
		status_class[$2] = status;

		# Determine highest and lowest total scoring students
		if (NR == 2 || total > max_score) {
			max_score = total;
			top_student = $2;
		}
		if (NR == 2 || total < min_score) {
			min_score = total
			low_student = $2;
		}
	}
}
END {
	print "Results:";	# 4. Print results
	if (NR > 1) {
		for (name in student) {
			print name," Total:", student[name],", Average:",avg_score[name], ", Status:",status_class[name], "\n";
		}
		print "\nTop Scoring Student: ",top_student, " with ", max_score, " points. ";
		print "\nLowest Scoring Student: ",low_student, " with ", min_score, "points. ";
	}
}	
