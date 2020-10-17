import { Body, Controller, Get, Post } from '@nestjs/common';
import { Task } from './task.entity';
import CreateTaskDto from './create-task.dto';
import { TaskService } from './task.service';

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
}
