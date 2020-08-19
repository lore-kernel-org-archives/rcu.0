Return-Path: <SRS0=uuXb=B5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297CFC433E1
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 00:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8832075E
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 00:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iRxnC/nO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHSAEc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHSAEc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 20:04:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08B9C061389
        for <rcu@vger.kernel.org>; Tue, 18 Aug 2020 17:04:31 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t13so19162644ile.9
        for <rcu@vger.kernel.org>; Tue, 18 Aug 2020 17:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSr61lwzUj+xHSrVPasO0EWAim4EWvQCGpCMT13xijE=;
        b=iRxnC/nOppybcAojsVo0p009Ul4zniX0CYq561gKj8/PGz6vtBky6WbKCJrbe18woB
         5Gvd5XtTTWz91U/YGzWZbeMIl2nAmOC04oYv1IbPzj9MHxd2KH0zLxsJpbs6p8q6BZre
         QQaR2gGM+yBASU5DXhq6FjMbneA1G2B1uEYTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSr61lwzUj+xHSrVPasO0EWAim4EWvQCGpCMT13xijE=;
        b=FpqbullickZoAe+nt5phoRAbKwvSQb8R4qI9HTYrQPmgTOqqKC/bmYoMnyXOOMZpjv
         qIqP6EjnIRp4MIMzeQFBmT0qPYAGtnp0VmARpR0cI0Dc99U487+Iatrwi4KgcDOv10cD
         VjBkYr4v9zZ8b/gk4MK+PDtyOek4I7In4nrUxeIYXN7kFmbk9W+P3TJ9eJEEa7Fl7vCz
         LTeFukufOVzvqjfI6fgNN4BpdOp1LRjEeZI42ZJwyL7Vigfe9OvF/9t6Ckmv9pLT7o5S
         MIe9JyvfQTcP0EKkDBLVF7HNEuwGv9vTsa8Gq4gyzmh1npBgtNhw8YG/ppAfr266GF8e
         rYNA==
X-Gm-Message-State: AOAM531tBXCFti/ACd/3sJqNO1G/9TIxqOCOx5GB8HCNsI5x2It6GUoz
        VY/dNF8f25qTc5FfMWJ5pHuTi0UcOtD5TxyUFmN0xQ==
X-Google-Smtp-Source: ABdhPJyjicQKK5V/J7U3GZuUT4FkgXC3VrgTQLkpPiyoQZ8ZkEKKjjrWqZbrDqtBGQ5xliwSol1cNNHVoDy1sY6cHN0=
X-Received: by 2002:a92:660e:: with SMTP id a14mr20285569ilc.262.1597795471360;
 Tue, 18 Aug 2020 17:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636> <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72> <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72> <20200818215511.GA2538@pc636> <20200818220245.GO27891@paulmck-ThinkPad-P72>
In-Reply-To: <20200818220245.GO27891@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 18 Aug 2020 20:04:20 -0400
Message-ID: <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
Subject: Re: [PATCH] rcu: shrink each possible cpu krcp
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, qiang.zhang@windriver.com,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 18, 2020 at 6:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:

> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b8ccd7b5af82..6decb9ad2421 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
> >  {
> >         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > +       struct kfree_rcu_cpu *krcp;
> >
> >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> >                 return 0;
> >
> > +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> > +       krcp = this_cpu_ptr(&krc)
> > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > +
> >
> > A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> > Maybe be never.
>
> Does the same apply to its kmalloc() per-CPU caches?  If so, I have a
> hard time getting too worried about it.  ;-)

Looking at slab_offline_cpu() , that calls cancel_delayed_work_sync()
on the cache reaper who's job is to flush the per-cpu caches. So I
believe during CPU offlining, the per-cpu slab caches are flushed.

thanks,

 - Joel
