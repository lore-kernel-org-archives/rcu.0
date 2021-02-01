Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4932CC433E6
	for <rcu@archiver.kernel.org>; Mon,  1 Feb 2021 14:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215DD64E98
	for <rcu@archiver.kernel.org>; Mon,  1 Feb 2021 14:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhBAOqA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhBAOpV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Feb 2021 09:45:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E21C06174A;
        Mon,  1 Feb 2021 06:44:38 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i187so23081425lfd.4;
        Mon, 01 Feb 2021 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HGO7z+i3LytjksTxGFn7QOp9pjyNtbl94ushCl8Zdn0=;
        b=iiFc0Tp2xx3TnqrxdYc5xMxjoMVbY6olls5pYkfiCIsNlg0fZf1+uJn+rAFM86EFh0
         M8k6ovAWFkcGb5vOw0jqaDRlZNdaFQXeKAg3/LF1dq8y/n7R5UP0w1M5FgEUt/MIAdO3
         hdNvKxhSaGc478nKT6PEMdfHMkAvExW+QXPBRCymv7STtaDpKLTUsFc3P2RF1jhSdEHk
         tQTy5+IPg/LT331T0oKleQ5dByrUysF8uhxdn6CBwmaMqtXV4livX2pb+aK609f0L4c9
         m6G+bwxPiff1RcayytZ6iqMyiqmL84l12FEHXIWSygXHSqtXthhZSQ1FkzFlh+nn4Aze
         6iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HGO7z+i3LytjksTxGFn7QOp9pjyNtbl94ushCl8Zdn0=;
        b=h4iZDGw4TF5YFTvxGQnxnCZfD6oO5XV9py9Sp+FhiBMK7iBdBslyKdZuM6+0TXgdF+
         QvzW7JsHMr7U3GHWOW9LSJ6np43SJEpO5/mDCp4UBiun1QrtJzRu/0m8MMzJnWk+bNoh
         GuHuQMywsRzgAJzXMZUtZuP2CVCBLpJQ0YY8GgQfF+MM6iq7O32Kg4mT7tVDKNypZ8/U
         t0H/yoFs+rOAMLd6VPD1hXqrOKNevk5Yo2KyqVqO8HSZT0nXvO1QtRFUABzB/P+f5PH/
         DaCIgrD+8HGZKKeCW1e06bQtyvkd+xrW0rFWO0qR6NAwHP43kUrTH+7tc7uwZD+wAJyv
         C9Aw==
X-Gm-Message-State: AOAM530rlv1uJPDW7tKjagmX4mjmPQzS2g64IYmAnj3xH/RrNUkkgNZC
        ABSdl7do3vZqasbDJhJngqQ=
X-Google-Smtp-Source: ABdhPJxBZa2VDTXbLeU0pMnlUJ5+kENfRXdYp3t2hZaAXUfRwU0rqchzNu9qkjBVu8nbSWrUyIVf6A==
X-Received: by 2002:a19:7507:: with SMTP id y7mr8360046lfe.334.1612190676615;
        Mon, 01 Feb 2021 06:44:36 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u13sm3916170lju.22.2021.02.01.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:44:36 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 1 Feb 2021 15:44:34 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210201144434.GA1850@pc638.lan>
References: <20210125143150.GA2282@pc638.lan>
 <20210125153943.GN827@dhcp22.suse.cz>
 <20210125162559.GA52712@pc638.lan>
 <20210128151152.GA1867@pc638.lan>
 <YBLVbZzy0KSONizm@dhcp22.suse.cz>
 <20210128153017.GA2006@pc638.lan>
 <20210128180237.GA5144@pc638.lan>
 <YBPNvbJLg56XU8co@dhcp22.suse.cz>
 <20210129163531.GA30500@pc638.lan>
 <YBfqa/LzVAG4+zZt@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBfqa/LzVAG4+zZt@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 01, 2021 at 12:47:55PM +0100, Michal Hocko wrote:
> On Fri 29-01-21 17:35:31, Uladzislau Rezki wrote:
> > On Fri, Jan 29, 2021 at 09:56:29AM +0100, Michal Hocko wrote:
> > > On Thu 28-01-21 19:02:37, Uladzislau Rezki wrote:
> > > [...]
> > > > >From 0bdb8ca1ae62088790e0a452c4acec3821e06989 Mon Sep 17 00:00:00 2001
> > > > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > > > Date: Wed, 20 Jan 2021 17:21:46 +0100
> > > > Subject: [PATCH v2 1/1] kvfree_rcu: Directly allocate page for single-argument
> > > >  case
> > > > 
> > > > Single-argument kvfree_rcu() must be invoked from sleepable contexts,
> > > > so we can directly allocate pages.  Furthermmore, the fallback in case
> > > > of page-allocation failure is the high-latency synchronize_rcu(), so it
> > > > makes sense to do these page allocations from the fastpath, and even to
> > > > permit limited sleeping within the allocator.
> > > > 
> > > > This commit therefore allocates if needed on the fastpath using
> > > > GFP_KERNEL|__GFP_NORETRY.
> > > 
> > > Yes, __GFP_NORETRY as a lightweight allocation mode should be fine. It
> > > is more robust than __GFP_NOWAIT on memory usage spikes.  The caller is
> > > prepared to handle the failure which is likely much less disruptive than
> > > OOM or potentially heavy reclaim __GFP_RETRY_MAYFAIL.
> > > 
> > > I cannot give you ack as I am not familiar with the code but this makes
> > > sense to me.
> > > 
> > No problem, i can separate it. We can have a patch on top of what we have so
> > far. The patch only modifies the gfp_mask passed to __get_free_pages():
> > 
> > >From ec2feaa9b7f55f73b3b17e9ac372151c1aab5ae0 Mon Sep 17 00:00:00 2001
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > Date: Fri, 29 Jan 2021 17:16:03 +0100
> > Subject: [PATCH 1/1] kvfree_rcu: replace __GFP_RETRY_MAYFAIL by __GFP_NORETRY
> > 
> > __GFP_RETRY_MAYFAIL is a bit heavy from reclaim process of view,
> > therefore a time consuming. That is not optional and there is
> > no need in doing it so hard, because we have a fallback path.
> > 
> > __GFP_NORETRY in its turn can perform some light-weight reclaim
> > and it rather fails under high memory pressure or low memory
> > condition.
> > 
> > In general there are four simple criterias we we would like to
> > achieve:
> >     a) minimize a fallback hitting;
> >     b) avoid of OOM invoking;
> >     c) do a light-wait page request;
> >     d) avoid of dipping into the emergency reserves.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Looks good to me. Feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
Appreciate it!

--
Vlad Rezki
