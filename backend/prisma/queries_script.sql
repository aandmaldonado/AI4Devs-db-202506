-- Consultas de validación y rendimiento para el sistema de reclutamiento (PascalCase, quoted)

-- 1. Listar todas las posiciones abiertas con información de la empresa, tipo de empleo, status y ubicación
SELECT p."id", p."title", s."name" AS status, c."name" AS company, f."description" AS interview_flow, et."name" AS employment_type, l."name" AS location
FROM "Position" p
JOIN "Company" c ON p."companyId" = c."id"
JOIN "InterviewFlow" f ON p."interviewFlowId" = f."id"
JOIN "Status" s ON p."statusId" = s."id"
JOIN "EmploymentType" et ON p."employmentTypeId" = et."id"
JOIN "Location" l ON p."locationId" = l."id"
WHERE s."name" = 'Abierta';

-- 2. Obtener todos los candidatos y el número de aplicaciones realizadas
SELECT cand."id", cand."firstName", cand."lastName", COUNT(app."id") AS total_aplicaciones
FROM "Candidate" cand
LEFT JOIN "Application" app ON cand."id" = app."candidateId"
GROUP BY cand."id", cand."firstName", cand."lastName";

-- 3. Consultar el detalle de entrevistas de un candidato específico (por email)
SELECT i."id" AS interview_id, i."interviewDate", i."result", i."score", istep."name" AS step, itype."name" AS type, emp."name" AS entrevistador
FROM "Interview" i
JOIN "Application" app ON i."applicationId" = app."id"
JOIN "Candidate" cand ON app."candidateId" = cand."id"
JOIN "InterviewStep" istep ON i."interviewStepId" = istep."id"
JOIN "InterviewType" itype ON istep."interviewTypeId" = itype."id"
LEFT JOIN "Employee" emp ON i."employeeId" = emp."id"
WHERE cand."email" = 'carlos.sanchez@email.com';

-- 4. Listar todas las aplicaciones a una posición específica, con estado y datos del candidato
SELECT app."id" AS application_id, s."name" AS status, cand."firstName", cand."lastName", cand."email"
FROM "Application" app
JOIN "Candidate" cand ON app."candidateId" = cand."id"
JOIN "Status" s ON app."statusId" = s."id"
WHERE app."positionId" = 1;

-- 5. Consultar el pipeline de entrevistas para una posición (todas las entrevistas y pasos)
SELECT p."title", cand."firstName", cand."lastName", istep."name" AS paso, i."interviewDate", i."result"
FROM "Interview" i
JOIN "Application" app ON i."applicationId" = app."id"
JOIN "Position" p ON app."positionId" = p."id"
JOIN "Candidate" cand ON app."candidateId" = cand."id"
JOIN "InterviewStep" istep ON i."interviewStepId" = istep."id"
WHERE p."id" = 1
ORDER BY cand."lastName", istep."orderIndex";

-- 6. Consulta de rendimiento: contar el total de entrevistas realizadas por cada empleado (entrevistador) y su rol
SELECT emp."id", emp."name", r."name" AS role, COUNT(i."id") AS total_entrevistas
FROM "Employee" emp
JOIN "Role" r ON emp."roleId" = r."id"
LEFT JOIN "Interview" i ON emp."id" = i."employeeId"
GROUP BY emp."id", emp."name", r."name"
ORDER BY total_entrevistas DESC;

-- 7. Consulta de rendimiento: obtener el tiempo promedio entre la aplicación y la primera entrevista por candidato
SELECT cand."id", cand."firstName", cand."lastName",
       AVG(i."interviewDate" - app."applicationDate") AS avg_dias_espera
FROM "Candidate" cand
JOIN "Application" app ON cand."id" = app."candidateId"
JOIN "Interview" i ON app."id" = i."applicationId"
WHERE i."interviewStepId" = (
    SELECT MIN(istep."id") FROM "InterviewStep" istep WHERE istep."interviewFlowId" = (
        SELECT p."interviewFlowId" FROM "Position" p WHERE p."id" = app."positionId"
    )
)
GROUP BY cand."id", cand."firstName", cand."lastName";

-- 8. Consulta de validación: obtener todas las posiciones y el número de aplicaciones recibidas
SELECT p."id", p."title", s."name" AS status, COUNT(app."id") AS total_aplicaciones
FROM "Position" p
JOIN "Status" s ON p."statusId" = s."id"
LEFT JOIN "Application" app ON p."id" = app."positionId"
GROUP BY p."id", p."title", s."name"
ORDER BY total_aplicaciones DESC;

-- 9. Listar los beneficios asociados a cada posición
SELECT p."title", b."name" AS benefit
FROM "PositionBenefit" pb
JOIN "Position" p ON pb."positionId" = p."id"
JOIN "Benefit" b ON pb."benefitId" = b."id"
ORDER BY p."title", b."name";

-- 10. Ranking de candidatos por número de entrevistas aprobadas
SELECT cand."id", cand."firstName", cand."lastName", COUNT(i."id") AS entrevistas_aprobadas
FROM "Candidate" cand
JOIN "Application" app ON cand."id" = app."candidateId"
JOIN "Interview" i ON app."id" = i."applicationId"
WHERE i."result" = 'Aprobado'
GROUP BY cand."id", cand."firstName", cand."lastName"
ORDER BY entrevistas_aprobadas DESC
LIMIT 10;

-- 11. Tiempo promedio de contratación por posición (días entre aplicación y última entrevista aprobada con resultado 'Contratada')
SELECT p."title", AVG(i."interviewDate" - app."applicationDate") AS avg_dias_contratacion
FROM "Position" p
JOIN "Application" app ON p."id" = app."positionId"
JOIN "Interview" i ON app."id" = i."applicationId"
JOIN "Status" s ON app."statusId" = s."id"
WHERE s."name" = 'Contratada' AND i."result" = 'Aprobado'
GROUP BY p."title"
ORDER BY avg_dias_contratacion;

-- 12. Top beneficios más ofrecidos en posiciones abiertas
SELECT b."name" AS benefit, COUNT(pb."positionId") AS total_posiciones
FROM "Benefit" b
JOIN "PositionBenefit" pb ON b."id" = pb."benefitId"
JOIN "Position" p ON pb."positionId" = p."id"
JOIN "Status" s ON p."statusId" = s."id"
WHERE s."name" = 'Abierta'
GROUP BY b."name"
ORDER BY total_posiciones DESC
LIMIT 5;

-- 13. Tasa de conversión de aplicaciones a contrataciones por posición
SELECT p."title", COUNT(app."id") FILTER (WHERE s."name" = 'Contratada')::float / NULLIF(COUNT(app."id"),0) AS tasa_conversion
FROM "Position" p
LEFT JOIN "Application" app ON p."id" = app."positionId"
LEFT JOIN "Status" s ON app."statusId" = s."id"
GROUP BY p."title"
ORDER BY tasa_conversion DESC;

-- 14. Distribución de roles por empresa
SELECT c."name" AS company, r."name" AS role, COUNT(e."id") AS total_empleados
FROM "Company" c
JOIN "Employee" e ON c."id" = e."companyId"
JOIN "Role" r ON e."roleId" = r."id"
GROUP BY c."name", r."name"
ORDER BY c."name", total_empleados DESC;
