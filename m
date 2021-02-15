Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C67C433E0
	for <rcu@archiver.kernel.org>; Mon, 15 Feb 2021 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A20D6023C
	for <rcu@archiver.kernel.org>; Mon, 15 Feb 2021 11:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBOL3M (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 Feb 2021 06:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhBOL3L (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 Feb 2021 06:29:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08AC061574;
        Mon, 15 Feb 2021 03:28:31 -0800 (PST)
Date:   Mon, 15 Feb 2021 12:28:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613388508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MxwGpOXkrGdyzY8s9G4bXxUPmdCNk38bTvCHj/6krR4=;
        b=bHE3DgOipOgldtzhG2liviQO1GsRzh4gOqffw5pSWDBTMHYbFQ7XGP/MYBqydeCvl/DQEq
        MdoA8FufqarXuht4pJwCiCjgs9IgvMvFYMrff6vyaNxKtBK1QcbRLhsuxHRACRbTITBtWB
        8/w+Um9DMT4vBqwP8HpC7P90MH2EaO4rXL/aPQ6tDQlLK750x53cDwX2FBhWQqv+weXVuZ
        vyqbNu8Z7FutjP6Iy3ICoiGEEO7NxC6+CXVv4nw0xfJ2cclv0Wrq+DwVyuFplrhN4EKKEw
        pvj34A2L/I7u3HPZAnrpL0v97AicAJfbQShXa0TpoGwHGjIjnkQL+Wp6FP4xrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613388508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MxwGpOXkrGdyzY8s9G4bXxUPmdCNk38bTvCHj/6krR4=;
        b=diQSEwKBV9O2FzMClcORFD/6Q4LqmTgn+I+qoGu/+Qk7nr3AWFytdBGaJNcKiTvJUG5mhg
        olyharHBBLHhvKDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-ID: <20210215112826.xc6b4se6ujwvrwco@linutronix.de>
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
 <20210212192059.wytqwdf4qm4rnq3d@linutronix.de>
 <20210212211207.GA2046@pc638.lan>
 <20210212234851.GP2743@paulmck-ThinkPad-P72>
 <20210213003709.GA27846@paulmck-ThinkPad-P72>
 <20210213004328.GB27846@paulmck-ThinkPad-P72>
 <20210213113030.GA1878@pc638.lan>
 <20210213164554.GS2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210213164554.GS2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-02-13 08:45:54 [-0800], Paul E. McKenney wrote:
> Glad you like it!  But let's see which (if any) of these patches solves
> the problem for Sebastian.

Looking at that, is there any reason for doing this that can not be
solved by moving the self-test a little later? Maybe once we reached at
least SYSTEM_SCHEDULING?
This happens now even before lockdep is up or the console is registered.
So if something bad happens, you end up with a blank terminal.

There is nothing else that early in the boot process that requires
working softirq. The only exception to this is wait_task_inactive()
which is used while starting a new thread (including the ksoftirqd)
which is why it was moved to schedule_hrtimeout().

> 							Thanx, Paul

Sebastian
