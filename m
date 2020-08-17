Return-Path: <SRS0=6ydw=B3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE939C433DF
	for <rcu@archiver.kernel.org>; Mon, 17 Aug 2020 10:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB4120758
	for <rcu@archiver.kernel.org>; Mon, 17 Aug 2020 10:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvqQz4Rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHQKgL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgHQKgG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Aug 2020 06:36:06 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BF8C061389;
        Mon, 17 Aug 2020 03:36:06 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v15so8084653lfg.6;
        Mon, 17 Aug 2020 03:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nzEOEMP8zmWx/Zstp1QUlIIiZZVtnurHnSvzhhPb3MY=;
        b=FvqQz4Rbw7s1IQt3Gp4JHY1UxdkLvhn8wkKutwI0+s/DKDlsbG/6NYGx4VNQxTSTBh
         ZQ8oivHkYhTjQY5odA9+Cd6AuvrcTZbxcgdvABT0yu4wZ2jY9wglK4ca38b1gQM837D7
         NR6HAUAh8gw8vPRThkb99xzdDPp79AA4B/8j5JK0HE5ycxHxqsEHUklqXptWe548SdOz
         KLg/hGSLSr+vYTofycNwBJyG1e7AA2RBtjRQ71eNubFGfuRO2LYj/XxIQaazmU30FfU+
         S2r/fKF4gb9MiqBZU8+aI4BhsSwH+v2QHf8LfanPflStW2xY98rFBZl6YmnCBINZBHFZ
         xcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nzEOEMP8zmWx/Zstp1QUlIIiZZVtnurHnSvzhhPb3MY=;
        b=gzbGASiwG35Y1O3nr2m3Hpb2dB8em+RRCIp1kqqQQng4C0nY221nfjspq8tsdZjRVY
         b3gTZUJiJ6QOfiUeujv1YEXDBN9whN8OyMd3tg4NjiT/sAzGB8ZX1UkG9JHwmdsyZlRp
         bszalab3EFAEz5gXohXTFRKNleCqpDkvg5CcSkOsjnH+QZk7MP4/Y71e46a+I+Xzzypq
         WKTCSsd/+7qwEruSbtjiCEuXvCB0+j57wecgSIzHpnFdJz5e/VU12BjQRuUqm7/R+LCO
         b5JalrA8q2kk+tMIT71uZ6ZjeZ2GXwNGJ1TAEeNxRp9T4JHnm/Kd0FDvJd+ISBR5YViL
         1HAw==
X-Gm-Message-State: AOAM531U4chtY5xbAURJn3G7xS4StlKWJqmEEYWWraprYkuX4//2kp1i
        BjyrM0F34xlMwNlKsC/dTv3kyExNk2Ie9S92
X-Google-Smtp-Source: ABdhPJyiRuXWljUwy5ryxFo5pj4eBtXayzEjI7XPWhPy7phXXETM8i9A7yP3T8y9+iQ8aH6pTU0Dbg==
X-Received: by 2002:a19:408d:: with SMTP id n135mr7027225lfa.192.1597660563981;
        Mon, 17 Aug 2020 03:36:03 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o16sm4963204ljc.66.2020.08.17.03.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 03:36:02 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 17 Aug 2020 12:36:00 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200817103600.GA21301@pc636>
References: <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161106.GA13853@paulmck-ThinkPad-P72>
 <20200814174924.GI3982@worktop.programming.kicks-ass.net>
 <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
 <20200814215206.GL3982@worktop.programming.kicks-ass.net>
 <20200816225655.GA17869@pc636>
 <20200817082849.GA28270@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817082849.GA28270@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 17, 2020 at 10:28:49AM +0200, Michal Hocko wrote:
> On Mon 17-08-20 00:56:55, Uladzislau Rezki wrote:
> [...]
> > Michal asked to provide some data regarding how many pages we need and how
> > "lockless allocation" behaves when it comes to success vs failed scenarios.
> > 
> > Please see below some results. The test case is a tight loop of 1 000 000 allocations
> > doing kmalloc() and kfree_rcu():
> 
> It would be nice to cover some more realistic workloads as well.
> 
Hmm.. I tried to show syntactic worst case when a "flood" occurs.
In such conditions we can get fails what is expectable and we have
fallback mechanism for it.

> > sudo ./test_vmalloc.sh run_test_mask=2048 single_cpu_test=1
> > 
> > <snip>
> >  for (i = 0; i < 1 000 000; i++) {
> >   p = kmalloc(sizeof(*p), GFP_KERNEL);
> >   if (!p)
> >    return -1;
> > 
> >   p->array[0] = 'a';
> >   kvfree_rcu(p, rcu);
> >  }
> > <snip>
> > 
> > wget ftp://vps418301.ovh.net/incoming/1000000_kmalloc_kfree_rcu_proc_percpu_pagelist_fractio_is_0.png
> 
> If I understand this correctly then this means that failures happen very
> often because pcp pages are not recycled quicklly enough.
> 
Yep, it happens and that is kind of worst scenario(flood one). Therefore we
have a fallback and is expectable. Also, i did not provide the number of pages
in a loop. On my test machine we need approximately ~300/400 pages to cover
that flood case until we recycles or return back the pages to the pcp.

Please note, as i mentioned before. Our drain part is not optimal for sure,
it means that we can rework it a bit making it more efficient. For example,
when a flood occurs, instead of delaying "reclaimer logic" thread, it can be
placed to a run-queue right away. We can use separate "flush workqueue"
that is tagged with WQ_MEM_RECLAIM raising a priority of drain context.

i.e. there is a room for reducing such page footprint.

> > wget ftp://vps418301.ovh.net/incoming/1000000_kmalloc_kfree_rcu_proc_percpu_pagelist_fractio_is_8.png
> 
> 1/8 of the memory in pcp lists is quite large and likely not something
> used very often.
> 
Just for illustration. When percpu_pagelist_fractio is set to 8, i do
not see any page fail on a single CPU flood case. If i run simultaneously
such flood on all available CPUs there will be fails for sure. 

> Both these numbers just make me think that a dedicated pool of page
> pre-allocated for RCU specifically might be a better solution. I still
> haven't read through that branch of the email thread though so there
> might be some pretty convincing argments to not do that.
> 
> > Also i would like to underline, that kfree_rcu() reclaim logic can be improved further,
> > making the drain logic more efficient when it comes to time, thus to reduce a footprint
> > as a result number of required pages.
> > 
> > --
> > Vlad Rezki
> 
> -- 
> Michal Hocko
> SUSE Labs
