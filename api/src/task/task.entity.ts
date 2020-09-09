import { Entity } from 'typeorm';
import { Column, ObjectIdColumn } from 'typeorm/index';

@Entity()
export class Task {
  @ObjectIdColumn()
  id?: string;

  @Column()
  title: string;

  @Column()
  description: string;

  @Column()
  status: string;

  @Column()
  createdAt: Date;

  @Column()
  dueDate: Date;

  constructor(
    title: string,
    description: string,
    status: string,
    dueDate: Date,
  ) {
    this.title = title;
    this.description = description;
    this.status = status;
    this.dueDate = dueDate;
    this.createdAt = new Date();
  }
}
