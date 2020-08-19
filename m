Return-Path: <SRS0=uuXb=B5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE91C433DF
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 11:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76467206DA
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 11:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmI1zcvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHSLWt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgHSLWa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 Aug 2020 07:22:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0278BC061757;
        Wed, 19 Aug 2020 04:22:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so24889944ljn.11;
        Wed, 19 Aug 2020 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+U5eYd/WgcHMRRLlJtn8by7HPtPCy3egakxT1iRMnKo=;
        b=YmI1zcvnGz8pXArCkaWVKv5sYtG7wFwxL2nIk8rm++XzbHiHAJzWpe7JFYEajfCpv9
         Ufgvc8Hzs8Gf1FVQU8bPcL1CS42Fs3eqwDExTx54d5h0nTWqE33k1YgWEMKF/bP3IMdx
         TOEqcBEVVz0nXIgCZ3f3Rz/OTBLnLeuoOlWdeer1vEYak+g4RVxaFGas135IwjLbVLRn
         H1fzNwVZ4ne5Q24OxhL9IQ3UM/ZJPUBo/LWbdhb5dJaVQMI5+rr0GAdl99lp7AR1z2Z3
         vj1BT7KJZHBGx7FgcHOjxST0mG92NYEPyIeaf3NJnlnqBr3Czuv+QTF6q2Qjw17KcoTq
         gyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+U5eYd/WgcHMRRLlJtn8by7HPtPCy3egakxT1iRMnKo=;
        b=mBDrEoed1MWxn+jR/02izjgqqJy7+/2OX6gQ8+eQu5lAJzY3g+eTUxPM309OQstQhG
         +smCl8hH0otgnNTAUOA/VIl3YC1FLq/2UkoJRszhGLgVVt7OGVqxJLmNP0YbpsS46V1a
         ewLt6gKJ7RriQ1K8q8mZOudtnIOzdVC5WZnRbIPHlJvX6JkP+BmTHyfmbMtzDWnnuHOS
         Y7o2nF7N91afX3vsahlnHft1QAQ7laNWgWhhKqP6a3M1BhT48rdqNny72c1MvCtcDaez
         dE2FmVvlE63o/eNqP6N9efoDMboAOTwyAJ2pXF+ivfBVkDHby6EQwXN1joUdb7XlWz8T
         BolQ==
X-Gm-Message-State: AOAM530HHlyfp2CECjRfxg12yMDiA2fREuPcOxCY2KFeRKl1IEBSAPhA
        5qUFSkUtzVcZ9yMTKaPTMXNcT9gUdIXpK/eV
X-Google-Smtp-Source: ABdhPJyNXM8SzIAzQ5nqFDxfC2e9cxNQVLD3jtmL5bJ2SmPzKd7ZfLIQP/2F4A/eJM8wuCN9HCLDWg==
X-Received: by 2002:a2e:9643:: with SMTP id z3mr12891342ljh.282.1597836148425;
        Wed, 19 Aug 2020 04:22:28 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id p13sm7292826lfc.63.2020.08.19.04.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 04:22:27 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 19 Aug 2020 13:22:25 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>, qiang.zhang@windriver.com,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: shrink each possible cpu krcp
Message-ID: <20200819112225.GA6177@pc636>
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636>
 <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72>
 <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72>
 <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 18, 2020 at 08:04:20PM -0400, Joel Fernandes wrote:
> On Tue, Aug 18, 2020 at 6:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index b8ccd7b5af82..6decb9ad2421 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
> > >  {
> > >         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > >         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > > +       struct kfree_rcu_cpu *krcp;
> > >
> > >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > >                 return 0;
> > >
> > > +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> > > +       krcp = this_cpu_ptr(&krc)
> > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > +
> > >
> > > A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> > > Maybe be never.
> >
> > Does the same apply to its kmalloc() per-CPU caches?  If so, I have a
> > hard time getting too worried about it.  ;-)
> 
> Looking at slab_offline_cpu() , that calls cancel_delayed_work_sync()
> on the cache reaper who's job is to flush the per-cpu caches. So I
> believe during CPU offlining, the per-cpu slab caches are flushed.
> 
SLAB does it for sure, same as page allocator. There are special CPU-offline
callbacks for both cases to perform cleanup when CPU dies.

--
Vlad Rezki
