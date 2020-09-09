import { Module } from '@nestjs/common';
import { TaskModule } from './task/task.module';
import { TaskController } from './task/task.controller';
import { ConfigModule, ConfigService } from '@nestjs/config';
import configuration, { env } from './config/configuration';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: [`.env.${env}.local`, `.env.${env}`, `.env.local`],
      load: [configuration],
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (config: ConfigService) => config.get('database', {}),
      inject: [ConfigService],
    }),
    TaskModule,
  ],
  controllers: [TaskController],
})
export class AppModule {}
