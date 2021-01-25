Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D2CC433E0
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C70623117
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 14:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbhAYOdI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 Jan 2021 09:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbhAYOcf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 Jan 2021 09:32:35 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B115BC06178A;
        Mon, 25 Jan 2021 06:31:54 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b26so17998721lff.9;
        Mon, 25 Jan 2021 06:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J81vU0UwWpEHhAfUrDasXcHzBdqWSd90SVkou0JGu4s=;
        b=Aa5iatRhzwdZySQ1I03K4tT8lWwA7lItloapzYsFQhLCzD4Zkwi7Z2RhdRhdmh2FX5
         Uf1ID4KlMe74ptwxWoxkDlDNun/NFbcBQl2IkjIw56m1gAZziRcKw1HIofFxbyr7/T0K
         AvBID7qGAY3jpcyqPcbhojR874K43pRgxGgt545/awcFhzQJfzW4ygq+JBXuKB43f6wP
         Tox+5e2RyvBVxCIxfqAUItBOWNOmPRtVDwB5tsihVoyF+bHZP1+h/6V6YpzB0URyXv5M
         DEaNSPRiprsZ9YmfBLxYx98KkluAG2oE0XiVeImrQQx9lwtB/pvlObMenied/zkscs6R
         1evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J81vU0UwWpEHhAfUrDasXcHzBdqWSd90SVkou0JGu4s=;
        b=fVGuLAco5PO0OnutjMfxiJLYEeQBv3+A8D+XZrwjrQ3wX18hcL3HSWXNQqlvt4ql1D
         p4MIwMFdoy5/s3kiGhbnH+zO58WoBnSFPLDSePMuu8m6PqgqU6FhAF5fYmHc5tI8srnC
         SKRPE7adE2kDGNMSiSYESYXIlGEp0O+0Y8xzvYaNL17HSPZJkM7O6nHa92V9yQqOPerm
         5w6HNwIFRUWuF9zJOkxUGz/m0LeNfmGyWf9RwSwLziYEiSuzWTEtl/1axsatYoZbwavd
         PPbcd55FrvFDHfLABfPQoGyb7rgUaNZ9zFAQJdXkeL3yh6Ua+/qKIniwkdpLmJluxlob
         OQ9Q==
X-Gm-Message-State: AOAM530zI+30qa4umvXEOcmtq5lwb/dR6D548gRClORQ8yEXlZXQtrB3
        eEaNX71clF34VBEKUIHd9uc=
X-Google-Smtp-Source: ABdhPJw3s/RyopZ/qc1k6J1ikFH4L5TTXroAy0eCJZmxRuEGUsnerFoUYGwFSoIkPpYpnhNyO7mn+A==
X-Received: by 2002:a05:6512:a8e:: with SMTP id m14mr381149lfu.641.1611585113193;
        Mon, 25 Jan 2021 06:31:53 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id c14sm1934922lfd.186.2021.01.25.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:31:52 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 25 Jan 2021 15:31:50 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
Message-ID: <20210125143150.GA2282@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210125132236.GJ827@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125132236.GJ827@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Wed 20-01-21 17:21:46, Uladzislau Rezki (Sony) wrote:
> > For a single argument we can directly request a page from a caller
> > context when a "carry page block" is run out of free spots. Instead
> > of hitting a slow path we can request an extra page by demand and
> > proceed with a fast path.
> > 
> > A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> > and that its fallback is the relatively high latency synchronize_rcu().
> > Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> > to allow limited sleeping within the memory allocator.
> 
> __GFP_RETRY_MAYFAIL can be quite heavy. It is effectively the most heavy
> way to allocate without triggering the OOM killer. Is this really what
> you need/want? Is __GFP_NORETRY too weak?
> 
Hm... We agreed to proceed with limited lightwait memory direct reclaim.
Johannes Weiner proposed to go with __GFP_NORETRY flag as a starting
point: https://www.spinics.net/lists/rcu/msg02856.html

<snip>
    So I'm inclined to suggest __GFP_NORETRY as a starting point, and make
    further decisions based on instrumentation of the success rates of
    these opportunistic allocations.
<snip>

but for some reason, i can't find a tail or head of it, we introduced
__GFP_RETRY_MAYFAIL what is a heavy one from a time consuming point of view.
What we would like to avoid.

I tend to say that it was a typo.

Thank you for pointing to it!

--
Vlad Rezki
