use strict;
use warnings;
use LWP::UserAgent;
use HTML::TreeBuilder;

# urlを指定する
my $url = 'http://the-japan-news.com/news/editorial';

# IE8のフリをする
my $user_agent = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)";

# LWPを使ってサイトにアクセスし、HTMLの内容を取得する
my $ua = LWP::UserAgent->new('agent' => $user_agent);
my $res = $ua->get($url);
my $content = $res->content;

# HTML::TreeBuilderで解析する
my $tree = HTML::TreeBuilder->new;
$tree->parse($content);

# DOM操作してトピックの部分だけ抜き出す。
# <div class='listItemArticleHeaderWrapper'>...</div>内の部分を抽出する
my @items =  $tree->look_down('class', 'listItemArticleHeaderWrapper');
print $_->as_text."\n" for @items;

