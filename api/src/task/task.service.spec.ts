import { Test } from '@nestjs/testing';
import { TaskService } from './task.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Task } from './task.entity';
import { Repository } from 'typeorm/index';
import { createCreateTaskDto, createTask } from '../../test/helper/task';

describe('TaskService', () => {
  let repository: Repository<Task>;
  let service: TaskService;

  beforeAll(async () => {
    const module = await Test.createTestingModule({
      providers: [
        TaskService,
        {
          provide: getRepositoryToken(Task),
          useClass: Repository,
        },
      ],
    }).compile();

    repository = module.get(getRepositoryToken(Task));
    service = module.get(TaskService);
  });

  it('should create a task with given data and return it', async () => {
    const spy = jest
      .spyOn(repository, 'save')
      .mockImplementation(t => t as any);

    const data = createCreateTaskDto();
    const createdTask = await service.create(data);

    expect(spy).toHaveBeenCalled();
    expect(createdTask.title).toEqual(data.title);
    expect(createdTask.dueDate).toEqual(data.dueDate);
    expect(new Date().getTime() - createdTask.createdAt.getTime()).toBeLessThan(
      1000,
    );
  });

  it('should return all tasks', async () => {
    const tasks = [createTask({ id: '1' }), createTask({ id: '2' })];
    const spy = jest.spyOn(repository, 'find').mockResolvedValue(tasks);

    const result = await service.findAll();

    expect(spy).toHaveBeenCalled();
    expect(result).toEqual(tasks);
  });
});
