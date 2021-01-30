Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68A2C433E0
	for <rcu@archiver.kernel.org>; Sat, 30 Jan 2021 11:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F6C64DD8
	for <rcu@archiver.kernel.org>; Sat, 30 Jan 2021 11:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhA3LWh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 30 Jan 2021 06:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhA3LWh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 30 Jan 2021 06:22:37 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4F3C061573;
        Sat, 30 Jan 2021 03:21:56 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f19so13529638ljn.5;
        Sat, 30 Jan 2021 03:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jg0IO2721rJAPRyDMSXIv6xNyC+AJXZG5LyquGPskMs=;
        b=gLrXY82j7HE9RbjUVEdPaUxV4sY6rEhZ5WRZeDyiYGVyzx2DLtVexh6dMu5nJc0H5b
         GVHi441+A3byd7yAA38T6NhT78HyUWEcCaTrOG93DHvx1uqikzISJ7vlwT41MNRnJ6jG
         n7MKn8VWB0EgTnugTS/PagR31MV4Gq+cStucQwrnxW44vLiM3mvmXNdvheQSbOHgTLYU
         bdOf5pQr7eQVJg8AnerLNzD5uwTxbwQt/6dnrf2sZliORiUfkAu3uZbyWuSoiCvHGBTz
         qWU6Mflt2o970TYdvCWqNLTRkJr2IMm7S9rcAq3YGB15Xg2qn+yidIiBftMhim+CosTF
         owpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jg0IO2721rJAPRyDMSXIv6xNyC+AJXZG5LyquGPskMs=;
        b=RfU5Ew70ZP7iMsH3wb4B4xK6xoQ8CIIpzakj67z9ObyMTuWxdU5FCMuvqVcDO4+qyg
         dhxZV70M1FbpjXo7RhvVLfzGawivUx6COlCJt+C9IVLBcGFGeYGUpUpcq4YZAhvVP0D7
         HeojMA29Rcj36FshHofbCSGbZByqXNKTyg4VMAJUKMwSvsGNZs/b+FuM+uXTNwDWdqJ0
         ndrGkLHrysC5SOsCBvm1RJussR1p+ElAfOWmbGujPN97K60V1jOBgczMzXHHErcaiELz
         Q+15cNpd5+UwNDev+mo1nC0cbe0MsehTXdKhQNiEwy5ldylIsP4+ykxE7bfxXbVL1Qwf
         aKZg==
X-Gm-Message-State: AOAM533Cp3wJE9hLvkTws3fQ+dgTJUeLNC3fa+2k7gK6VnwkLGvzprss
        Pfav6gTpXJ7/gr9q6+/m+e4=
X-Google-Smtp-Source: ABdhPJxvfD2G/QjPf3AbJh1DHeaFNULkTrE7VlnvvQfxWXHid+/Y4RaazE7KdJmZiIGlhRwfcAF8wQ==
X-Received: by 2002:a2e:7803:: with SMTP id t3mr2958909ljc.202.1612005714982;
        Sat, 30 Jan 2021 03:21:54 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 13sm2327929lft.5.2021.01.30.03.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 03:21:54 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 30 Jan 2021 12:21:52 +0100
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v2] kvfree_rcu:
 Release page cache under memory pressure
Message-ID: <20210130112152.GA1977@pc636>
References: <20210129080442.16055-1-qiang.zhang@windriver.com>
 <20210129141953.GA29827@pc638.lan>
 <BYAPR11MB2632B16DBD0A3EBEA5EA2FAFFFB89@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2632B16DBD0A3EBEA5EA2FAFFFB89@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 30, 2021 at 06:47:31AM +0000, Zhang, Qiang wrote:
> 
> 
> ________________________________________
> 发件人: Uladzislau Rezki <urezki@gmail.com>
> 发送时间: 2021年1月29日 22:19
> 收件人: Zhang, Qiang
> 抄送: urezki@gmail.com; paulmck@kernel.org; joel@joelfernandes.org; rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> 主题: Re: [PATCH v2] kvfree_rcu: Release page cache under memory pressure
> 
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Fri, Jan 29, 2021 at 04:04:42PM +0800, qiang.zhang@windriver.com wrote:
> > From: Zqiang <qiang.zhang@windriver.com>
> >
> > Add free per-cpu existing krcp's page cache operation, when
> > the system is under memory pressure.
> >
> > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > ---
> >  kernel/rcu/tree.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c1ae1e52f638..ec098910d80b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3571,17 +3571,40 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  }
> >  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> >
> > +static int free_krc_page_cache(struct kfree_rcu_cpu *krcp)
> > +{
> > +     unsigned long flags;
> > +     struct kvfree_rcu_bulk_data *bnode;
> > +     int i;
> > +
> > +     for (i = 0; i < rcu_min_cached_objs; i++) {
> > +             raw_spin_lock_irqsave(&krcp->lock, flags);
> >I am not sure why we should disable IRQs. I think it can be >avoided.
> 
> Suppose in multi CPU system, the kfree_rcu_shrink_scan function is runing on CPU2,
> and we just traverse to CPU2, and then call free_krc_page_cache function,
> if not disable irq, a interrupt may be occurs on CPU2 after the CPU2 corresponds to krcp variable 's lock be acquired,  if the interrupt or softirq handler function to call kvfree_rcu function, in this function , acquire CPU2 corresponds to krcp variable 's lock , will happen deadlock.
> Or in single CPU scenario.
> 
Right. Deadlock scenario. It went away from my head during writing that :)

Thanks!

--
Vlad Rezki
