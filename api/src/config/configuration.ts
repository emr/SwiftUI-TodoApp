import { TypeOrmModuleOptions } from '@nestjs/typeorm';

interface Configuration {
  app: {
    env: string;
    port: number;
  };
  database: TypeOrmModuleOptions;
}

export const env = process.env.NODE_ENV || 'dev';

export default (): Configuration => ({
  app: {
    env,
    port: parseInt(process.env.PORT || '80', 10),
  },
  database: {
    type: 'mongodb',
    url: process.env.MONGO_URI || '',
    entities: [__dirname + '/../**/*.entity.ts'],
  },
});
