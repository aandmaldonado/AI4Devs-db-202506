-- SQL Script for ERD: Recruitment System (PascalCase, quoted)
-- Generated for PostgreSQL

CREATE TABLE "Role" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE "Status" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE "EmploymentType" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE "Location" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE "Benefit" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE "Company" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT
);

CREATE TABLE "Employee" (
    "id" SERIAL PRIMARY KEY,
    "companyId" INTEGER NOT NULL REFERENCES "Company"("id") ON DELETE CASCADE,
    "roleId" INTEGER NOT NULL REFERENCES "Role"("id"),
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL UNIQUE,
    "isActive" BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE INDEX "idx_Employee_companyId" ON "Employee"("companyId");
CREATE INDEX "idx_Employee_roleId" ON "Employee"("roleId");

CREATE TABLE "InterviewFlow" (
    "id" SERIAL PRIMARY KEY,
    "description" VARCHAR(255) NOT NULL
);

CREATE TABLE "Position" (
    "id" SERIAL PRIMARY KEY,
    "companyId" INTEGER NOT NULL REFERENCES "Company"("id") ON DELETE CASCADE,
    "interviewFlowId" INTEGER NOT NULL REFERENCES "InterviewFlow"("id") ON DELETE RESTRICT,
    "employmentTypeId" INTEGER NOT NULL REFERENCES "EmploymentType"("id"),
    "statusId" INTEGER NOT NULL REFERENCES "Status"("id"),
    "locationId" INTEGER NOT NULL REFERENCES "Location"("id"),
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "isVisible" BOOLEAN NOT NULL DEFAULT TRUE,
    "jobDescription" TEXT,
    "requirements" TEXT,
    "responsibilities" TEXT,
    "salaryMin" NUMERIC(12,2),
    "salaryMax" NUMERIC(12,2),
    "applicationDeadline" DATE,
    "contactInfo" VARCHAR(255)
);
CREATE INDEX "idx_Position_companyId" ON "Position"("companyId");
CREATE INDEX "idx_Position_interviewFlowId" ON "Position"("interviewFlowId");
CREATE INDEX "idx_Position_employmentTypeId" ON "Position"("employmentTypeId");
CREATE INDEX "idx_Position_statusId" ON "Position"("statusId");
CREATE INDEX "idx_Position_locationId" ON "Position"("locationId");

CREATE TABLE "PositionBenefit" (
    "positionId" INTEGER NOT NULL REFERENCES "Position"("id") ON DELETE CASCADE,
    "benefitId" INTEGER NOT NULL REFERENCES "Benefit"("id") ON DELETE CASCADE,
    PRIMARY KEY ("positionId", "benefitId")
);

CREATE TABLE "InterviewType" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT
);

CREATE TABLE "InterviewStep" (
    "id" SERIAL PRIMARY KEY,
    "interviewFlowId" INTEGER NOT NULL REFERENCES "InterviewFlow"("id") ON DELETE CASCADE,
    "interviewTypeId" INTEGER NOT NULL REFERENCES "InterviewType"("id") ON DELETE RESTRICT,
    "name" VARCHAR(100) NOT NULL,
    "orderIndex" INTEGER NOT NULL
);
CREATE INDEX "idx_InterviewStep_interviewFlowId" ON "InterviewStep"("interviewFlowId");
CREATE INDEX "idx_InterviewStep_interviewTypeId" ON "InterviewStep"("interviewTypeId");

CREATE TABLE "Candidate" (
    "id" SERIAL PRIMARY KEY,
    "firstName" VARCHAR(100) NOT NULL,
    "lastName" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL UNIQUE,
    "phone" VARCHAR(15),
    "address" VARCHAR(100)
);

CREATE TABLE "Application" (
    "id" SERIAL PRIMARY KEY,
    "positionId" INTEGER NOT NULL REFERENCES "Position"("id") ON DELETE CASCADE,
    "candidateId" INTEGER NOT NULL REFERENCES "Candidate"("id") ON DELETE CASCADE,
    "statusId" INTEGER NOT NULL REFERENCES "Status"("id"),
    "applicationDate" DATE NOT NULL DEFAULT CURRENT_DATE,
    "notes" TEXT
);
CREATE INDEX "idx_Application_positionId" ON "Application"("positionId");
CREATE INDEX "idx_Application_candidateId" ON "Application"("candidateId");
CREATE INDEX "idx_Application_statusId" ON "Application"("statusId");

CREATE TABLE "Interview" (
    "id" SERIAL PRIMARY KEY,
    "applicationId" INTEGER NOT NULL REFERENCES "Application"("id") ON DELETE CASCADE,
    "interviewStepId" INTEGER NOT NULL REFERENCES "InterviewStep"("id") ON DELETE RESTRICT,
    "employeeId" INTEGER NOT NULL REFERENCES "Employee"("id") ON DELETE SET NULL,
    "interviewDate" DATE NOT NULL,
    "result" VARCHAR(50),
    "score" INTEGER,
    "notes" TEXT
);
CREATE INDEX "idx_Interview_applicationId" ON "Interview"("applicationId");
CREATE INDEX "idx_Interview_interviewStepId" ON "Interview"("interviewStepId");
CREATE INDEX "idx_Interview_employeeId" ON "Interview"("employeeId");
