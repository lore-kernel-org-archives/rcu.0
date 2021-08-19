Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FBDC4338F
	for <rcu@archiver.kernel.org>; Thu, 19 Aug 2021 01:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF65A60EBD
	for <rcu@archiver.kernel.org>; Thu, 19 Aug 2021 01:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhHSB56 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Aug 2021 21:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbhHSB56 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Aug 2021 21:57:58 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AF0C061764;
        Wed, 18 Aug 2021 18:57:22 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id j18so5574456ioj.8;
        Wed, 18 Aug 2021 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0NJ+tliVUy5AxPDrrbDAZeL7P5Xe7UPZ+oPMc7Kpyy4=;
        b=juCQN66p/qqGpCSxsDN+mvTpkzCFHBVxWAeJZTcpSMPiOSO8VLnk8T9JicbrjuagS8
         3HI38c8+5VtsLyfbiqZwjtZEQDekKLKP463euX9itKEGY649+tk7RL/FKCxSG6haqfHM
         FG+3vO6S4NPtzfEVeZNygzz3lkYh4X/o2RpJDm40jDoam3uZhfVNwSnHAZsuK7HhwH1i
         yVbfxsUT5Qkowv3xiOAq4pRuIxaJEgY/P1BBpmh74Cs4mD1OzFl8tHNmqhzJlWRdfm62
         YiAoa5G9Iagwy0HIAxdgmIuEKAFX4LSFqHfWiBKN2MIjpK8LT9inAdlJxyUnFqPw57FT
         Ethw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0NJ+tliVUy5AxPDrrbDAZeL7P5Xe7UPZ+oPMc7Kpyy4=;
        b=ODmER15TB4W5nzM3GBHS8JWc3C4XrxNRLbdYvUh+TaG8XEsv9tRCB1qBSUGHb2ZVjt
         jqdinYy+sRow0kfrvT4pRiwCzbOZ0cpIdHs+AvLqdS0rPm71APhI1+2kjQkAhWEFvzjF
         JqgRaeG411IA4/1A4Qq7CtEWtmlUhvVZUuM12AEu/3P+QYIrJVl5zpiOv/hckd4LM+Iu
         WIHQn9o7dXL1OhJi9UdNZucqQW0MFeomtYp4pQ/YPa8yEJB17H8k5TPjqMx5BPXfyZr8
         meSvIqggfxrbwv27mPa4zqn7hv9jY4i8BCaWdz1xWHoama35hYnZCvNNYuIt+1kPIJSY
         m8uQ==
X-Gm-Message-State: AOAM530ZGwTbHHdwFzPi0wdNzxkLz443KYEpp1gYlIpF1YnqhpFV80R1
        IeiZTa+1N8o8/mSiozRRZQg=
X-Google-Smtp-Source: ABdhPJyS3mXJthdQrBRkhKWEwOQDgAzEQXQLDCyBQ1Hl7mPRqeBGJWXk/0XswLwqwtS1S2rXTYFlmg==
X-Received: by 2002:a05:6638:265:: with SMTP id x5mr10548593jaq.23.1629338242335;
        Wed, 18 Aug 2021 18:57:22 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a17sm884770ios.36.2021.08.18.18.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 18:57:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id BE85D27C0054;
        Wed, 18 Aug 2021 21:57:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 18 Aug 2021 21:57:20 -0400
X-ME-Sender: <xms:fbodYZDZvcYdoOCaEjbD0BxVKfzukgE6wVxLt2SMROPm824IdoG4Uw>
    <xme:fbodYXgeA-llteMbz1T_CoUa1FNw1NejDhzXVN1H_kVruosWOiotNAoyTUoxANvuo
    i4YCaAYvAzhCN78tg>
