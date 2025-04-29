package me.clementino.holiday.domain;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.time.OffsetDateTime;
import java.util.List;
import lombok.Getter;
import lombok.Setter;
import me.clementino.holiday.model.HolidayType;
import me.clementino.holiday.model.When;
import software.amazon.awssdk.enhanced.dynamodb.mapper.annotations.DynamoDbPartitionKey;

@Getter
@Setter
public class Holiday {

    private String id;

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

    private OffsetDateTime dateCreated;
    private OffsetDateTime lastUpdated;
    private Integer version;

    @DynamoDbPartitionKey
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
