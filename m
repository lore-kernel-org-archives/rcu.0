Return-Path: <SRS0=BSCp=DM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E772C46466
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 14:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E382205F4
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 14:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiWZbP5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJEOMk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Oct 2020 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgJEOMk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Oct 2020 10:12:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D8DC0613CE;
        Mon,  5 Oct 2020 07:12:38 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so1669896lfc.7;
        Mon, 05 Oct 2020 07:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0As6rxUqTKqZtGA65NYtxYDkFlsoQzhzCASeNPdSS6Y=;
        b=CiWZbP5PMIvyDL+JAIu+09caEbIEUS87YbpK5xLAeDSoK/AQUKfI9S/UQU5D9bdkW7
         1o8D5uciQIpAq4hNilWNuXlWpDB+J+jIm3Eufc6JZkMw3Qg69suKijCbx/9mLr6qtohW
         5MzEVt5blas6uEuj9e2oj9daF8XkF4gdCYoY0+/0mBfb67sR90VYGJsIOTvwx2WQJ76T
         9rqqUZQQmM3q8Ycfa/1NF+OCU3TkAiRBLOsAIJ0UfhyNW5IZweTsXUn63OZrzqaKt88/
         QgN2DAa3mRUCwNRE0jDrF5BpkHmVw27XijYSV/LSpqKohUd8xdSv4Ff/StcyOZY8de11
         IHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0As6rxUqTKqZtGA65NYtxYDkFlsoQzhzCASeNPdSS6Y=;
        b=XjZJeKBIAMStVYzGMLFHwGEAaSSdZ4kVSo38hJ2jtfv56mfHo1udIeg67Ue5oyBP4K
         RNgVSztTopW+tqcW+8j8cyP6fsgSJI32UKSBnnkx5yPbJK+5MHu8VCnTBKtygJ3PmqA9
         W+yOqSqmTNjk6wnMi7YiW0z7s1ge3S8TGgl+4VWEJlkLR7y3eDDeLcD6Xg76j942ukgW
         0e3RUzNQdy5alVG38pyJ0RiBcJ1sGKgYc8Q0lfJ6Q2/9AHo5To3lyzRM94t1qLVuTsDI
         fCq0fRpO9+fxhbx7Lg48NksMXMjV0Z6pDLGotlnVGJs5vanNyQPg8O4e8Hg0IdHBcNqG
         s0kg==
X-Gm-Message-State: AOAM531LKHrcgnZkLqhjI97c0pKVCMAnyxEB5FR3ih/3p/67Ryu4jRaB
        XYlun4VzSp4+MISARS0y8cc=
X-Google-Smtp-Source: ABdhPJzd1nnYfxNKHqel8hrL7WlEkVN+e9coush6WVe5Ddwf2Hl2sbUdieJp6GLYKZJwna3XbEE/YA==
X-Received: by 2002:a19:c6d4:: with SMTP id w203mr6194107lff.245.1601907156944;
        Mon, 05 Oct 2020 07:12:36 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id x10sm223859ljm.71.2020.10.05.07.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:12:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 5 Oct 2020 16:12:33 +0200
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201005141233.GB17959@pc636>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002080624.GB3227@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002080624.GB3227@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 02, 2020 at 09:06:24AM +0100, Mel Gorman wrote:
> On Thu, Oct 01, 2020 at 09:26:26PM +0200, Uladzislau Rezki wrote:
> > > 
> > > No, I meant going back to idea of new gfp flag, but adjust the implementation in
> > > the allocator (different from what you posted in previous version) so that it
> > > only looks at the flag after it tries to allocate from pcplist and finds out
> > > it's empty. So, no inventing of new page allocator entry points or checks such
> > > as the one you wrote above, but adding the new gfp flag in a way that it doesn't
> > > affect existing fast paths.
> > >
> > OK. Now i see. Please have a look below at the patch, so we fully understand
> > each other. If that is something that is close to your view or not:
> > 
> > <snip>
> > t a/include/linux/gfp.h b/include/linux/gfp.h
> > index c603237e006c..7e613560a502 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -39,8 +39,9 @@ struct vm_area_struct;
> >  #define ___GFP_HARDWALL                0x100000u
> >  #define ___GFP_THISNODE                0x200000u
> >  #define ___GFP_ACCOUNT         0x400000u
> > +#define ___GFP_NO_LOCKS                0x800000u
> >  #ifdef CONFIG_LOCKDEP
> > -#define ___GFP_NOLOCKDEP       0x800000u
> > +#define ___GFP_NOLOCKDEP       0x1000000u
> >  #else
> >  #define ___GFP_NOLOCKDEP       0
> >  #endif
> > @@ -215,16 +216,22 @@ struct vm_area_struct;
> >   * %__GFP_COMP address compound page metadata.
> >   *
> >   * %__GFP_ZERO returns a zeroed page on success.
> > + *
> > + * %__GFP_NO_LOCKS order-0 allocation without sleepable-locks.
> > + * It obtains a page from the per-cpu-list and considered as
> > + * lock-less. No other actions are performed, thus it returns
> > + * NULL if per-cpu-list is empty.
> >   */
> >  #define __GFP_NOWARN   ((__force gfp_t)___GFP_NOWARN)
> >  #define __GFP_COMP     ((__force gfp_t)___GFP_COMP)
> >  #define __GFP_ZERO     ((__force gfp_t)___GFP_ZERO)
> > +#define __GFP_NO_LOCKS ((__force gfp_t)___GFP_NO_LOCKS)
> > 
> 
> I'm not a fan of the GFP flag approach simply because we've had cases
> before where GFP flags were used in inappropriate contexts like
> __GFP_MEMALLOC which led to a surprising amount of bugs, particularly
> from out-of-tree drivers but also in-tree drivers. Of course, there
> are limited GFP flags available too but at least the comment should
> be as robust as possible. Maybe something like
> 
>  * %__GFP_NO_LOCKS attempts order-0 allocation without sleepable-locks. It
>  * attempts to obtain a page without acquiring any spinlocks. This
>  * should only be used in a context where the holder holds a
>  * raw_spin_lock that cannot be released for the allocation request.
>  * This may be necessary in PREEMPT_RT kernels where a
>  * raw_spin_lock is held which does not sleep tries to acquire a
>  * spin_lock that can sleep with PREEMPT_RT. This should not be
>  * confused with GFP_ATOMIC contexts. Like atomic allocation
>  * requests, there is no guarantee a page will be returned and
>  * the caller must be able to deal with allocation failures.
>  * The risk of allocation failure is higher than using GFP_ATOMIC.
> 
> It's verbose but it would be hard to misinterpret. I think we're
> going to go through a period of time before people get familiar
> with PREEMPT_RT-related hazards as various comments that were
> true are going to be misleading for a while.
> 
Yep, it should be properly documented for sure. Including new GFP_NOWAIT
limitations, same as GFP_ATOMIC once you mentioned.

Thanks!

--
Vlad Rezki
