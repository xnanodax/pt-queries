PODS = ["Russian Hill", "Telegraph Hill", "Twin Peaks"]
# 17, 4, 5

#input
city_id = 2
day_ord = "11"
pod_index = "Russian Hill"
student1 = Student.find_by(firstname: "")
student2 = Student.find_by(firstname: "")
student1 = Student.find(2987)
student2 = Student.find(3008)
workstation = ""

sf_cycle = Cycle.current(city_id)
day = Day.where(ord: day_ord)
pod_id = Pod.find_by(name: pods[pod_index])

s1 = 3007
s2 = 2978
pod_name = "Telegraph Hill"
work = 9
def cross_pod_pairing(student1_id, student2_id, pod_name, workstation_str)
  pod = Pod.find_by(name: pod_name)

  pair1 = Pair.find_by(day_id: Cycle.current(2).today.id, student_id: student1_id)
  pair1.pair_student_id = student2_id
  pair1.pod_id = pod.id
  pair1.workstation = workstation_str
  pair1.save!
  
  pair2 = Pair.find_by(day_id: Cycle.current(2).today.id, student_id: student2_id)
  pair2.pair_student_id = student1_id
  pair2.pod_id = pod.id
  pair2.workstation = workstation_str
  pair2.save!

end 
cross_pod_pairing(s1, s2, pod_name, work)

# W1D1
Pair.create(
  day_id: day,
  student_id: student1.id, 
  pair_student_id: student2.id,
  pod_id: pod_id
  workstation: workstation, 
)

Pair.create(
  day_id: day,
  student_id: student2.id,
  pair_student_id: student1.id, 
  pod_id: pod_id
  workstation: workstation, 
)

# example
pair = Pair.create(
  day_id: 3076, 
  workstation: "13",
  student_id: nil, 
  pair_student_id: 2977, 
  pod_id: 5
)