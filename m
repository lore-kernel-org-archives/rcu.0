Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED20C4727E
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 15:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1BC206D4
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 15:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WV//9SwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgI3Pwb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3Pwb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 11:52:31 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D8C061755
        for <rcu@vger.kernel.org>; Wed, 30 Sep 2020 08:52:31 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cr8so1123958qvb.10
        for <rcu@vger.kernel.org>; Wed, 30 Sep 2020 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U5B+DFlgjUCfVVr9Dz8Mt+RPlNdJaSsb6hueCXdN2UY=;
        b=WV//9SwE2q/r9XyXsDlPrOuIcGjLmuR66fo/ASIwZL/CGda9BpAxGw2XIKpOXFnqCe
         Kfxr0Y/Rsrf9vK5Hk7HiH/Gy180JQ6PJjs1bVknOi2dR/cQ4Dsblwu/EcdHVh+hckTyX
         iAvq4jAFbQlNbRTFkL+KvY7LQW57Fyhk+o9wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U5B+DFlgjUCfVVr9Dz8Mt+RPlNdJaSsb6hueCXdN2UY=;
        b=VOsMzfpSTQ7U1NbSLe+VUibN1E61JQDIjNV05QiENAHXViTl/Uex61dna/AYOBhWcp
         DDxYSnQcT9ybB99w6EcQ7DJvQHPmZmfPiIcWW0OfxM+wkyhVDB3aGqzisZLZZOjVDNd2
         Y9EjxzMkLdI+lWk/9tzLZLMs1DtAG9LqSlmYSo8MZ1KtBIi4Bu0rg1Lm8xpNcC1H2mFK
         zmaxSmhLUJitCBF6qZpQEHed/mWLfkkyinMA9zw7R0owyAdSkTpaFk4m9FoTom4uG36N
         F95Gexrjmkb4DZU7TF3S51owaDWGeG0B3SBEbvqOBjX1zxsWK7zGRjO8DjekzAPwQC4f
         yJGg==
X-Gm-Message-State: AOAM532OcCXDUV6koIlrOntGivuTUlreu4aRncm3BO3mUDh1pc3m2qtr
        xOUPywldhIPxoE0Cm4hz+qcqgeXkpCtxQQ==
X-Google-Smtp-Source: ABdhPJxCHYn12FbypuTQ8FDk+s5B8QbO2utbnkuTv/k8oQUR5DMg5bq76vbefymLnwGGqLe6TcQGaA==
X-Received: by 2002:a0c:eda3:: with SMTP id h3mr2867524qvr.61.1601481150585;
        Wed, 30 Sep 2020 08:52:30 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 206sm2591725qkk.27.2020.09.30.08.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:52:29 -0700 (PDT)
Date:   Wed, 30 Sep 2020 11:52:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 0/4] kvfree_rcu() and _LOCK_NESTING/_PREEMPT_RT
Message-ID: <20200930155229.GA1474760@google.com>
References: <20200918194817.48921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918194817.48921-1-urezki@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 18, 2020 at 09:48:13PM +0200, Uladzislau Rezki (Sony) wrote:
> Hello, folk!
> 
> This is another iteration of fixing kvfree_rcu() issues related
> to CONFIG_PROVE_RAW_LOCK_NESTING and CONFIG_PREEMPT_RT configs.
> 
> The first discussion is here https://lkml.org/lkml/2020/8/9/195.
> 
> - As an outcome of it, there was a proposal from Peter, instead of
> using a speciall "lock-less" flag it is better to move lock-less
> access to the pcplist to the separate function.
> 
> - To add a special worker thread that does prefetching of pages
> if a per-cpu page cache is depleted(what is absolutely normal). 
> 
> As usual, thank you for paying attention to it and your help!

Doesn't making it a lower priority WQ exacerbate the problem Mel described?

So like:
1. pcp cache is depleted by kvfree_rcu without refill or other measures to
   relieve memory.
2. now other GFP_ATOMIC users could likely hit the emergency reserves in the
   buddy allocator as the watermarks are crossed.
3. kvfree_rcu() notices failure and queues workqueue to do non-preemptible
   buddy allocations which will refill the pcp cache in the process.
4. But that happens much later because this patch (4/4) down prioritized the
   work to do the refill.

I'd suggest keeping it high pri since I don't see how it can make things
better.

Or another option is:
Why not just hit the fallback path in the caller on the first attempt, and
trigger the WQ to do the allocation. If the pool grows too big, we can have
shrinkers that free memory that is excessive so that will help the phone
usecases. That way no changes to low-level allocator are needed.

Or did I miss something?

thanks,

 - Joel


> 
> Uladzislau Rezki (Sony) (4):
>   rcu/tree: Add a work to allocate pages from regular context
>   mm: Add __rcu_alloc_page_lockless() func.
>   rcu/tree: use __rcu_alloc_page_lockless() func.
>   rcu/tree: Use schedule_delayed_work() instead of WQ_HIGHPRI queue
> 
>  include/linux/gfp.h |  1 +
>  kernel/rcu/tree.c   | 90 ++++++++++++++++++++++++---------------------
>  mm/page_alloc.c     | 82 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+), 41 deletions(-)
> 
> -- 
> 2.20.1
> 
