Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82550C433DF
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 16:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA0020825
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 16:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVp11LFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgHJQHp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHJQHo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 12:07:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176DC061756;
        Mon, 10 Aug 2020 09:07:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so10198325ljk.6;
        Mon, 10 Aug 2020 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dh5pxfu7/pgHwsQwQreRcaLKsiqSgH9EHfw1MkqH9dQ=;
        b=rVp11LFyZLHBy71x8pRZLwe76YoU7YVxqoRfxuWveXBqlsBt2ex+TOMyz822eLehDS
         QFCV/LyH0kgxsrV5GClRBskB5iCA8iJOelf+0/4VzJTnrBpFNArA08Ui1L972em2OFpU
         VJOXW9TPkf2x028Tp8Y1rc5sa0WuzVCjePI9i94yZ2O06UPAn0fbG2CnJ81Uc4rtujSu
         H4uXCJ4ZS/hGs5xMU0Bl1MX0p39p3FXBQSqqdK5q1+FVgouuL9SHORD6RvE0LcvsMwvT
         +Qj7hX4jvp5X8w8dK3EiUVmAkjjyUhIeHfceWwLFiJJBlJ4QidV9RQocVL0gdZd0YsIx
         X61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dh5pxfu7/pgHwsQwQreRcaLKsiqSgH9EHfw1MkqH9dQ=;
        b=af2ZMmocuangWkrtIvRiAMfCqiOjwQHrUK31k06oIKlOZYATp8dtKv8xTzwCllv3TM
         9fZAnfPaZjsio13zr0xPtq5rf0KSMbNx3PJ8ogTxmgII3/4C02TPf+ykxs6/6+Vausmc
         TwmtaUTeE45tAxw8qBHtjVpClr17SKAYvfogJOnGmW8gBphLIdOUK/Y04acikLX75LwG
         OzSIdqzSk8wMRZVr8+EtrN0Z4CLBFzEBYuq4CazEvgBk/8m+jzERsScT6lklCg8HJNjW
         NfH/pK78rMl6uYcsP5lPB0qODOhr+LIxodc0XXE3bRPCrMRkaOWexNWsuHURcrHd6pkj
         pI6g==
X-Gm-Message-State: AOAM530vtea1fzoRzknBEiZMgh4fijqmQ7/IOHHvSXkyYZHb8FwWceqi
        aiDltLZxeU5eWxOiS9+Myj0=
X-Google-Smtp-Source: ABdhPJxwAhyWi/GCQhxW2Ip8kMj4Btz4IHjZSMHAW7WZgCSgGml/37DyJxBafbCnm3pbaPWtXxvNDQ==
X-Received: by 2002:a2e:85a:: with SMTP id g26mr941256ljd.319.1597075662249;
        Mon, 10 Aug 2020 09:07:42 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o25sm10200312ljg.45.2020.08.10.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 09:07:41 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 10 Aug 2020 18:07:39 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200810160739.GA29884@pc636>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810123141.GF4773@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Sun 09-08-20 22:43:53, Uladzislau Rezki (Sony) wrote:
> [...]
> > Limitations and concerns (Main part)
> > ====================================
> > The current memmory-allocation interface presents to following
> > difficulties that this patch is designed to overcome:
> > 
> > a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
> >    complain about violation("BUG: Invalid wait context") of the
> >    nesting rules. It does the raw_spinlock vs. spinlock nesting
> >    checks, i.e. it is not legal to acquire a spinlock_t while
> >    holding a raw_spinlock_t.
> > 
> >    Internally the kfree_rcu() uses raw_spinlock_t(in rcu-dev branch)
> >    whereas the "page allocator" internally deals with spinlock_t to
> >    access to its zones. The code also can be broken from higher level
> >    of view:
> >    <snip>
> >        raw_spin_lock(&some_lock);
> >        kfree_rcu(some_pointer, some_field_offset);
> >    <snip>
> 
> Is there any fundamental problem to make zone raw_spin_lock?
> 
Good point. Converting a regular spinlock to the raw_* variant can solve 
an issue and to me it seems partly reasonable. Because there are other
questions if we do it:

a) what to do with kswapd and "wake-up path" that uses sleepable lock:
    wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).

b) How RT people reacts on it? I guess they will no be happy.

As i described before, calling the __get_free_page(0) with 0 as argument
will solve the (a). How correctly is it? From my point of view the logic
that bypass the wakeup path should be explicitly defined.

Or we can enter the allocator with (__GFP_HIGH|__GFP_ATOMIC) that bypass
the __GFP_KSWAPD_RECLAIM as well.

Any thoughts here? Please comment.

Having proposed flag will not heart RT latency and solve all concerns.

> > b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
> >    is converted into sleepable variant. Invoking the page allocator from
> >    atomic contexts leads to "BUG: scheduling while atomic".
> 
> [...]
> 
> > Proposal
> > ========
> > 1) Make GFP_* that ensures that the allocator returns NULL rather
> > than acquire its own spinlock_t. Having such flag will address a and b
> > limitations described above. It will also make the kfree_rcu() code
> > common for RT and regular kernel, more clean, less handling corner
> > cases and reduce the code size.
> 
> I do not think this is a good idea. Single purpose gfp flags that tend
> to heavily depend on the current implementation of the page allocator
> have turned out to be problematic. Users used to misunderstand their
> meaning resulting in a lot of abuse which was not trivial to remove.
> This flag seem to fall into exactly this sort of category. If there is a
> problem in nesting then that should be addressed rather than a new flag
> exported IMHO. If that is absolutely not possible for some reason then
> we can try to figure out what to do but that really need a very strong
> justification.
> 
The problem that i see is we can not use the page allocator from atomic
contexts, what is our case:

<snip>
    local_irq_save(flags) or preempt_disable() or raw_spinlock();
    __get_free_page(GFP_ATOMIC);
<snip>

So if we can convert the page allocator to raw_* lock it will be appreciated,
at least from our side, IMHO, not from RT one. But as i stated above we need
to sort raised questions out if converting is done.

What is your view?

Thank you for your help and feedback!

--
Vlad Rezki
