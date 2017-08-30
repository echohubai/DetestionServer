package detectionserver.model;

/**
 * Created by hubai on 2017/7/31.
 */
public class Param {
    private String user;

    public String getUser() {
        return user;
    }

    private String location;
    private double lat;
    private double lon;
    private double tm;
    private double pm25;
    private double aqi;
    private double so;
    private double cho;
    private double rh;
    private String time;

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setRh(double rh) {
        this.rh = rh;
    }

    public double getRh() {
        return rh;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public void setLon(double lon) {
        this.lon = lon;
    }

    public void setTm(double tm) {
        this.tm = tm;
    }

    public void setPm25(double pm25) {
        this.pm25 = pm25;
    }

    public void setAqi(double aqi) {
        this.aqi = aqi;
    }

    public void setSo(double so) {
        this.so = so;
    }

    public void setCho(double cho) {
        this.cho = cho;
    }

    public String getLocation() {
        return location;
    }

    public double getLat() {
        return lat;
    }

    public double getLon() {
        return lon;
    }

    public double getTm() {
        return tm;
    }

    public double getPm25() {
        return pm25;
    }

    public double getAqi() {
        return aqi;
    }

    public double getSo() {
        return so;
    }

    public double getCho() {
        return cho;
    }

}
