//
//  WorkoutCell.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/06/17.
//

import SwiftUI


struct WorkoutCell: View {
    let workout : Workout
    
    init(_ workout: Workout) {
        self.workout = workout
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.menu.name)
                .font(.title)
            Text(workout.date.ISO8601Format())
                .font(.caption)
        }
    }
}


#if DEBUG
struct WorkoutCell_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCell(Workout(menu: Menu(name: "Test")))
    }
}
#endif
