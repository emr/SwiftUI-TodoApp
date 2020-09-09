import { Task } from '../../src/task/task.entity';
import CreateTaskDto from '../../src/task/create-task.dto';

export type TaskFields = {
  id?: string;
  title?: string;
  description?: string;
  status?: string;
  dueDate?: Date;
};

export const createTask = (fields?: TaskFields): Task => {
  const task = new Task(
    fields?.title || 'Fake task',
    fields?.description || "Fake task's fake description",
    fields?.status || 'status',
    fields?.dueDate || new Date(),
  );
  task.id = fields?.id;
  return task;
};

export const createCreateTaskDto = (fields?: TaskFields): CreateTaskDto => {
  const task = new CreateTaskDto();
  task.title = fields?.title || 'Fake task';
  task.description = fields?.description || "Fake task's fake description";
  task.status = fields?.status || 'status';
  task.dueDate = fields?.dueDate || new Date();

  return task;
};
