-- CreateTable
CREATE TABLE "Role" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Status" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,

    CONSTRAINT "Status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmploymentType" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "EmploymentType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Location" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Benefit" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "Benefit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Company" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Employee" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InterviewFlow" (
    "id" SERIAL NOT NULL,
    "description" VARCHAR(255) NOT NULL,

    CONSTRAINT "InterviewFlow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Position" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "interviewFlowId" INTEGER NOT NULL,
    "employmentTypeId" INTEGER NOT NULL,
    "statusId" INTEGER NOT NULL,
    "locationId" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "isVisible" BOOLEAN NOT NULL DEFAULT true,
    "jobDescription" TEXT,
    "requirements" TEXT,
    "responsibilities" TEXT,
    "salaryMin" DECIMAL(12,2),
    "salaryMax" DECIMAL(12,2),
    "applicationDeadline" TIMESTAMP(3),
    "contactInfo" VARCHAR(255),

    CONSTRAINT "Position_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PositionBenefit" (
    "positionId" INTEGER NOT NULL,
    "benefitId" INTEGER NOT NULL,

    CONSTRAINT "PositionBenefit_pkey" PRIMARY KEY ("positionId","benefitId")
);

-- CreateTable
CREATE TABLE "InterviewType" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,

    CONSTRAINT "InterviewType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InterviewStep" (
    "id" SERIAL NOT NULL,
    "interviewFlowId" INTEGER NOT NULL,
    "interviewTypeId" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "orderIndex" INTEGER NOT NULL,

    CONSTRAINT "InterviewStep_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Candidate" (
    "id" SERIAL NOT NULL,
    "firstName" VARCHAR(100) NOT NULL,
    "lastName" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(15),
    "address" VARCHAR(100),

    CONSTRAINT "Candidate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Application" (
    "id" SERIAL NOT NULL,
    "positionId" INTEGER NOT NULL,
    "candidateId" INTEGER NOT NULL,
    "statusId" INTEGER NOT NULL,
    "applicationDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" TEXT,

    CONSTRAINT "Application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Interview" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER NOT NULL,
    "interviewStepId" INTEGER NOT NULL,
    "employeeId" INTEGER,
    "interviewDate" TIMESTAMP(3) NOT NULL,
    "result" VARCHAR(50),
    "score" INTEGER,
    "notes" TEXT,

    CONSTRAINT "Interview_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Role_name_key" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Status_name_key" ON "Status"("name");

-- CreateIndex
CREATE UNIQUE INDEX "EmploymentType_name_key" ON "EmploymentType"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Location_name_key" ON "Location"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Benefit_name_key" ON "Benefit"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_email_key" ON "Employee"("email");

-- CreateIndex
CREATE INDEX "Employee_companyId_idx" ON "Employee"("companyId");

-- CreateIndex
CREATE INDEX "Employee_roleId_idx" ON "Employee"("roleId");

-- CreateIndex
CREATE INDEX "Position_companyId_idx" ON "Position"("companyId");

-- CreateIndex
CREATE INDEX "Position_interviewFlowId_idx" ON "Position"("interviewFlowId");

-- CreateIndex
CREATE INDEX "Position_employmentTypeId_idx" ON "Position"("employmentTypeId");

-- CreateIndex
CREATE INDEX "Position_statusId_idx" ON "Position"("statusId");

-- CreateIndex
CREATE INDEX "Position_locationId_idx" ON "Position"("locationId");

-- CreateIndex
CREATE INDEX "InterviewStep_interviewFlowId_idx" ON "InterviewStep"("interviewFlowId");

-- CreateIndex
CREATE INDEX "InterviewStep_interviewTypeId_idx" ON "InterviewStep"("interviewTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "Candidate_email_key" ON "Candidate"("email");

-- CreateIndex
CREATE INDEX "Application_positionId_idx" ON "Application"("positionId");

-- CreateIndex
CREATE INDEX "Application_candidateId_idx" ON "Application"("candidateId");

-- CreateIndex
CREATE INDEX "Application_statusId_idx" ON "Application"("statusId");

-- CreateIndex
CREATE INDEX "Interview_applicationId_idx" ON "Interview"("applicationId");

-- CreateIndex
CREATE INDEX "Interview_interviewStepId_idx" ON "Interview"("interviewStepId");

-- CreateIndex
CREATE INDEX "Interview_employeeId_idx" ON "Interview"("employeeId");

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_interviewFlowId_fkey" FOREIGN KEY ("interviewFlowId") REFERENCES "InterviewFlow"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_employmentTypeId_fkey" FOREIGN KEY ("employmentTypeId") REFERENCES "EmploymentType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "Status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PositionBenefit" ADD CONSTRAINT "PositionBenefit_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PositionBenefit" ADD CONSTRAINT "PositionBenefit_benefitId_fkey" FOREIGN KEY ("benefitId") REFERENCES "Benefit"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InterviewStep" ADD CONSTRAINT "InterviewStep_interviewFlowId_fkey" FOREIGN KEY ("interviewFlowId") REFERENCES "InterviewFlow"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InterviewStep" ADD CONSTRAINT "InterviewStep_interviewTypeId_fkey" FOREIGN KEY ("interviewTypeId") REFERENCES "InterviewType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_candidateId_fkey" FOREIGN KEY ("candidateId") REFERENCES "Candidate"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "Status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_interviewStepId_fkey" FOREIGN KEY ("interviewStepId") REFERENCES "InterviewStep"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "Employee"("id") ON DELETE SET NULL ON UPDATE CASCADE;
