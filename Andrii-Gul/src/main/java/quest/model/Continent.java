package quest.model;

public enum Continent {
    Africa,
    Asia,
    Europe,
    NorthAmerica,
    SouthAmerica,
    Oceania,
    Antarctica;

    public static Continent fromString(String name) {
        if (name == null) throw new IllegalArgumentException("Континент не вказано");
        return switch (name.trim().toLowerCase()) {
            case "африка" -> Africa;
            case "європа" -> Europe;
            case "азія" -> Asia;
            case "північна америка" -> NorthAmerica;
            case "південна америка" -> SouthAmerica;
            case "океанія" -> Oceania;
            case "антарктида" -> Antarctica;
            default -> throw new IllegalArgumentException("Невідомий континент: " + name);
        };
    }

    @Override
    public String toString() {
        return switch (this) {
            case Africa -> "Африка";
            case Asia -> "Азія";
            case Europe -> "Європа";
            case NorthAmerica -> "Північна Америка";
            case SouthAmerica -> "Південна Америка";
            case Oceania -> "Океанія";
            case Antarctica -> "Антарктида";
            default -> super.toString();
        };
    }
}
