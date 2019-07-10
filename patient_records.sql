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

create table illness (
	illness_id int(11) not null auto_increment primary key,
    name varchar(45) not null,
    type_id int(11) not null,
    severity int(3) not null

);

create table illness_type (
    type_id int(11) not null auto_increment primary key,
    name varchar(45) not null

);

create table patient_illness (
	illness_id int(11) not null,
    patient_id int(11) not null,
    doctor_id int(11) not null

);

    

# this includes patient ids and doctor ids -- it relates patients to doctors
# many to many: one patient can have many doctors, one doctor can have many patients 
create table patient_doctor (
	patient_id int(11) not null,
    doctor_id int(11) not null
);

create table bp_observation (
	bp_id int (11) not null auto_increment primary key,
    bp_diastolic int (3) not null, 
    bp_systolic int (3) not null, 
    is_normal int (1) not null,
    patient_id int(11) not null
    );
    
# many to one relationship, because for one patient, there can be many blood pressure observations,
# but each observation is only ever referring to one patient


insert into bp_observation (bp_systolic, bp_diastolic, is_normal, patient_id) values
	(120, 80, 1, 1);

# insert more patients- one patient has more than one reading
insert into bp_observation (bp_systolic, bp_diastolic, is_normal, patient_id) values
	(130, 90, 0, 1),
    (125, 96, 0, 2),
    (110, 74, 1, 3),
    (102, 68, 1, 4),
    (108, 73, 1, 5);
    
    
    
   
    
select * from bp_observation;
    
####### create table observation -- don't forget, Bryan!!

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
    
insert into illness (name, type_id, severity) values
	('congestive heart failure', 1, 7),
    ('cold', 2, 1),
    ('nose bleed', 2, 1),
    ('flu', 2, 2),
    ('asthma', 2, 4),
    ('pancreatic cancer', 3, 9);
    
insert into illness_type (type_id, name) values
	(1, 'Cardiac'),
    (2, 'General Practice'),
    (3, 'Oncology'),
    (4, 'Pulmonary');
    

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

	
# Select all illnesses of a certain type
select * from illness
where type_id = 1;

# Select all illnesses with a certain name
select * from illness
where name in ('nose bleed', 'flu', 'asthma');

# Select all illnesses based on the severity column added above
select name, severity from illness
where severity = 2;

# Create a query that shows illnesses with type id's replaced by type names
select * from illness;
select name, type_id as `type_name` from illness;


# select all BP observations for a given patient that are not normal 

select * from bp_observation
where is_normal = 0 and patient_id = 2;

# for a patient that has more than one BP observation, return them in descending order of systolic readings 

select * from bp_observation
where patient_id = 1
order by bp_systolic desc;

# a hard one combine the bp_observation and patient tables so we see 
# the name of each patient next to their systolic and diastolic values

select p.name, bp.bp_diastolic, bp.bp_systolic
from bp_observation bp
inner join patient p on bp.patient_id = p.patient_id
order by bp.bp_systolic desc;


