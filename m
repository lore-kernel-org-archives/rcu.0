Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A0DC433E0
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 13:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C0B22E03
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 13:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbhAYNYV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 Jan 2021 08:24:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:52268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbhAYNXe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 Jan 2021 08:23:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611580960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBPiTlyjs/rd83M2ASR6VRAaO1aAU7kqtIEB/emLiF8=;
        b=SM0/VTZMBNHqgVSuRgzW1bNKEyfnhksCGuH4r2StqhGzYxnWNABch2SuUX6p+L2X1mDXnL
        aNXKT/QdbIrBpwYw9o+SWb7pZ9R6JZ86HkWsozspmX79BC3T7osgRXNEyN0Fw6ynjFK8jy
        U9LfjEsj/V/we54F6DHsz/7/ykpPgMU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EE9CAC45;
        Mon, 25 Jan 2021 13:22:40 +0000 (UTC)
Date:   Mon, 25 Jan 2021 14:22:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
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
Message-ID: <20210125132236.GJ827@dhcp22.suse.cz>
References: <20210120162148.1973-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120162148.1973-1-urezki@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 20-01-21 17:21:46, Uladzislau Rezki (Sony) wrote:
> For a single argument we can directly request a page from a caller
> context when a "carry page block" is run out of free spots. Instead
> of hitting a slow path we can request an extra page by demand and
> proceed with a fast path.
> 
> A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> and that its fallback is the relatively high latency synchronize_rcu().
> Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> to allow limited sleeping within the memory allocator.

__GFP_RETRY_MAYFAIL can be quite heavy. It is effectively the most heavy
way to allocate without triggering the OOM killer. Is this really what
you need/want? Is __GFP_NORETRY too weak?

-- 
Michal Hocko
SUSE Labs
