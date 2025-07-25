TRUNCATE TABLE "Interview" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Application" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Candidate" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "PositionBenefit" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Position" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "InterviewStep" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "InterviewType" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "InterviewFlow" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Employee" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Company" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Benefit" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Location" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "EmploymentType" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Status" RESTART IDENTITY CASCADE;
TRUNCATE TABLE "Role" RESTART IDENTITY CASCADE;

-- Datos de ejemplo para poblar el sistema de reclutamiento (PascalCase, quoted)

INSERT INTO "Role" ("name") VALUES
  ('Recruiter'), ('Manager'), ('Tech Lead'), ('HR'), ('Developer'), ('QA'), ('Sales'), ('Support'), ('Architect'), ('Engineer');

INSERT INTO "Status" ("name") VALUES
  ('Abierta'), ('Cerrada'), ('En revisión'), ('Rechazada'), ('Contratada'), ('Pendiente');

INSERT INTO "EmploymentType" ("name") VALUES
  ('Tiempo completo'), ('Medio tiempo'), ('Prácticas'), ('Temporal'), ('Remoto');

INSERT INTO "Location" ("name") VALUES
  ('Barcelona'), ('Madrid'), ('Valencia'), ('Remoto'), ('Sevilla'), ('Bilbao'), ('Málaga'), ('Alicante'), ('Valladolid'), ('Zaragoza');

INSERT INTO "Benefit" ("name") VALUES
  ('Seguro médico'), ('Stock options'), ('Teletrabajo'), ('Formación'), ('Comisiones'), ('Seguro dental'), ('Bono anual');

INSERT INTO "Company" ("name", "description") VALUES
  ('Tech Solutions Inc.', 'Empresa tecnológica líder'),
  ('Innovatech S.A.', 'Empresa innovadora'),
  ('Global Talent LLC', 'Consultora internacional'),
  ('NextGen IT', 'Empresa de software'),
  ('PeopleFirst HR', 'Empresa de RRHH'),
  ('DataDriven Corp.', 'Empresa de datos'),
  ('Cloudify Ltd.', 'Cloud company'),
  ('AI4Devs', 'Startup IA'),
  ('SoftWorks', 'Empresa software'),
  ('Talentum', 'Empresa tecnológica');

INSERT INTO "Employee" ("companyId", "roleId", "name", "email", "isActive") VALUES
  (1, 1, 'Ana García', 'ana.garcia@techsolutions.com', true),
  (1, 2, 'Luis Pérez', 'luis.perez@techsolutions.com', true),
  (2, 1, 'Marta López', 'marta.lopez@innovatech.com', true),
  (2, 3, 'Pedro Ruiz', 'pedro.ruiz@innovatech.com', true),
  (3, 1, 'Sofía Torres', 'sofia.torres@globaltalent.com', true),
  (3, 2, 'Javier Gómez', 'javier.gomez@globaltalent.com', true),
  (4, 1, 'Elena Martín', 'elena.martin@nextgenit.com', true),
  (5, 4, 'Raúl Sánchez', 'raul.sanchez@peoplefirst.com', true),
  (6, 1, 'Patricia Díaz', 'patricia.diaz@datadriven.com', true),
  (7, 2, 'Miguel Castro', 'miguel.castro@cloudify.com', true),
  (8, 1, 'Laura Romero', 'laura.romero@ai4devs.com', true),
  (9, 1, 'Daniela Vega', 'daniela.vega@softworks.com', true),
  (10, 2, 'Alberto Molina', 'alberto.molina@talentum.com', true),
  (1, 5, 'Mario Torres', 'mario.torres@techsolutions.com', true),
  (2, 6, 'Eva Ramos', 'eva.ramos@innovatech.com', true),
  (3, 7, 'Tomás Gil', 'tomas.gil@globaltalent.com', true),
  (4, 8, 'Nuria Peña', 'nuria.pena@nextgenit.com', true),
  (5, 9, 'Jorge Vidal', 'jorge.vidal@peoplefirst.com', true),
  (6, 10, 'Silvia León', 'silvia.leon@datadriven.com', true),
  (7, 1, 'Carmen Ruiz', 'carmen.ruiz@cloudify.com', true),
  (8, 2, 'Hugo Ortega', 'hugo.ortega@ai4devs.com', true),
  (9, 3, 'Paula Soto', 'paula.soto@softworks.com', true),
  (10, 4, 'Rubén Lozano', 'ruben.lozano@talentum.com', true);

