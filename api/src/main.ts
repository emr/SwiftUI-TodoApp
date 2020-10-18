import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';
import { Logger, ValidationPipe } from '@nestjs/common';
import { SwaggerModule } from '@nestjs/swagger';
import { AppDocument } from './app.document';
import { AppConfiguration } from './config/configuration';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
    }),
  );
  const config: AppConfiguration = app.get(ConfigService).get('app')!;
  const document = SwaggerModule.createDocument(
    app,
    AppDocument.getOptions(config),
  );
  document.components = AppDocument.getComponents();
  SwaggerModule.setup('', app, document);

  const port = config.port;
  await app.listen(port);
  Logger.log(`API is running on port ${port}`);
}
bootstrap();
