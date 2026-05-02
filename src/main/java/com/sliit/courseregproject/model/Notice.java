public class Notice {

    private String id;
    private String title;
    private String content;
    private String postedDate;  // yyyy-MM-dd
    private String postedBy;    // admin name

    public Notice() {}

    public Notice(String id, String title, String content, String postedDate, String postedBy) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.postedDate = postedDate;
        this.postedBy = postedBy;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getPostedDate() { return postedDate; }
    public void setPostedDate(String postedDate) { this.postedDate = postedDate; }

    public String getPostedBy() { return postedBy; }
    public void setPostedBy(String postedBy) { this.postedBy = postedBy; }

    // Use | as separator since content may contain commas
    public String toFileString() {
        return id + "|" + title + "|" + content + "|" + postedDate + "|" + postedBy;
    }

    public static Notice fromFileString(String line) {
        String[] parts = line.split("\\|", -1);
        if (parts.length < 5) return null;
        return new Notice(parts[0], parts[1], parts[2], parts[3], parts[4]);
    }
}