INSERT INTO "InterviewFlow" ("description") VALUES
  ('Flujo estándar de desarrollo'),
  ('Flujo ejecutivo'),
  ('Flujo junior'),
  ('Flujo senior'),
  ('Flujo ventas'),
  ('Flujo soporte');

INSERT INTO "InterviewType" ("name", "description") VALUES
  ('Técnica', 'Evaluación de habilidades técnicas'),
  ('RRHH', 'Entrevista de recursos humanos'),
  ('Gerencial', 'Evaluación de liderazgo y gestión'),
  ('Cultural', 'Fit cultural'),
  ('Idiomas', 'Prueba de idiomas');

INSERT INTO "InterviewStep" ("interviewFlowId", "interviewTypeId", "name", "orderIndex") VALUES
  (1, 1, 'Prueba técnica', 1),
  (1, 2, 'Entrevista RRHH', 2),
  (1, 4, 'Fit cultural', 3),
  (2, 3, 'Entrevista Gerencial', 1),
  (2, 2, 'Entrevista RRHH', 2),
  (3, 1, 'Prueba técnica', 1),
  (3, 2, 'Entrevista RRHH', 2),
  (4, 1, 'Prueba técnica avanzada', 1),
  (4, 3, 'Entrevista Gerencial', 2),
  (5, 2, 'Entrevista RRHH', 1),
  (5, 5, 'Prueba de idiomas', 2),
  (6, 2, 'Entrevista RRHH', 1);

INSERT INTO "Position" ("companyId", "interviewFlowId", "employmentTypeId", "statusId", "locationId", "title", "description", "isVisible", "jobDescription", "requirements", "responsibilities", "salaryMin", "salaryMax", "applicationDeadline", "contactInfo") VALUES
  (1, 1, 1, 1, 1, 'Backend Developer', 'Desarrollador Node.js', true, 'Desarrollo de APIs', 'Node.js, PostgreSQL', 'Desarrollar y mantener servicios', 30000, 45000, '2024-12-31', 'recruit@techsolutions.com'),
  (2, 2, 1, 1, 2, 'CTO', 'Chief Technology Officer', true, 'Liderar el área técnica', 'Experiencia en gestión', 'Definir estrategia tecnológica', 70000, 120000, '2024-11-30', 'hr@innovatech.com'),
  (3, 3, 1, 1, 3, 'QA Tester', 'Tester de software', true, 'Pruebas funcionales', 'Automatización, Selenium', 'Testear releases', 25000, 35000, '2024-10-15', 'jobs@globaltalent.com'),
  (4, 4, 1, 1, 4, 'Senior Frontend', 'React Senior', true, 'Desarrollo UI', 'React, TypeScript', 'Liderar equipo frontend', 40000, 60000, '2024-09-30', 'talent@nextgenit.com'),
  (5, 5, 1, 1, 5, 'Sales Executive', 'Ejecutivo de ventas', true, 'Ventas B2B', 'Inglés alto', 'Captar clientes', 28000, 40000, '2024-08-31', 'sales@peoplefirst.com'),
  (6, 6, 1, 1, 6, 'Soporte Técnico', 'Soporte a clientes', true, 'Atención a usuarios', 'Empatía, SQL', 'Resolver incidencias', 22000, 30000, '2024-07-31', 'support@datadriven.com'),
  (7, 1, 1, 1, 4, 'DevOps Engineer', 'Ingeniero DevOps', true, 'Infraestructura cloud', 'AWS, Docker', 'Automatizar despliegues', 35000, 55000, '2024-12-15', 'devops@cloudify.com'),
  (8, 2, 1, 1, 1, 'AI Researcher', 'Investigador IA', true, 'Modelos ML', 'Python, Deep Learning', 'Desarrollar modelos', 50000, 80000, '2024-11-15', 'ai@ai4devs.com'),
  (9, 3, 1, 1, 2, 'Product Owner', 'Responsable producto', true, 'Gestión de producto', 'Scrum, UX', 'Definir roadmap', 45000, 65000, '2024-10-31', 'po@softworks.com'),
  (10, 4, 1, 1, 3, 'Fullstack Developer', 'Desarrollador fullstack', true, 'Frontend y backend', 'React, Node.js', 'Desarrollar features', 32000, 48000, '2024-09-15', 'fullstack@talentum.com');

