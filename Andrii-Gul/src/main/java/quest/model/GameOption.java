package quest.model;

import lombok.Data;

@Data
public class GameOption {
    private String text;
    private int nextStepId;
    private int hpChange = 0;
}
