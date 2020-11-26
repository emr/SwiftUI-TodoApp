import { Injectable } from '@nestjs/common';
import { Task } from './task.entity';
import CreateTaskDto from './create-task.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ObjectID } from 'mongodb';

@Injectable()
export class TaskService {
  constructor(@InjectRepository(Task) private repository: Repository<Task>) {}

  create(createTaskDto: CreateTaskDto): Promise<Task> {
    const task = new Task(
      createTaskDto.title,
      createTaskDto.description,
      createTaskDto.status,
      createTaskDto.dueDate,
    );
    return this.repository.save(task);
  }

  findAll(): Promise<Task[]> {
    return this.repository.find();
  }

  async findOne(id: string): Promise<Task | undefined> {
    if (ObjectID.isValid(id)) {
      return this.repository.findOne(id);
    }
    return undefined;
  }
}