INSERT INTO "PositionBenefit" ("positionId", "benefitId") VALUES
  (1, 1), (1, 3), (2, 2), (2, 4), (3, 1), (3, 6), (4, 4), (4, 1), (5, 5), (5, 2), (6, 6), (6, 1), (7, 3), (7, 1), (8, 7), (8, 1), (9, 2), (9, 4), (10, 1), (10, 6);

INSERT INTO "Candidate" ("firstName", "lastName", "email", "phone", "address") VALUES
  ('Carlos', 'Sánchez', 'carlos.sanchez@email.com', '600123456', 'Calle Falsa 123, Madrid'),
  ('Lucía', 'Martínez', 'lucia.martinez@email.com', '600654321', 'Av. Real 456, Barcelona'),
  ('Javier', 'Fernández', 'javier.fernandez@email.com', '600111222', 'Calle Luna 12, Valencia'),
  ('María', 'Gómez', 'maria.gomez@email.com', '600333444', 'Calle Sol 34, Sevilla'),
  ('Andrés', 'Ruiz', 'andres.ruiz@email.com', '600555666', 'Av. Mar 56, Bilbao'),
  ('Elena', 'Moreno', 'elena.moreno@email.com', '600777888', 'Calle Río 78, Zaragoza'),
  ('Pablo', 'Navarro', 'pablo.navarro@email.com', '600999000', 'Av. Norte 90, Málaga'),
  ('Sara', 'Romero', 'sara.romero@email.com', '601111222', 'Calle Sur 21, Murcia'),
  ('David', 'Iglesias', 'david.iglesias@email.com', '601333444', 'Av. Este 43, Alicante'),
  ('Marta', 'Vega', 'marta.vega@email.com', '601555666', 'Calle Oeste 65, Valladolid');

INSERT INTO "Application" ("positionId", "candidateId", "statusId", "applicationDate", "notes") VALUES
  (1, 1, 3, '2024-06-01', 'CV recibido'),
  (2, 1, 3, '2024-06-02', 'Aplicación enviada'),
  (3, 2, 3, '2024-06-03', 'CV recibido'),
  (4, 2, 3, '2024-06-04', 'Aplicación enviada'),
  (5, 3, 3, '2024-06-05', 'CV recibido'),
  (6, 3, 3, '2024-06-06', 'Aplicación enviada'),
  (7, 4, 3, '2024-06-07', 'CV recibido'),
  (8, 4, 3, '2024-06-08', 'Aplicación enviada'),
  (9, 5, 3, '2024-06-09', 'CV recibido'),
  (10, 5, 3, '2024-06-10', 'Aplicación enviada');

INSERT INTO "Interview" ("applicationId", "interviewStepId", "employeeId", "interviewDate", "result", "score", "notes") VALUES
  (1, 1, 1, '2024-06-03', 'Aprobado', 85, 'Buen desempeño técnico'),
  (1, 2, 2, '2024-06-04', 'Pendiente', NULL, 'Falta entrevista RRHH'),
  (2, 1, 3, '2024-06-05', 'Aprobado', 90, 'Perfil ejecutivo sólido'),
  (3, 3, 4, '2024-06-06', 'Aprobado', 88, 'Buen fit cultural'),
  (4, 4, 5, '2024-06-07', 'Pendiente', NULL, 'Falta entrevista gerencial'),
  (5, 5, 6, '2024-06-08', 'Aprobado', 92, 'Buen nivel de inglés'),
  (6, 6, 7, '2024-06-09', 'Aprobado', 80, 'Buen desempeño en soporte'),
  (7, 7, 8, '2024-06-10', 'Pendiente', NULL, 'Falta entrevista técnica'),
  (8, 8, 9, '2024-06-11', 'Aprobado', 87, 'Buen desempeño en DevOps'),
  (9, 9, 10, '2024-06-12', 'Aprobado', 89, 'Buen desempeño en AI'),
  (10, 10, 11, '2024-06-13', 'Pendiente', NULL, 'Falta entrevista cultural');
