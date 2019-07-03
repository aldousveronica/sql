# creates a schema 
create schema health;

# sets as default schema  
use health; 

# Design patterns:
	# ONE TO MANY: if patient has exactly one doctor, there should be a doctor_id in the patient table 
	# ONE TO MANY: if doctor has exactly one patient, there should be a patient_id in the doctor table 
	# ONE TO ONE: if every patient has exactly one doctor and vice versa, they can be on the same table
	# MANY TO MANY: if a patient has many doctors and a doctor has many patients, then there could be a third table PATIENT_DOCTOR
		# which includes the patient_id and doctor_id 

# create tables that will store the patient data, doctor data, specialist types, and the relationship between patients and doctors
create table patient (
	patient_id int(11) not null auto_increment primary key,
	name varchar(45) not null,
	age int(3) not null
);

create table doctor (
	doctor_id int(11) not null auto_increment primary key,
    name varchar(45) not null,
    specialist_id int(11) not null
);

create table specialist_type (
	specialist_id int(11) not null auto_increment primary key,
    type varchar(45) not null
);

# this includes patient ids and doctor ids -- it relates patients to doctors
# many to many: one patient can have many doctors, one doctor can have many patients 
create table patient_doctor (
	patient_id int(11) not null,
    doctor_id int(11) not null
);

# inserts rows into the tables 
insert into patient (name, age) values
	('Peter Parker', 16),
	('John Smith', 40),
	('Bruce Banner', 45),
	('Jon Snow', 30),
	('Pepper Potts', 48);

insert into specialist_type (type) values
	('cardiologist'),
    ('pulmonologist');
    
insert into doctor (name, specialist_id) values
	('Stephen Strange', 1),
    ('Dr. Evil', 1),
    ('Doc Holliday', 2);

insert into patient_doctor (patient_id, doctor_id) values
	(1, 3),
    (2, 1),
    (5, 2),
    (1, 2);
    
# example queries for this database

# What are the names of all the patients?
select name from patient;

# Print out all the patients and order them by age-- oldest to youngest.
select * from patient 
order by age desc; 

# Print out all the patients and order them by age-- youngest to oldest.
select * from patient 
order by age asc; 

# What are the names of all the doctor's associated with a given specialty?
select name from doctor 
where specialist_id = 1;

# Print out all the doctors and replace their specialty id with the name of the specialty.
select d.doctor_id, d.name, s.type as `specialist type`
from doctor d
inner join specialist_type s
on d.specialist_id = s.specialist_id;


# For a given patient id, what are the id's of all the doctors associated with them?
select doctor_id from patient_doctor
where patient_id = 1;


# For a given patient id, what are the names of all the doctors associated with them?
select name 
from doctor d
inner join patient_doctor p
on d.doctor_id = p.doctor_id
where p.patient_id = 1;


# For a given doctor id, what are the id's of all the patients associated with them?

select patient_id from patient_doctor
where doctor_id = 1;


# For  a given doctor id, what are the names of all the patients associated with them?

select p.name
from patient p 
inner join patient_doctor pd
on p.patient_id = pd.patient_id
where pd.doctor_id = 1;

        
  