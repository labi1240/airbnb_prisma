import { PrismaClient } from '@prisma/client';
import fs from 'fs';

const prisma = new PrismaClient();

async function seedDatabase() {
  const data = JSON.parse(fs.readFileSync('data.json', 'utf-8'));

  for (const item of data) {
    try {
      const property = await prisma.property.create({
        data: {
          name: item.name,
          status: item.status,
          price: item.price,
          incentives: item.incentives,
          address: item.address,
          developer: item.developer,
          buildingType: item.buildingType,
          unitsStories: item.unitsStories,
          bedrooms: item.bedrooms,
          sizeSqFt: item.sizeSqFt,
          estimatedCompletion: item.estimatedCompletion,
          summary: item.summary,
        },
      });

      for (const unit of item.units) {
        await prisma.unit.create({
          data: {
            propertyId: property.id,
            status: unit.status,
            statusName: unit.statusName,
            colType: unit.colType,
            unitType: unit.unitType,
            unitName: unit.unitName,
            br: unit.br,
            ba: unit.ba,
            sqft: unit.sqft,
            lotBalc: unit.lotBalc,
            price: unit.price,
            lastPrice: unit.lastPrice,
            lastPriceWithValue: unit.lastPriceWithValue,
            unitStyle: unit.unitStyle,
            url: unit.url,
            image: unit.image,
            label: unit.label,
            labelColor: unit.labelColor,
            providerPlan: unit.providerPlan,
            prelaunch: unit.prelaunch,
            quickMoveInDate: unit.quickMoveInDate,
            isQuickMoveIn: unit.isQuickMoveIn,
            displayPricePerSqFt: unit.displayPricePerSqFt,
          },
        });
      }

      await prisma.galleryData.create({
        data: {
          propertyId: property.id,
          objectID: item.galleryData.ObjectID,
          galleryID: item.galleryData.GalleryID,
          images: item.galleryData.Images,
        },
      });
    } catch (error) {
      console.error(`Error seeding data: ${error.message}`);
    }
  }

  console.log('Database has been successfully seeded.');
}

seedDatabase().catch((e) => {
  console.error(e);
  process.exit(1);
});
