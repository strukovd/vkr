import { Module } from '@nestjs/common';
import { AppUserModule } from './app-user/app-user.module';
import { SessionModule } from './session/session.module';

@Module({
  imports: [AppUserModule, SessionModule],
})
export class AppModule {}
