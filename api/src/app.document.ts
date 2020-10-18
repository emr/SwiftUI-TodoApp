import { DocumentBuilder } from '@nestjs/swagger';
import { AppConfiguration } from './config/configuration';
import { ComponentsObject } from '@nestjs/swagger/dist/interfaces/open-api-spec.interface';

export class AppDocument {
  static getOptions(config: AppConfiguration) {
    const options = new DocumentBuilder()
      .setTitle(config.name)
      .setDescription(
        'A restful API implementation which contains CRUD operations on tasks for TodoApp project',
      )
      .setVersion('1.0');
    if (config.projectLink) {
      options.setExternalDoc('Project Source', config.projectLink);
    }
    return options.build();
  }

  static getComponents(): ComponentsObject {
    return {
      schemas: {
        CreateTaskDto: {
          title: 'Create Task',
          properties: {
            title: {
              type: 'string',
            },
            description: {
              type: 'string',
            },
            status: {
              type: 'string',
            },
            dueDate: {
              type: 'string',
              format: 'date-time',
              description: 'ISO8601',
            },
          },
        },
      },
    };
  }
}
