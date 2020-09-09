import { IsNotEmpty, IsDate } from 'class-validator';
import { Type } from 'class-transformer';

export default class CreateTaskDto {
  @IsNotEmpty()
  title!: string;

  @IsNotEmpty()
  description!: string;

  @IsNotEmpty()
  status!: string;

  @IsNotEmpty()
  @IsDate()
  @Type(() => Date)
  dueDate!: Date;
}
