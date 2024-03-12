//
//  TimerNotificationMO+CoreDataClass.swift
//  Storage
//
//  Created by George Popkich on 26.02.24.
//
//

@objc(TimerNotificationMO)
public class TimerNotificationMO: BaseNotificationMO {
    
    public override func toDTO() -> (any DTODescription)? {
        return TimerNotificationDTO.fromMO(self)
    }
    
    public override func apply(dto: any DTODescription) {
        guard let timerDTO = dto as? TimerNotificationDTO else {
            print("[MODTO]", "\(Self.self) apply failsed: dto is type of \(type(of: dto))")
            return
        }
        super.apply(dto: dto)
        self.targetDate = timerDTO.targetDate
    }
    
}
