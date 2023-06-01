import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ProjectService } from './project.service';
import { CreateProjectDto } from './dto/create-project.dto';
import { UpdateProjectDto } from './dto/update-project.dto';

@Controller('project')
export class ProjectController {
	constructor(private readonly projectService: ProjectService) {}

	@Post()
	create(@Body() createProjectDto: CreateProjectDto) {
		return this.projectService.create(createProjectDto);
	}

	@Get()
	findAll() {
		return this.projectService.findAll();
	}

	@Get(':projectKey')
	findOne(@Param('projectKey') projectKey: string) {
		return this.projectService.findOne(projectKey);
	}

	// @Patch(':projectKey')
	// update(@Param('projectKey') projectKey: string, @Body() updateProjectDto: UpdateProjectDto) {
	// 	return this.projectService.update(projectKey, updateProjectDto);
	// }

	@Delete(':projectKey')
	remove(@Param('projectKey') projectKey: string) {
		return this.projectService.remove(projectKey);
	}
}
