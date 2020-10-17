import * as request from 'supertest';
import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { AppModule } from '../../src/app.module';
import { Task } from '../../src/task/task.entity';
import { Connection, Repository } from 'typeorm';
import { getRepositoryToken } from '@nestjs/typeorm';
import { createCreateTaskDto, createTask } from '../helper/task';

describe('AppController (e2e)', () => {
  let app: INestApplication;
  let repository: Repository<Task>;
  let connection: Connection;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalPipes(
      new ValidationPipe({
        transform: true,
      }),
    );
    repository = app.get(getRepositoryToken(Task));
    connection = app.get(Connection);

    await app.init();
  });

  beforeEach(async () => {
    await connection.synchronize(true);
  });

  it('/tasks (GET) should return all tasks', async () => {
    const tasks = [
      createTask({ title: 'Task 1' }),
      createTask({ title: 'Task 2' }),
      createTask({ title: 'Task 3' }),
      createTask({ title: 'Task 4' }),
      createTask({ title: 'Task 5' }),
    ];
    await Promise.all(tasks.map(t => repository.save(t)));

    const response = await request(app.getHttpServer()).get('/tasks');

    expect(response.status).toEqual(200);
    expect(response?.body).toEqual(
      expect.arrayContaining(
        tasks.map(task => ({
          ...task,
          id: task.id?.toString(),
          dueDate: task.dueDate.toISOString(),
          createdAt: task.createdAt.toISOString(),
        })),
      ),
    );
  });

  it('/tasks (POST) should return the saved task', async () => {
    const data = createCreateTaskDto();

    const postedAt = new Date();
    const response = await request(app.getHttpServer())
      .post('/tasks')
      .send(data);

    expect(response.status).toEqual(201);
    expect(response.body?.title).toEqual(data.title);
    expect(response.body?.description).toEqual(data.description);
    expect(response.body?.status).toEqual(data.status);
    expect(response.body?.dueDate).toEqual(data.dueDate.toISOString());
    expect(
      new Date(response.body?.createdAt).getTime() - postedAt.getTime(),
    ).toBeLessThan(1000);
  });

  describe('/tasks (POST) validation errors', () => {
    it('should return error for empty fields', async () => {
      const data = createCreateTaskDto();
      data.title = '';
      data.status = '';

      const response = await request(app.getHttpServer())
        .post('/tasks')
        .send(data);

      expect(response.status).toEqual(400);
      expect(response.body?.message[0]?.property).toEqual('title');
      expect(response.body?.message[0]?.constraints?.isNotEmpty).toEqual(
        'title should not be empty',
      );
      expect(response.body?.message[1]?.property).toEqual('status');
      expect(response.body?.message[1]?.constraints?.isNotEmpty).toEqual(
        'status should not be empty',
      );
    });

    it('should return error for non-iso date format', async () => {
      const data = createCreateTaskDto() as any;
      data.dueDate = 'zero.zero.one.one.zero.one.one';

      const response = await request(app.getHttpServer())
        .post('/tasks')
        .send(data);

      expect(response.status).toEqual(400);
      expect(response.body?.message[0]?.property).toEqual('dueDate');
      expect(response.body?.message[0]?.constraints?.isDate).toEqual(
        'dueDate must be a Date instance',
      );
    });
  });
});
