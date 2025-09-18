import { DataSource } from 'typeorm';
import { User } from '../users/user.entity';
import { Task } from '../tasks/task.entity';
import { Status } from '../statuses/status.entity';
import * as bcrypt from 'bcrypt';
import { addDays, subDays } from 'date-fns';

const NAMES = [
  'Alice Johnson',
  'Bob Smith',
  'Charlie Brown',
  'Diana Prince',
  'Ethan Hunt',
  'Fiona Gallagher',
  'George Clooney',
];

const TASK_TITLES = [
  'Setup project repository',
  'Implement login system',
  'Create dashboard UI',
  'Write API endpoints',
  'Design database schema',
  'Fix bug #123',
  'Test user flows',
  'Deploy to staging',
  'Update documentation',
  'Code review tasks',
  'Optimize queries',
  'Integrate third-party API',
  'Set up CI/CD',
  'Create unit tests',
  'Write e2e tests',
  'Design landing page',
  'Implement notifications',
  'Refactor authentication',
  'Improve performance',
  'Conduct usability testing',
  'Update dependencies',
  'Migrate database',
  'Configure logging',
  'Implement caching',
  'Resolve merge conflicts',
  'Create feature flags',
  'Document API',
  'Fix UI bugs',
  'Review pull requests',
  'Prepare release notes',
];

export async function seedUsers(dataSource: DataSource) {
  const userRepo = dataSource.getRepository(User);

  const users: User[] = [
    userRepo.create({
      username: 'admin_john',
      fullName: 'John Doe',
      role: 'admin',
      available: true,
      passwordHash: await bcrypt.hash('admin123', 10),
    }),
    userRepo.create({
      username: 'admin_jane',
      fullName: 'Jane Smith',
      role: 'admin',
      available: true,
      passwordHash: await bcrypt.hash('admin123', 10),
    }),
  ];

  for (let i = 0; i < 5; i++) {
    users.push(
      userRepo.create({
        username: NAMES[i].toLowerCase().replace(' ', '_'),
        fullName: NAMES[i],
        role: 'user',
        available: true,
        passwordHash: await bcrypt.hash(`user123`, 10),
      }),
    );
  }

  await userRepo.save(users);
  return users;
}

export async function seedStatuses(dataSource: DataSource) {
  const statusRepo = dataSource.getRepository(Status);

  const statuses = [
    statusRepo.create({ name: 'To Do', position: 1 }),
    statusRepo.create({ name: 'Doing', position: 2 }),
    statusRepo.create({ name: 'Testing', position: 3 }),
    statusRepo.create({ name: 'Done 🎉', position: 4 }),
  ];

  await statusRepo.save(statuses);
  return statuses;
}

export async function seedTasks(dataSource: DataSource, users: User[], statuses: Status[]) {
  const taskRepo = dataSource.getRepository(Task);
  const tasks: Task[] = [];
  const shuffledTitles = [...TASK_TITLES].sort(() => Math.random() - 0.5);

  for (let i = 0; i < shuffledTitles.length; i++) {
    const randomUser = Math.random() < 0.2 ? null : users[Math.floor(Math.random() * users.length)];
    const randomStatus = statuses[Math.floor(Math.random() * statuses.length)];
    const dueOffset = Math.floor(Math.random() * 10) - 5;
    const dueDate = addDays(new Date(), dueOffset);
    const completed = randomStatus.name === 'Done' ? 1 : 0;

    tasks.push(
      taskRepo.create({
        title: shuffledTitles[i],
        description: `This is a description for task "${shuffledTitles[i]}"`,
        assignedUser: randomUser ?? null,
        status: randomStatus,
        completed,
        position: i + 1,
        dueDate,
        createdAt: subDays(new Date(), Math.floor(Math.random() * 10)),
        updatedAt: subDays(new Date(), Math.floor(Math.random() * 5)),
      }),
    );
  }

  await taskRepo.save(tasks);
  return tasks;
}

const dataSource = new DataSource({
  type: 'mysql',
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT ? Number(process.env.DB_PORT) : 3306,
  username: process.env.DB_USER || 'root',
  password: process.env.DB_PASS || '',
  database: process.env.DB_NAME || 'task_scheduler',
  entities: [User, Task, Status],
  synchronize: false,
});

dataSource.initialize()
  .then(async () => {
    const users = await seedUsers(dataSource);
    const statuses = await seedStatuses(dataSource);
    await seedTasks(dataSource, users, statuses);
    await dataSource.destroy();
  })
  .catch((err) => console.error('Error seeding data:', err));
