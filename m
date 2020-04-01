Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356CAC2D0E7
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 07:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5D02054F
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 07:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585725845;
	bh=Be6HIfANKsYGpEwNPI9eIlaM6MX3voJaqWDv+FO+yBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HJIl8XcfTHGWqGPL4TiV8X32ySrQsFNK3JNSd0QxQfQ7vRq3qv/GFAEhVAwxCewx3
	 HR23st8D68Niy+RYrH9hjuFAp589ziIgEykpYzy61DP7k8tgKjK1bgh/PknNrmrL2c
	 tsI1A+vqb/w5vWPWLzwnHa3SqN7dfe0tKFfunUzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgDAHYE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:24:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52179 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgDAHYE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 03:24:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id z7so2714045wmk.1;
        Wed, 01 Apr 2020 00:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bFk7ot1Ggv8JmeCshN6lhpNLDTZm2f9F+linXAAvHe0=;
        b=DzMdeOWySEqZWGLrodYmq1OgQzEHI5Mmg7vNBBrch7wE2M3E1vwkfrinnznPwJt3Tp
         fMKjExsVeRZQYNjRBZyXNyWemJokk/dtwDJMzEA/0fnGr+UK/L+FiuNzEQi9TOInnRGm
         gMJ6mnSA6IBE934HxbRrdaEken5/SbbyFGhkj5gtmH5F5D2wuU1GxF5ipRwepWVQDXEB
         ccvRrdf88XEU2e4fgENUvUBA7odUai1you+jrzsATwbtjqBw3BtN+ixUZ9Cy/R5oitQQ
         r9ms3bVaatg0VOZ6aqwq9NgURZD6XL3NDi/aCOTxj//fVXjqqHE+pDGHZqnxkA7Pqxx/
         7ZNQ==
X-Gm-Message-State: AGi0PubD6BlbMEv5kw2itMidCH3b8SMexddC8kQTKlTVnDGI8zxCg1aX
        /1D/1o8ZIjzZOUGOgFGUBRM=
X-Google-Smtp-Source: APiQypJiUkVxijSA/GBtTcBEr8Ja+Bau4T0Gyli2V1LXZWm3v32UQa2lP1SMONmUmTy+4wTVrsAxsg==
X-Received: by 2002:a1c:648b:: with SMTP id y133mr2720322wmb.173.1585725840905;
        Wed, 01 Apr 2020 00:24:00 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id k15sm1740199wrm.55.2020.04.01.00.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 00:24:00 -0700 (PDT)
Date:   Wed, 1 Apr 2020 09:23:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401072359.GC22681@dhcp22.suse.cz>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331160117.GA170994@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331160117.GA170994@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue 31-03-20 12:01:17, Joel Fernandes wrote:
> On Tue, Mar 31, 2020 at 05:34:50PM +0200, Michal Hocko wrote:
> > On Tue 31-03-20 10:58:06, Joel Fernandes wrote:
> > [...]
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 4be763355c9fb..965deefffdd58 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
> > > >  
> > > >  	if (!ptr)
> > > >  		ptr = kmalloc(sizeof(unsigned long *) +
> > > > -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> > > > +				sizeof(struct rcu_head), GFP_MEMALLOC);
> > > 
> > > Just to add, the main requirements here are:
> > > 1. Allocation should be bounded in time.
> > > 2. Allocation should try hard (possibly tapping into reserves)
> > > 3. Sleeping is Ok but should not affect the time bound.
> > 
> > 
> > __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
> > memory reserves regarless of the sleeping status.
> > 
> > Using __GFP_MEMALLOC is quite dangerous because it can deplete _all_ the
> > memory. What does prevent the above code path to do that?

Neil has provided a nice explanation down the email thread. But let me
clarify few things here.

> Can you suggest what prevents other users of GFP_MEMALLOC from doing that
> also? 

There is no explicit mechanism which is indeed unfortunate. The only
user real user of the flag is Swap over NFS AFAIK. I have never dared to
look into details on how the complete reserves depletion is prevented.
Mel would be much better fit here.

> That's the whole point of having a reserve, in normal usage no one will
> use it, but some times you need to use it. Keep in mind this is not a common
> case in this code here, this is triggered only if earlier allocation attempts
> failed. Only *then* we try with GFP_MEMALLOC with promises to free additional
> memory soon.

You are right that this is the usecase for the flag. But this should be
done with an extreme care because the core MM relies on those reserves
so any other users should better make sure they do not consume a lot
from reserves as well. 

> > If a partial access to reserves is sufficient then why the existing
> > modifiers (mentioned above are not sufficient?
> 
> The point with using GFP_MEMALLOC is it is useful for situations where you
> are about to free memory and needed some memory temporarily, to free that. It
> depletes it a bit temporarily to free even more. Is that not the point of
> PF_MEMALLOC?
> * %__GFP_MEMALLOC allows access to all memory. This should only be used when
>  * the caller guarantees the allocation will allow more memory to be freed
>  * very shortly e.g. process exiting or swapping. Users either should
>  * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
> 
> I was just recommending usage of this flag here because it fits the
> requirement of allocating some memory to free some memory. I am also Ok with
> GFP_ATOMIC with the GFP_NOWARN removed, if you are Ok with that.

Maybe we need to refine this documentation to be more explicit about an
extreme care to be taken when using the flag.

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e5b817cb86e7..e436a7e28392 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -110,6 +110,9 @@ struct vm_area_struct;
  * the caller guarantees the allocation will allow more memory to be freed
  * very shortly e.g. process exiting or swapping. Users either should
  * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
+ * Users of this flag have to be extremely careful to not deplete the reserve
+ * completely and implement a throttling mechanism which controls the consumption
+ * based on the amount of freed memory.
  *
  * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
  * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
-- 
Michal Hocko
SUSE Labs