X-ME-Received: <xmr:fbodYUkhtCF5iuOgR-0kDz_ZLdEE_NKW9GfuZTv3ExjowyFRuPKHNqzyr6jv0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:fbodYTwuyXF6F5mFtrymy4dhaFGAekWdOsxpVmx96UyRFVldcL4Byg>
    <xmx:fbodYeRbxhUzGuIv0kS33cwlYQKuT2tfw5nH0GSHYvVezOuJGY1L3A>
    <xmx:fbodYWaUGmuMeHhL-5rHR9eRjXszIL8iYt-K04jUEXUL8WcV0w6TJQ>
    <xmx:gLodYVKK6bzpG1s3rtipVVaXD1YzjxDDH2BaHz-YyGxyo7xvMsb6fdGLlPk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 21:57:17 -0400 (EDT)
Date:   Thu, 19 Aug 2021 09:56:45 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] preempt: add in_serving_irq() and apply to rcutiny and
 vsprintf
Message-ID: <YR26XQF3OXLqo4Pj@boqun-archlinux>
References: <20210814014234.51395-1-changbin.du@gmail.com>
 <YRqMRFPDL0U9Orec@boqun-archlinux>
 <20210818235916.l3zbdt5nli5j65xi@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818235916.l3zbdt5nli5j65xi@mail.google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

[Cc Thomas and Frederic since they contributed the clean-up to these
macros recently]

Background for discussion:

	https://lore.kernel.org/lkml/20210814014234.51395-1-changbin.du@gmail.com/

On Thu, Aug 19, 2021 at 07:59:16AM +0800, Changbin Du wrote:
> On Tue, Aug 17, 2021 at 12:03:16AM +0800, Boqun Feng wrote:
> > On Sat, Aug 14, 2021 at 09:42:34AM +0800, Changbin Du wrote:
> > > At some places we need to determine whether we're in nmi, hardirq or
> > > softirq context. This adds a macro in_serving_irq() as a shortcut for
> > > that.
> > > 
> > > Meanwhile, apply this new macro to existing code in rcutiny and vsprintf.
> > > 
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > ---
> > >  include/linux/preempt.h | 4 +++-
> > >  include/linux/rcutiny.h | 3 +--
> > >  lib/vsprintf.c          | 2 +-
> > >  3 files changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> > > index 9881eac0698f..9a1c924e2c6c 100644
> > > --- a/include/linux/preempt.h
> > > +++ b/include/linux/preempt.h
> > > @@ -92,12 +92,14 @@
> > >   * in_nmi()		- We're in NMI context
> > >   * in_hardirq()		- We're in hard IRQ context
> > >   * in_serving_softirq()	- We're in softirq context
> > > + * in_serving_irq()	- We're in nmi, hardirq or softirq context
> > >   * in_task()		- We're in task context
> > >   */
> > >  #define in_nmi()		(nmi_count())
> > >  #define in_hardirq()		(hardirq_count())
> > >  #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
> > > -#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
> > > +#define in_serving_irq()	(in_nmi() | in_hardirq() | in_serving_softirq())
> > > +#define in_task()		(!in_serving_irq())
> > >  
> > 
> > So in_serving_irq() is !in_task(), right? If so, why not...
> > 
> Adding in_serving_irq() is to reflect the real purpose so improve readability.
> And can we preserve that !in_task() means in serving irq context in future? I don't know.
> 

Sure, no one could predict the future. But if a third context (other
than thread context and {hard,soft}irq context) comes up, which I think
is highly unlikely, we could (and should) audit all callsites of
in_task() for necessary adjustment. And introducing in_serving_irq()
won't help us in that case, because we will still need to audit usage of
in_serving_irq(), for example, let's say rcu_is_idle_cpu() for RCU_TINY
is defined as

	#define rcu_is_idle_cpu(cpu) (is_idle_task(current) && !in_serving_irq())

and we have a new type of context, and we can use in_other() to test
whether we are in it. Now even with in_serving_irq() introduced, we
still need to make sure the correct version of rcu_is_idle_cpu() is
either

	(is_idle_task(current) && (!in_serving_irq() && !in_other()))

or
	
	(is_idle_task(current) && !in_serving_irq())

Therefore, I don't see the point of introducing in_serving_irq().

Regards,
Boqun

> -- 
> Cheers,
> Changbin Du
