import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ChartsService } from './charts.service';
import { CreateChartDto } from './dto/create-chart.dto';
import { UpdateChartDto } from './dto/update-chart.dto';

@Controller('charts')
export class ChartsController {
	constructor(private readonly chartsService: ChartsService) {}

	@Get('tasksCreated')
	tasksCreated() {
		return this.chartsService.tasksCreated();
	}
}
