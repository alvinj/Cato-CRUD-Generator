public class <<$classname|capitalize>>
{
<<section name=id loop=$camelcase_fields>>
  private <<$types[id]>> <<$camelcase_fields[id]>>;
<</section>>

<<* --- getters --- *>>
<<section name=id loop=$camelcase_fields>>
  public <<$types[id]>> get<<$camelcase_fields[id]|capitalize>>()
  {
    return <<$camelcase_fields[id]>>;
  }
<</section>>
<<* --- setters --- *>>
<<section name=id loop=$camelcase_fields>>
  public void set<<$camelcase_fields[id]|capitalize>>(<<$types[id]>> <<$camelcase_fields[id]>>)
  {
    this.<<$camelcase_fields[id]>> = <<$camelcase_fields[id]>>;
  }
<</section>>
}
