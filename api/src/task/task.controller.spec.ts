import { TaskController } from './task.controller';
import { TaskService } from './task.service';
import { Test } from '@nestjs/testing';
import { Task } from './task.entity';
import { createTask } from '../../test/helper/task';
import { getRepositoryToken } from '@nestjs/typeorm';
import { HttpException, NotFoundException } from '@nestjs/common';

describe('TaskController', () => {
  let taskController: TaskController;
  let taskService: TaskService;

  beforeAll(async () => {
    const module = await Test.createTestingModule({
      controllers: [TaskController],
      providers: [
        TaskService,
        {
          provide: getRepositoryToken(Task),
          useValue: {},
        },
      ],
    }).compile();

    taskService = module.get(TaskService);
    taskController = module.get(TaskController);
  });

  describe('findAll', () => {
    it('should call taskService.findAll and return the value', async () => {
      const tasks = [
        createTask({
          title: 'Fake title',
          description: 'Fake description',
        }),
        createTask({
          title: 'Fake title 2',
          description: 'Fake description 2',
        }),
      ];
      const spy = jest.spyOn(taskService, 'findAll').mockResolvedValue(tasks);
      const result = await taskController.findAll();

      expect(spy).toHaveBeenCalled();
      expect(result).toEqual(tasks);
    });
  });

  describe('create', () => {
    it('should call taskService.create and return the value', async () => {
      const data = {
        title: 'Title',
        description: 'Description',
        status: 'status',
        dueDate: new Date(),
      };
      const task = createTask(data);
      jest.spyOn(taskService, 'create').mockResolvedValue(task);

      expect(await taskController.create(data)).toEqual(task);
    });
  });

  describe('findOne', () => {
    it('should call taskService.findOne and return the value', async () => {
      const task = createTask({
        id: '1',
        title: 'Title',
        description: 'Description',
        status: 'status',
        dueDate: new Date(),
      });
      const spy = jest.spyOn(taskService, 'findOne').mockResolvedValue(task);

      expect(await taskController.findOne('1')).toEqual(task);
      expect(spy).toHaveBeenCalledWith('1');
    });

    it('should throw http not found error when a task is not found', async () => {
      jest.spyOn(taskService, 'findOne').mockResolvedValue(undefined);
      await expect(taskController.findOne('1')).rejects.toThrow(
        NotFoundException,
      );
    });
  });
});
