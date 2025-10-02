import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../entities/user.entity';
import { CreateUserDto } from '../dto/create-user.dto';
import { UpdateUserDto } from '../dto/update-user.dto';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  // GET /users - Listar todos los usuarios (con búsqueda opcional)
  async findAll(search?: string): Promise<User[]> {
    if (search) {
      // Para MySQL: usar LIKE con LOWER() para búsqueda case-insensitive
      const searchTerm = `%${search.toLowerCase()}%`;
      return await this.userRepository
        .createQueryBuilder('user')
        .where(
          'LOWER(user.first) LIKE :search OR LOWER(user.last) LIKE :search OR LOWER(user.email) LIKE :search OR LOWER(user.location) LIKE :search OR LOWER(user.hobby) LIKE :search',
          { search: searchTerm }
        )
        .getMany();
    }
    
    return await this.userRepository.find();
  }

  // GET /users/:id - Obtener un usuario por ID
  async findOne(id: number): Promise<User> {
    const user = await this.userRepository.findOne({ where: { id } });
    if (!user) {
      throw new NotFoundException(`Usuario con ID ${id} no encontrado`);
    }
    return user;
  }

  // POST /users - Crear un nuevo usuario
  async create(createUserDto: CreateUserDto): Promise<User> {
    const user = this.userRepository.create(createUserDto);
    return await this.userRepository.save(user);
  }

  // PUT /users/:id - Actualizar un usuario
  async update(id: number, updateUserDto: UpdateUserDto): Promise<User> {
    const user = await this.findOne(id);
    Object.assign(user, updateUserDto);
    return await this.userRepository.save(user);
  }

  // DELETE /users/:id - Eliminar un usuario
  async remove(id: number): Promise<void> {
    const user = await this.findOne(id);
    await this.userRepository.remove(user);
  }
}