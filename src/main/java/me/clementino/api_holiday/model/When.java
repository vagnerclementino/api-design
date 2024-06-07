package me.clementino.api_holiday.model;

import jakarta.validation.constraints.Size;
import java.time.LocalDate;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@EqualsAndHashCode
public class When {

    private LocalDate date;

    @Size(max = 255)
    private String weekday;

}
