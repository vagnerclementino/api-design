package me.clementino.holiday.domain;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import lombok.Getter;
import lombok.Setter;
import me.clementino.holiday.model.HolidayType;
import me.clementino.holiday.model.When;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.annotation.Version;
import org.springframework.data.mongodb.core.index.Indexed;


@Getter
@Setter
public abstract class Holiday {

    @Id
    private UUID id;

    @Indexed(unique = true)
    @NotNull
    @Size(max = 255)
    private String name;

    @NotNull
    @Valid
    private When when;

    @NotNull
    @Valid
    private When observed;

    @NotNull
    private Boolean isPublic;

    @NotNull
    private HolidayType type;

    @NotNull
    @Size(max = 2)
    private String country;

    private List<@Size(max = 255) String> region;

    @CreatedDate
    private OffsetDateTime dateCreated;

    @LastModifiedDate
    private OffsetDateTime lastUpdated;

    @Version
    private Integer version;

}
