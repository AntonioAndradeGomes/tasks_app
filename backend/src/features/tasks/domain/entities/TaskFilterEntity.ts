import { Filter } from './Filter';
import { TaskEntity } from './TaskEntity';

export interface TaskFilterEntity {
    filter: Filter;
    tasks: TaskEntity[];
}
