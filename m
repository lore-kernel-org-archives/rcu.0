Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564F6C433DB
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 08:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4E460C3D
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 08:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhBSISk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 03:18:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56922 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBSISj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 03:18:39 -0500
Date:   Fri, 19 Feb 2021 09:17:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613722676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sf15rTvAywF/JQpexG2Dhjf7nu8pdeD0B1A/8oRH0+o=;
        b=Gc90xKTezGcAf7qaNWCWPU/MzWBT0vTuharwo+Y1Kwu/JskicYMTl2XTb4EbvFsw8YKMsY
        vNWFG+OKp485LJxLM8eUwUXGHezLo4OsNxCgZX/OSoBF6oGxdwqCxMjxHrpHpligKeoILJ
        Avyt7u70tQ2fSIP/kXWylGWD9N8V8DKQ2hP6ldTHus4YcYp6B2piy32HjfF1ZSQBZkh/ah
        fzvaV1lh/d6ggBAzI7Cf9YssT6LBElFCE/AeEFzLcssp1IbM9SyUJ5IK4jgPSqJRq9m2g4
        R/HNB1WN/GfklOoCAeQ6l/yDhXX+Mv02Ixq8glAhdB/aj2fQYXfR3mFyZvBNuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613722677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sf15rTvAywF/JQpexG2Dhjf7nu8pdeD0B1A/8oRH0+o=;
        b=R7vQZvpnJ5eshjshEfst8Pnj3JVtJ+oTFYv2KwX16fwPN5VcyL7w74Dh87Q2ByyQe42rrj
        3unq5Sc4JqwVDGBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
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
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210219081755.eucq4srbam6wg2gm@linutronix.de>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210218151554.GQ2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218151554.GQ2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-02-18 07:15:54 [-0800], Paul E. McKenney wrote:
> Thank you, but the original report of a problem was from Sebastian
> and the connection to softirq was Uladzislau.  So could you please
> add these before (or even in place of) my Reported-by?
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reported-by: Uladzislau Rezki <urezki@gmail.com>
> 
> Other than that, looks good!

Perfect. I'm kind of lost here, nevertheless ;) Does this mean that the
RCU selftest can now be delayed?

> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> 							Thanx, Paul

Sebastian
