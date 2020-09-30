Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE82C4727C
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 15:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A892085B
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 15:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JzWqktQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgI3PZX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgI3PZT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 11:25:19 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6900C061755
        for <rcu@vger.kernel.org>; Wed, 30 Sep 2020 08:25:19 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h1so1074915qvo.9
        for <rcu@vger.kernel.org>; Wed, 30 Sep 2020 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xCd+oCgv7oAd+34p0BYKsp9wxKF5wq3oIEDSZ6JHbPA=;
        b=JzWqktQe2JPtx5T9AJC7N/S7gcKe7i+bQDBtIDqxoUCCr/aCiMKBFfnEXyTuBv7+kS
         3kBpse8b1y9++0M+YX/b5PlR7Cjol7fPh3EARvLtGBxWXa4s0U2Sbcq7679fl03EEdoI
         Wdi7CrxlTz/BXfg9dbu1WNTuLcKYipGbyifyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xCd+oCgv7oAd+34p0BYKsp9wxKF5wq3oIEDSZ6JHbPA=;
        b=ASXYR2qvxZQXNfeaEx8urpbhK+Jq3T0/+eNwYzVyhQjbwbzVEZmgxWxxhYLdNqsRON
         4E7pbPRsAmVBsrACDHDWB2uYLbdL3M9lm+YRZCDfCXAtoMADwVCVlvaJNA3Af5EqJ2FE
         DNfjunCccQQ5H66QCYKLp2kE3ttKfwAmv5b4yRJcnUxJDXfblvxCTC0xfHxeGWL64tdC
         nsvp9yHytj0ja6vbkrkJLRtSw7q7S5BZNWUiSW/9tGLxlm/itrjLk7iexZXkhgGXCmAb
         kxaTnrKeZcLip5UdUdVqOPZzE71EjUkT1e+qibxBVGV8gugilOUrXoPJ8nIyrGCE6v7i
         QI5A==
X-Gm-Message-State: AOAM532r4xcGyFM+KnUQucqzXE3EMY5VqgbiqJ8JYH9gduUbEauqhTTf
        jbNLX3Nk+1zZI1Un6QgttBIUMA==
X-Google-Smtp-Source: ABdhPJyX0Syo2BlisA2aHEHjNNGruchTWUJTVecItlMh4iy3on+ytmrEr8BQ9lAmnHntoXZpAQKF+w==
X-Received: by 2002:a0c:e2c1:: with SMTP id t1mr3092219qvl.35.1601479518915;
        Wed, 30 Sep 2020 08:25:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id v15sm2350950qkg.108.2020.09.30.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:25:17 -0700 (PDT)
Date:   Wed, 30 Sep 2020 11:25:17 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200930152517.GA1470428@google.com>
References: <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925154741.GI3389@dhcp22.suse.cz>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 25, 2020 at 05:47:41PM +0200, Michal Hocko wrote:
> On Fri 25-09-20 17:31:29, Uladzislau Rezki wrote:
> > > > > > 
> > > > > > All good points!
> > > > > > 
> > > > > > On the other hand, duplicating a portion of the allocator functionality
> > > > > > within RCU increases the amount of reserved memory, and needlessly most
> > > > > > of the time.
> > > > > > 
> > > > > 
> > > > > But it's very similar to what mempools are for.
> > > > > 
> > > > As for dynamic caching or mempools. It requires extra logic on top of RCU
> > > > to move things forward and it might be not efficient way. As a side
> > > > effect, maintaining of the bulk arrays in the separate worker thread
> > > > will introduce other drawbacks:
> > > 
> > > This is true but it is also true that it is RCU to require this special
> > > logic and we can expect that we might need to fine tune this logic
> > > depending on the RCU usage. We definitely do not want to tune the
> > > generic page allocator for a very specific usecase, do we?
> > > 
> > I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> > to provide a memory service for contexts which are not allowed to
> > sleep, RCU is part of them. Both flags used to provide such ability
> > before but not anymore.
> > 
> > Do you agree with it?
> 
> Yes this sucks. But this is something that we likely really want to live
> with. We have to explicitly _document_ that really atomic contexts in RT
> cannot use the allocator. From the past discussions we've had this is
> likely the most reasonable way forward because we do not really want to
> encourage anybody to do something like that and there should be ways
> around that. The same is btw. true also for !RT. The allocator is not
> NMI safe and while we should be able to make it compatible I am not
> convinced we really want to.
> 
> Would something like this be helpful wrt documentation?
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 67a0774e080b..9fcd47606493 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -238,7 +238,9 @@ struct vm_area_struct;
>   * %__GFP_FOO flags as necessary.
>   *
>   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> - * watermark is applied to allow access to "atomic reserves"
> + * watermark is applied to allow access to "atomic reserves".
> + * The current implementation doesn't support NMI and other non-preemptive context
> + * (e.g. raw_spin_lock).

I think documenting is useful.

Could it be more explicit in what the issue is? Something like:

* Even with GFP_ATOMIC, calls to the allocator can sleep on PREEMPT_RT
systems. Therefore, the current low-level allocator implementation does not
support being called from special contexts that are atomic on RT - such as
NMI and raw_spin_lock. Due to these constraints and considering calling code
usually has no control over the PREEMPT_RT configuration, callers of the
allocator should avoid calling the allocator from these cotnexts even in
non-RT systems.

thanks!

 - Joel


>   *
>   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
>   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
> 
> [...]
> -- 
> Michal Hocko
> SUSE Labs
