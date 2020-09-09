import { Injectable } from '@nestjs/common';
import { Task } from './task.entity';
import CreateTaskDto from './create-task.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm/index';

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
}
