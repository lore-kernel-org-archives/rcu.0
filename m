Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28C6C63777
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 12:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654B622254
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 12:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MljDJCHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgKTMGx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 07:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgKTMGx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 07:06:53 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FCCC0617A7
        for <rcu@vger.kernel.org>; Fri, 20 Nov 2020 04:06:51 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 199so8558670qkg.9
        for <rcu@vger.kernel.org>; Fri, 20 Nov 2020 04:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONlxph66vinoq7WQfOgvS0BntK6G4N++ZL2XryVnJQ0=;
        b=MljDJCHkujFrU1c2g2ZELpi5rlMJCDGjG/DmHtXJkIoff9yjCv9f/ikpnKtgIbOWcD
         G4bIlhmWLD/f3G2+R8EYH4Bls3hTAxDGWJ59YSyW8ExYtaLvMVYZTBI+U1S2DI7pR6qk
         qiWHwcQIFJZ6umxP1DryKwMxVbbDZaHrBo1jMZOsQUA9z2lH27uusK1KxB7ymfd5QsKn
         e9buBHIaWBzIaBMDgNRElLwyGqORtZZiPkWip3SnVXExioFjo1Mq4C2nGblp0T3NFbDn
         GyNYCeK/OQBjZsHeYtVegfTmj4rSkPvbLlFSfIav+MOCR88DklVns02fycEcnsgO1SmX
         QQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONlxph66vinoq7WQfOgvS0BntK6G4N++ZL2XryVnJQ0=;
        b=XvTadc+aZEQLfyftHrlr7hLGf0g+pLXYD7i7MNqH+OVW9n8TQ7yWvRiHt07VvgzIFZ
         9V3vAjDRJ2TwrC78eC3KhmI5/JYnKEGUroATRmBPwo8wes4Mjof8jLZ/+WfK7zmBVrQ4
         Bt+RM8yhMXHUGhx5V4HBrKfXN5j2fe8TLwamrDc8UKWvmFaOVflV8aosNR1gugrvkc/s
         t4oS4XqFoMmIL6ecvsSl6K0WQ5f25jAeCsofqKsbRyjMDpR4Lrtj3O3w8jEw1nVVAjxA
         ffbYy6TwGECYf3Ex9Fcej8GobXNSaqHeczpOYVDjgpoJKXfQpT2cPYbZPL1JtgJKDgKH
         PEbQ==
X-Gm-Message-State: AOAM533UCqLrJ5io/RLQCWqzeIFvPu+cRzF+Ba5tZxZVnFySFQlJg0OK
        9r4I7IgF6R5c4MS4zvbHFWZJmdWaa9ceo23CD8IArQ==
X-Google-Smtp-Source: ABdhPJxlzoLbJUDOR5DZrfB3R91d4OSUz1r4Uyt4EmTjFvPWYFscosYrTT9xdvonmTIzg6R/ZwORId0Js5HU/Rbszeo=
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr16608080qkm.231.1605874010482;
 Fri, 20 Nov 2020 04:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20201118035309.19144-1-qiang.zhang@windriver.com>
 <20201119214934.GC1437@paulmck-ThinkPad-P72> <20201120115935.GA8042@pc636>
In-Reply-To: <20201120115935.GA8042@pc636>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Nov 2020 13:06:39 +0100
Message-ID: <CACT4Y+bHpju_vXjdtb46O=zbQKTFaCSuoTKu1ggZ=CZ9SqWhXQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: kasan: record and print kvfree_call_rcu call stack
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Zqiang <qiang.zhang@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 12:59 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 01:49:34PM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 18, 2020 at 11:53:09AM +0800, qiang.zhang@windriver.com wrote:
> > > From: Zqiang <qiang.zhang@windriver.com>
> > >
> > > Add kasan_record_aux_stack function for kvfree_call_rcu function to
> > > record call stacks.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> >
> > Thank you, but this does not apply on the "dev" branch of the -rcu tree.
> > See file:///home/git/kernel.org/rcutodo.html for more info.
> >
> > Adding others on CC who might have feedback on the general approach.
> >
> >                                                       Thanx, Paul
> >
> > > ---
> > >  kernel/rcu/tree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index da3414522285..a252b2f0208d 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >             success = true;
> > >             goto unlock_return;
> > >     }
> > > -
> > > +   kasan_record_aux_stack(ptr);
> Is that save to invoke it on vmalloced ptr.?

Yes, kasan_record_aux_stack should figure it out itself.
We call kasan_record_aux_stack on call_rcu as well, and rcu structs
can be anywhere.
See:
https://elixir.bootlin.com/linux/v5.10-rc4/source/mm/kasan/generic.c#L335
