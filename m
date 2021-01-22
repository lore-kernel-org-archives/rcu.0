Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44036C433DB
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 11:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AEF235E4
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 11:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbhAVLfU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Jan 2021 06:35:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbhAVLew (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Jan 2021 06:34:52 -0500
Date:   Fri, 22 Jan 2021 12:34:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611315250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5meXrSKhyoZfKeS9Kh93mtfH6c5tIvSjx5v/iVpdsQw=;
        b=hEwKyMTH3hLrZHOazv5Ocl44eaB6X9U8Aumhjv9RxRVaqdc3nOUf0xa/lhYCJtkeKvCBSB
        J/HjnrcaI9eqs3BH10xWEOFMVCpA3VXOWElacex3Q4XBJjPLg2CA6vpWJjePFTu+YLLPyk
        MeebnEifcE/ipACB47XwETaeI2L2x1IZ19Xuufydx2aztHcgdjjDwz27hisH+mGRJe0hfH
        g9jc8FZw5nWczdpmf1ormC8QICX/pDnACI23feG5be9w1iUGXKMHNF3rQEo9Erw9tNaWFm
        f4szFTzAdbsnO8wDD24zNDStB51sEgNz0salD0Nw0mEmA/dFISU6Xqe4ubFr3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611315250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5meXrSKhyoZfKeS9Kh93mtfH6c5tIvSjx5v/iVpdsQw=;
        b=6uMvW/iEzt1yN76vO5YCIo0UH2mQBve4OKfRqzz6fu7+HeLiZPapfBVcwNa541gfg3pa1V
        jXSTD1lm30C953Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210122113409.w55kul5bpjxhkgm4@linutronix.de>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
 <20210121123834.GA1872@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210121123834.GA1872@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-01-21 13:38:34 [+0100], Uladzislau Rezki wrote:
> __get_free_page() returns "unsigned long" whereas a bnode is a pointer
> to kvfree_rcu_bulk_data struct, without a casting the compiler will
> emit a warning.

Yes, learned about it, sorry.

> >> You think that a CPU migration is a bad thing. But why?
> >>
> It is not a bad thing. But if it happens we might queue a new bnode
> to a drain list of another CPU where a previous element of a new
> bnode may be just underutilized. So that is why i use migrate_disable()/enable()
> to prevent it.

If you allocate a node for queueing and then you realize that you
already have one then you either free it or queue it for later.
Given that all this is a slower-path and that this is used on every-CPU,
sooner or later that page will be used avoids a later allocation, right?

> If there are some hidden issues with migrate_disable()/enable() or you
> think it is a bad idea to use it, it would be appreciated if you could
> describe your view in more detail.

Just what I mentioned in my previous email:
- the whole operation isn't cheap but it is more efficient in tree
  compared to what we used to have in RT.
- the task can no be freely placed while it could run. So if the task
  gets preempted, it will have to wait until it can run on the CPU
  again.

Sebastian
