Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74E7C2D0A3
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 16:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959D7206DF
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 16:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giZMOFQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgKCQd4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgKCQdz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 11:33:55 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF4EC0613D1;
        Tue,  3 Nov 2020 08:33:55 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 11so183239ljf.2;
        Tue, 03 Nov 2020 08:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=34FUKrlTw4RJE4wc96wmEi0mDFfiWN/1D02cQfL3FNE=;
        b=giZMOFQupVXi4K8d+56dUwXWx2KJi/G0pjlx6IE7XMUpydIvXs2MYInQ0Ch7BbKoEd
         wuHG8OZHot108jjcg+u+o1HOTvxFBF3rhW7V6nqUrCaLBs2JX8t1GBRQSY8+V+UQr495
         /ZiyBknZ2z4e9z5/D2Ogj32eMCZxFIzvg0V1YkheHV6YTD+E5RDKG0fmYTTlefqOko6e
         X9yB1h8/qHRnnD555Ln9ugKJ4lEuL24xPtZazUuIJqHf+gaJBNmTudBQGctuArfrWNzd
         lPdvevY7KOdDX8zEhaz8feX5D4ZRUHpEzYSwp8AQ4yb9Z7dcpiM0gRvG3pgDfUiRyyuV
         zFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=34FUKrlTw4RJE4wc96wmEi0mDFfiWN/1D02cQfL3FNE=;
        b=DX1b2zGnfdKX4/fBvTR3FtsOEoL5kXw+/tm1E0S+XeTwiwOL4SdCzfy7UoAoE2LX0y
         ui8UR9C5BQXDLOIT37gMzKEKNZGLYzhRYK5/epIO0yCryNKLdm89crGxl73CX2BXoxQg
         kaMIAoQad4zvDwD6yedC0bfrYc+PcCEodrSNc+H3JpnfUJF7N9f7QN1PV90cOfnpGzQn
         xcMMbFXae45OgYo914mtAPCEg8ETfmjPeEYbbBv5Z9LpxHkOkb6kZtYS5IYhkf6g/rbU
         bV2zquZC91hS6oDb/bch2t24Qe12BJToc5/WJF2etVzUjaLH8sGOLybD4SKuntxoBgXg
         jh6Q==
X-Gm-Message-State: AOAM530yt6MaO+V3jv92DxDRpl/WcRCghSR3jT8uMja+PUytIbWgXjgP
        U1ucqw94lbefy2I7LXx/s8o=
X-Google-Smtp-Source: ABdhPJw6kSH2j7rA0jUgk/horOzGYR0HLbfG4aE0at50yXgqVRdZBk6kiE3eyyY7oINDu5j7L4CGXQ==
X-Received: by 2002:a2e:9449:: with SMTP id o9mr7844019ljh.457.1604421233930;
        Tue, 03 Nov 2020 08:33:53 -0800 (PST)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y27sm4477343ljm.74.2020.11.03.08.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:33:53 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 3 Nov 2020 17:33:50 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        willy@infradead.org
Subject: Re: [PATCH 01/16] rcu/tree: Add a work to allocate pages from
 regular context
Message-ID: <20201103163350.GA10665@pc636>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201103154723.GA1310511@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103154723.GA1310511@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 10:47:23AM -0500, Joel Fernandes wrote:
> On Thu, Oct 29, 2020 at 05:50:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > The current memmory-allocation interface presents to following
> > difficulties that this patch is designed to overcome:
> > 
> > a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
> >    complain about violation("BUG: Invalid wait context") of the
> >    nesting rules. It does the raw_spinlock vs. spinlock nesting
> >    checks, i.e. it is not legal to acquire a spinlock_t while
> >    holding a raw_spinlock_t.
> > 
> >    Internally the kfree_rcu() uses raw_spinlock_t whereas the
> >    "page allocator" internally deals with spinlock_t to access
> >    to its zones. The code also can be broken from higher level
> >    of view:
> >    <snip>
> >        raw_spin_lock(&some_lock);
> >        kfree_rcu(some_pointer, some_field_offset);
> >    <snip>
> > 
> > b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
> >    is converted into sleepable variant. Invoking the page allocator from
> >    atomic contexts leads to "BUG: scheduling while atomic".
> > 
> > c) call_rcu() is invoked from raw atomic context and kfree_rcu()
> >    and kvfree_rcu() are expected to be called from atomic raw context
> >    as well.
> > 
> > Move out a page allocation from contexts which trigger kvfree_rcu()
> > function to the separate worker. When a k[v]free_rcu() per-cpu page
> > cache is empty a fallback mechanism is used and a special job is
> > scheduled to refill the per-cpu cache.
> 
> Looks good, still reviewing here. BTW just for my education, I was wondering
> about Thomas's email:
> https://lkml.org/lkml/2020/8/11/939
> 
> If slab allocations in pure raw-atomic context on RT is not allowed or
> recommended, should kfree_rcu() be allowed?
>
Thanks for reviewing, Joel :)

The decision was made that we need to support kfree_rcu() from "real atomic contexts",
to align with how it used to be before. We can go and just convert our local locks
to the spinlock_t variant but that was not Paul goal, it can be that some users need
kfree_rcu() for raw atomics.

>
> slab can have same issue right? If per-cpu cache is drained, it has to
> allocate page from buddy allocator and there's no GFP flag to tell it about
> context where alloc is happening from.
> 
Sounds like that. Apart of that, it might turn out soon that we or somebody
else will rise a question one more time about something GFP_RAW or GFP_NOLOCKS.
So who knows..

>
> Or are we saying that we want to support kfree on RT from raw atomic atomic
> context, even though kmalloc is not supported? I hate to bring up this
> elephant in the room, but since I am a part of the people maintaining this
> code, I believe I would rather set some rules than supporting unsupported
> usages. :-\ (Once I know what is supported and what isn't that is). If indeed
> raw atomic kfree_rcu() is a bogus use case because of -RT, then we ought to
> put a giant warning than supporting it :-(.
> 
We discussed it several times, the conclusion was that we need to support 
kfree_rcu() from raw contexts. At least that was a clear signal from Paul 
to me. I think, if we obtain the preemtable(), so it becomes versatile, we
can drop the patch that is in question later on in the future.

--
Vlad Rezki
