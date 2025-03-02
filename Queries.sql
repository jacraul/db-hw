-- List all employees who worked on a project in the last month along with project details:

SELECT e.employee_id, e.first_name, e.last_name, p.project_id, p.name AS project_name, p.start_date, p.end_date
FROM Employees e
JOIN Projects p ON e.employee_id = p.employee_id
WHERE p.start_date >= ADD_MONTHS(TRUNC(SYSDATE, 'MONTH'), -1);


-- Retrieve observations and associated species information for a specific location:

SELECT o.observation_id, o.observation_date, s.species_id, s.common_name, s.scientific_name
FROM Observations o
JOIN Observations_Species os ON o.observation_id = os.Observations_species_id
JOIN Species s ON os.Species_species_id = s.species_id
WHERE o.location_id = 1;


-- List employees who have volunteered in projects and their respective volunteer opportunities:

SELECT e.employee_id, e.first_name, e.last_name, v.volunteer_name, vo.description AS volunteer_opportunity
FROM Employees e
JOIN Projects_Volunteers pv ON e.employee_id = pv.Projects_volunteer_id
JOIN Volunteers v ON pv.Volunteers_volunteer_id = v.volunteer_id
JOIN Volunteer_Opportunities vo ON v.opportunity_id = vo.opportunity_id;

-- Retrieve information about partnerships and associated companies with earnings greater than 80000:

SELECT p.name AS partnership_name, p.earnings, c.name AS company_name, c.location_id
FROM Partnerships p
JOIN Companies c ON p.company_id = c.company_id
WHERE p.earnings > 80000;

-- List all observations made in locations with a specific habitat type:

SELECT o.observation_id, o.observation_date, l.location_name, s.common_name, s.habitat_requirements
FROM Observations o
JOIN Locations l ON o.location_id = l.location_id
JOIN Observations_Species os ON o.observation_id = os.Observations_species_id
JOIN Species s ON os.Species_species_id = s.species_id
WHERE s.habitat_requirements = 'Grasslands';

-- Retrieve information about employees and their current job title and grade:

SELECT e.employee_id, e.first_name, e.last_name, j.job_title, jg.grade_level
FROM Employees e
JOIN Jobs j ON e.job_id = j.job_id
JOIN Job_Grades jg ON e.salary BETWEEN jg.lowest_salary AND jg.highest_salary;

-- List all projects and associated employees with a budget greater than 150000:

SELECT p.project_id, p.name AS project_name, p.budget, e.employee_id, e.first_name, e.last_name
FROM Projects p
JOIN Employees e ON p.employee_id = e.employee_id
WHERE p.budget > 150000;

-- Retrieve information about observations made by employees in a specific department:

SELECT o.observation_id, o.observation_date, e.employee_id, e.first_name, e.last_name, d.dept_name
FROM Observations o
JOIN Employees e ON o.observer_id = e.employee_id
JOIN Department d ON e.deptartment_id = d.dept_id
WHERE d.dept_name = 'Wildlife Conservation';

-- List all volunteer opportunities and associated projects with a start date within the next 2 months:

SELECT vo.opportunity_id, vo.description AS volunteer_opportunity, p.project_id, p.name AS project_name, p.start_date
FROM Volunteer_Opportunities vo
JOIN Volunteers_Volunteer_Opportunities vvo ON vo.opportunity_id = vvo.Volunteer_Opportunities_opportunity_id
JOIN Projects_Volunteers pv ON vvo.Volunteers_volunteer_id = pv.Volunteers_volunteer_id
JOIN Projects p ON pv.Projects_volunteer_id = p.project_id
WHERE p.start_date BETWEEN SYSDATE AND ADD_MONTHS(SYSDATE, 2);

-- Retrieve information about observations made by employees with the highest salary in each department:

SELECT o.observation_id, o.observation_date, e.employee_id, e.first_name, e.last_name, d.dept_name
FROM Observations o
JOIN Employees e ON o.observer_id = e.employee_id
JOIN Department d ON e.deptartment_id = d.dept_id
WHERE (e.salary, e.deptartment_id) IN (
  SELECT MAX(e.salary), e.deptartment_id
  FROM Employees e
  GROUP BY e.deptartment_id
);
