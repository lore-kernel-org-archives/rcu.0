Return-Path: <SRS0=f/Ck=BO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEB1C433DF
	for <rcu@archiver.kernel.org>; Tue,  4 Aug 2020 21:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2057A2086A
	for <rcu@archiver.kernel.org>; Tue,  4 Aug 2020 21:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijxV/DAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHDVEx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgHDVEx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 Aug 2020 17:04:53 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DAEC06174A;
        Tue,  4 Aug 2020 14:04:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b11so23131178lfe.10;
        Tue, 04 Aug 2020 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PKnGy/DpZiS1BGuPhPvnP3nG7CGqe0ye333RHTJ9F2Q=;
        b=ijxV/DAhKlwSitFaSXIu1XEk0os71AFmAEd/Ikq1z7GW3czVrOKl13nhEUjuGL2bo/
         RQINvlbqF042Dy7qMTaI5ksu3NuFAVIEJiFrbDLdVdz8sKRfbe31J2OVWc4A2xZ1Iur6
         wj7iOk5ky3qlEoV1d7msllPCwzYE09W8nBeLmX9qoHrbLokTrfxA2Yxri2vXxy9angyZ
         bLlT4W7UVkdOg4mL6phJkqTWIBmOxt9vne1Kn0TrwCYE5vMaSEdqDvAfSVfQoTySE6ig
         SiTJq9JcHIv7Xdjya6jboYFL8ssRXmGyXDD6w56d8X8iCiXb5ln2+/bw7pV1OY/FQOmx
         XXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PKnGy/DpZiS1BGuPhPvnP3nG7CGqe0ye333RHTJ9F2Q=;
        b=KLOrGNinjOHVZ9KpetfaW7xnoiAi+BMbWWRsj6gSIcqmLCi0bcSfxC5LvJWHIk7Lir
         tFaAdAA8eX3G4y6bS/qSWpNePyksLUS+WgW9Ef+p6PLAv8aR3ZeREMM1QP4RU4GY0XA5
         C98QJBTkJo+k2LR1+yh0v9CEWtyp3ckvaSy/0vo1PwBNWY3nNulGJ292sJwzIkEeMmw1
         gewslPNtGVOaXORq+vFdFy2H9Vq9LV2b9K+rbcuk80sQYdxk2mipFfCKq1wmU5UiV+j1
         EPVllD0HMk6XArEN9ymP2qGGYQW7QDgfaP8Hp+kmOipw4VrTck6vdm6fRQxd1LODH3Nv
         OVSw==
X-Gm-Message-State: AOAM530wxG8/nUwo2xUmrki1NK0I/EByexPdnENl676LGT+uz4PrhKQA
        iEGpuo9YmSYyFVe4z25CXac=
X-Google-Smtp-Source: ABdhPJzLSXjsfjrVr7j95IjJ2hBSnQ97XDIokVkvlvAWIRJolk3lsPGM6qeTi1y9GCtT9ISNwY/Ttw==
X-Received: by 2002:a19:c519:: with SMTP id w25mr46763lfe.24.1596575091566;
        Tue, 04 Aug 2020 14:04:51 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a9sm5510382ljb.57.2020.08.04.14.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:04:51 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 4 Aug 2020 23:04:48 +0200
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PROTOTYPE 1/1] mm: Add __GFP_FAST_TRY flag
Message-ID: <20200804210448.GC29837@pc636>
References: <20200803163029.1997-1-urezki@gmail.com>
 <1d50a46a-b97f-96b2-8a5c-21075f022f01@suse.cz>
 <20200804171203.GH23808@casper.infradead.org>
 <fe1dcc38-c968-0439-cb01-431cf004fc38@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1dcc38-c968-0439-cb01-431cf004fc38@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 04, 2020 at 07:34:18PM +0200, Vlastimil Babka wrote:
> On 8/4/20 7:12 PM, Matthew Wilcox wrote:
> > On Tue, Aug 04, 2020 at 07:02:14PM +0200, Vlastimil Babka wrote:
> >> > 2) There was a proposal from Matthew Wilcox: https://lkml.org/lkml/2020/7/31/1015
> >> > 
> >> > <snip>
> >> > On non-RT, we could make that lock a raw spinlock.  On RT, we could
> >> > decline to take the lock.  We'd need to abstract the spin_lock() away
> >> > behind zone_lock(zone), but that should be OK.
> >> > <snip>
> >> > 
> >> > It would be great to use any existing flag, say GFP_NOWAIT. Suppose we
> >> > decline to take the lock across the page allocator for RT. But there is
> >> > at least one path that does it outside of the page allocator. GFP_NOWAIT
> >> > can wakeup the kswapd, whereas a "wake-up path" uses sleepable lock:
> >> > 
> >> > wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).
> >> > 
> >> > Probably it can be fixed by the excluding of waking of the kswapd process
> >> > defining something like below:
> >> 
> >> Is something missing here?
> >> 
> >> > what is equal to zero and i am not sure if __get_free_page(0) handles
> >> > all that correctly, though it allocates and seems working on my test
> >> > machine! Please note it is related to "if we can reuse existing flags".
> >> > 
> >> > In the meantime, please see below for a patch that adds a __GFP_FAST_TRY,
> >> > which can at least serve as a baseline against which other proposals can
> >> > be compared. The patch is based on the 5.8.0-rc3.
> >> > 
> >> > Please RFC.
> >> 
> >> At first glance __GFP_FAST_TRY (more descriptive name? __GFP_NO_LOCKS?) seems
> >> better than doing weird things with GFP_NOWAIT, but depends on the real benefits
> >> (hence my first questions).
> > 
> > I think what Vlad is trying to say is that even GFP_NOWAIT will wake
> > kswapd, which involves taking a spinlock.  If you specify 0 in your GFP
> > flags, then we won't wake kswapd.  So a simple:
> > 
> > #define GFP_NOLOCKS	0
> > 
> > should do the trick (modulo various casting, blah blah blah)
> 
> Ah, you're right, waking up kswapd is is only done with __GFP_KSWAPD_RECLAIM and
> GFP_NOWAIT equals to that. So that's easy to avoid for the rcu allocation.
> 
> But still IIUC option 2) would mean that even with "#define GFP_NOLOCKS	0" would
> mean we need to abstract away the zone lock, and behave differently depending on
> the kernel being RT, and inadvertedly changing other users that happen to
> specify gfp where "gfp & GFP_RECLAIM_MASK == 0" (or however we would exactly
> check if we can take the lock on RT kernel). That sounds too complicated to me.
>
I think a different behaviour, i mean RT/non-rt, is not a way forward, because the
things will be over complicated. Please note, the proposed variant is common. It
provides a fast access to pcp-cache, what can be done lock-less. If we could extend
the "fast path" even do the lock-less prefetch(make fast path fully lock-less) from
the body would be fantastic, but that is a bit out of the question.

For example implement removing/inserting pages from "zone->free_area" as lock-less:
llist_add()/llist_del(). But that is theory and on the high level. During investigation
the things might become complicated.

--
Vlad Rezki
