import { TypeOrmModuleOptions } from '@nestjs/typeorm';

export interface AppConfiguration {
  env: string;
  port: number;
  name: string;
  projectLink?: string;
}

interface Configuration {
  app: AppConfiguration;
  database: TypeOrmModuleOptions;
}

export const env = process.env.NODE_ENV || 'dev';

export default (): Configuration => ({
  app: {
    env,
    port: parseInt(process.env.PORT || '80', 10),
    name: process.env.APP_NAME || '',
    projectLink: process.env.APP_PROJECT_LINK,
  },
  database: {
    type: 'mongodb',
    url: process.env.MONGO_URI || '',
    entities: [__dirname + '/../**/*.entity.{ts,js}'],
  },
});
