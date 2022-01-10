import time
class Branch():
	def __init__(self, name: str, employees: dict, emergencies: list):
		self.name = name
		self.employees = employees
		self.emergencies = emergencies


class Employee():
	def __init__(self, name: str, number: str, branch: Branch, id: str, type: str, status: bool):
		self.name = name
		self.number = number
		self.branch = branch
		self.id = id
		self.type = type
		self.status = status

	def toggleStatus(self):
		self.status = not self.status

class Emergency():
	def __init__(self, details: str, location: str, meetingpoint: str, time: time, urgency: 0<int<6, branch: Branch, employees: list(Employee)):
			self.details = details
			self.location = location
			self.meetingpoint = meetingpoint
			self.time = time
			self.urgency = urgency
			self.branch = branch
			self.employees = employees

