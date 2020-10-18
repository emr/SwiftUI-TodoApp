import {
  Body,
  Controller,
  Get,
  NotFoundException,
  Param,
  Post,
} from '@nestjs/common';
import { Task } from './task.entity';
import CreateTaskDto from './create-task.dto';
import { TaskService } from './task.service';
import { ObjectID } from 'mongodb';

@Controller({ path: '/tasks' })
export class TaskController {
  constructor(private taskService: TaskService) {}

  @Post()
  create(@Body() createTaskDto: CreateTaskDto): Promise<Task> {
    return this.taskService.create(createTaskDto);
  }

  @Get()
  findAll(): Promise<Task[]> {
    return this.taskService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id') id: string): Promise<Task> {
    let task;
    if (ObjectID.isValid(id)) {
      task = await this.taskService.findOne(id);
    }
    if (!task) {
      throw new NotFoundException(`Task not found with id ${id}`);
    }
    return task;
  }
}
