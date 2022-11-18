Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EF1C4332F
	for <rcu@archiver.kernel.org>; Fri, 18 Nov 2022 01:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiKRBN1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Nov 2022 20:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiKRBMs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Nov 2022 20:12:48 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2FB85EE5
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 17:12:44 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n188so2794726iof.8
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 17:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1nEQgHnJ3mToQ4Y8AU47leGp2bx85OsCS3Yng1ByM5g=;
        b=jAiUM6n8fPzCk4etsLh5vHbzmAphcNVgk2NYTsSycCua2b0xBeQb7Cz/19byCflgsy
         X5AXgnMMBgg108CFB6nt6M2AzlTkf5g84Pq8nlXb8twtab7av3lSIlSowzqG2CH6CSNB
         MILL514zNmYNHE22FYO4GTdBsfD3SvqxuJplhzHnBU4qzpScYjksDrF9eX1+YIevib1F
         tiDUZaJygCJ3DGCcUm4hYlCBH81UZn/3Mv0fKWV1pBJqaifilkaG3tIAk2yZ7PPzjDw3
         SGfdFXFMKhkL0MlH25j/NumiiZ05+lZLrR3lzxoVZCKt/ueCK4lAnnpS8VDp9NpTRKWf
         8Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nEQgHnJ3mToQ4Y8AU47leGp2bx85OsCS3Yng1ByM5g=;
        b=r1X/77wfvrTHvTm2zZSHwAIW7GNyoYGbPsfrbvazH4lg2W1TfRovUFYw0NBZyVm7Kj
         5oiYZ0GjlOofkxv2GQ6uRVq/5oZmydBNu63IEEUcjfvXAUXa9liBMn5gdpDrjQTMaZRi
         94IUL+S2zfj/L7nk7VkMSxF7kVaGPT4e9DMc0JqMKDp3eY0stTVHG9rfa9bmAyCfG91R
         nvbFr2S2dtl1uGkf6F5FbbAuGZX5TJgB8l5X8TN+jPPGosM+hCC+xUBEDfVaTn/6vz1k
         4oHycRThon/+CxFT7ZgEUcum78cyAsmbUxj2WYudKTB7H6gI9GPpipx4lUdOTNWH1vIS
         ekoQ==
X-Gm-Message-State: ANoB5pkSaQM5itEFLdCwL4CaoZMi+P8r+uDl5Qg0BbzhwSb+wPvYbI+L
        IHp78v8LwP9Y1rHbJO52gZYHV60B/LoUiPoc1v682g==
X-Google-Smtp-Source: AA0mqf5t6BPijE6Cc+oI0fl/UCvTRQdEtwuBuJlZz84oIjqUP+6zOJnmDeGn5HJoc24bCjz4DjGCNms/n4Wk7x6yd8g=
X-Received: by 2002:a5d:8f84:0:b0:6d9:56fc:ef25 with SMTP id
 l4-20020a5d8f84000000b006d956fcef25mr2517540iol.56.1668733963791; Thu, 17 Nov
 2022 17:12:43 -0800 (PST)
MIME-Version: 1.0
References: <20221117031551.1142289-1-joel@joelfernandes.org>
 <20221117031551.1142289-2-joel@joelfernandes.org> <CANn89iK345JjXoCAPYK6hZF99zBBWRM1z7xCWbstQJLb4aBGQg@mail.gmail.com>
 <Y3bXXYOeZQPkhQmP@google.com>
In-Reply-To: <Y3bXXYOeZQPkhQmP@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 17 Nov 2022 17:12:32 -0800
Message-ID: <CANn89iKKr87hr4gAyHeK_uw9pK2QPg4oAE_JXUu=WHc8o9D-JQ@mail.gmail.com>
Subject: Re: [PATCH rcu/dev 2/3] net: Use call_rcu_flush() for in_dev_rcu_put
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 17, 2022 at 4:52 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi Eric,
>
> On Thu, Nov 17, 2022 at 01:58:18PM -0800, Eric Dumazet wrote:
> > On Wed, Nov 16, 2022 at 7:16 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > In a networking test on ChromeOS, we find that using the new CONFIG_RCU_LAZY
> > > causes a networking test to fail in the teardown phase.
> > >
> > > The failure happens during: ip netns del <name>
> > >
> > > Using ftrace, I found the callbacks it was queuing which this series fixes. Use
> > > call_rcu_flush() to revert to the old behavior. With that, the test passes.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  net/ipv4/devinet.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> > > index e8b9a9202fec..98b20f333e00 100644
> > > --- a/net/ipv4/devinet.c
> > > +++ b/net/ipv4/devinet.c
> > > @@ -328,7 +328,7 @@ static void inetdev_destroy(struct in_device *in_dev)
> > >         neigh_parms_release(&arp_tbl, in_dev->arp_parms);
> > >         arp_ifdown(dev);
> > >
> > > -       call_rcu(&in_dev->rcu_head, in_dev_rcu_put);
> > > +       call_rcu_flush(&in_dev->rcu_head, in_dev_rcu_put);
> > >  }
> >
> > For this one, I suspect the issue is about device refcount lingering ?
> >
> > I think we should release refcounts earlier (and only delegate the
> > freeing part after RCU grace period, which can be 'lazy' just fine)
> >
> > Something like:
>
> The below diff where you reduce refcount before RCU grace period, also makes the
> test pass.
>
> If you are Ok with it, I can roll it into a patch with your Author tag and my
> Tested-by. Let me know what you prefer?
>
> Also, looking through the patch, I don't see any issue. One thing is
> netdev_put() now happens before a grace period, instead of after. But I don't
> think that's an issue.

Normally the early netdev_put() is fine, because these netdev are
already fully RCU protected.

Sure, feel free to take this patch as is, thanks.
