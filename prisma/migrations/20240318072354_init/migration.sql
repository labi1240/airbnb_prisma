-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "profileImage" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Home" (
    "id" TEXT NOT NULL,
    "title" TEXT,
    "description" TEXT,
    "guests" TEXT,
    "bedrooms" TEXT,
    "bathrooms" TEXT,
    "country" TEXT,
    "photo" TEXT,
    "price" INTEGER,
    "categoryName" TEXT,
    "addedCategory" BOOLEAN NOT NULL DEFAULT false,
    "addedDescription" BOOLEAN NOT NULL DEFAULT false,
    "addedLoaction" BOOLEAN NOT NULL DEFAULT false,
    "createdAT" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT,

    CONSTRAINT "Home_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Favorite" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "homeId" TEXT,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Favorite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Reservation" (
    "id" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT,
    "homeId" TEXT,

    CONSTRAINT "Reservation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Property" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "price" TEXT,
    "incentives" TEXT,
    "address" TEXT NOT NULL,
    "developer" TEXT NOT NULL,
    "buildingType" TEXT NOT NULL,
    "unitsStories" TEXT,
    "bedrooms" TEXT NOT NULL,
    "sizeSqFt" TEXT NOT NULL,
    "estimatedCompletion" TEXT NOT NULL,
    "summary" TEXT NOT NULL,

    CONSTRAINT "Property_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Unit" (
    "id" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "statusName" TEXT NOT NULL,
    "colType" TEXT NOT NULL,
    "unitType" TEXT NOT NULL,
    "unitName" TEXT NOT NULL,
    "br" DOUBLE PRECISION NOT NULL,
    "ba" INTEGER NOT NULL,
    "sqft" INTEGER NOT NULL,
    "lotBalc" TEXT,
    "price" INTEGER,
    "lastPrice" INTEGER,
    "lastPriceWithValue" INTEGER,
    "unitStyle" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "label" TEXT,
    "labelColor" TEXT,
    "providerPlan" TEXT,
    "prelaunch" BOOLEAN NOT NULL DEFAULT false,
    "quickMoveInDate" TEXT,
    "isQuickMoveIn" BOOLEAN NOT NULL DEFAULT false,
    "displayPricePerSqFt" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Unit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GalleryData" (
    "id" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "objectID" TEXT NOT NULL,
    "galleryID" TEXT NOT NULL,
    "images" JSONB NOT NULL,

    CONSTRAINT "GalleryData_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_id_key" ON "User"("id");

-- CreateIndex
CREATE INDEX "Unit_propertyId_idx" ON "Unit"("propertyId");

-- CreateIndex
CREATE INDEX "GalleryData_propertyId_idx" ON "GalleryData"("propertyId");

-- AddForeignKey
ALTER TABLE "Home" ADD CONSTRAINT "Home_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorite" ADD CONSTRAINT "Favorite_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorite" ADD CONSTRAINT "Favorite_homeId_fkey" FOREIGN KEY ("homeId") REFERENCES "Home"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_homeId_fkey" FOREIGN KEY ("homeId") REFERENCES "Home"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Unit" ADD CONSTRAINT "Unit_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GalleryData" ADD CONSTRAINT "GalleryData_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
