Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2899C433E0
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 20:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EF864D9C
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 20:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBSUFY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 15:05:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhBSUFW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 15:05:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A8BD64EB3;
        Fri, 19 Feb 2021 20:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613765082;
        bh=nr+McG2ADGSNEQqYSZT5Z/cC8I652e0cpk0XJSpfvyI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gjO1SX2n2XDnTFozMVJbRg/lE3fjxDcWDX+Xp1v6pMU7g5s/k4ugP5SAL+wxToKrI
         9cO1IhHUfwDvSqVYN6aUWGmaPxOVrvugRFnM7CN+GdLpqlIDNMA3LY01ht3A2t/Sjz
         lmxEqkvloNzTN38T+zoAwXyUAOYRuJLQjXVRu7nyI+gVibqZMUXhJAUXC+ghIpD3/W
         W1TUGFgkaHq3YdDqBMZQOeulf951c0H4rA1fKRywf2CTM3dmOKGdj0F6frQN3NriIZ
         NU1mk/EmqLpWVqF4ozo8MUqAfahV3BFJ2urHYgMV2N4pOdl3uRmGFvC5+qG5aTH97z
         v9YqxD0eX8pnQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 24A333520E6A; Fri, 19 Feb 2021 12:04:42 -0800 (PST)
Date:   Fri, 19 Feb 2021 12:04:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20210219200442.GB2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210219143607.3cdf9ed8@gandalf.local.home>
 <20210219194744.GA2743@paulmck-ThinkPad-P72>
 <20210219145830.0baca550@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219145830.0baca550@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 19, 2021 at 02:58:30PM -0500, Steven Rostedt wrote:
> On Fri, 19 Feb 2021 11:47:44 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Could you please add the following Reported-by tags?
> > 
> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Reported-by: Uladzislau Rezki <urezki@gmail.com>
> > 
> > Sebastian first noticed the problem, and Uladzislau figured out
> > how softirqs were involved.
> 
> These were already added. They must have appeared in the thread somewhere,
> as my internal patchwork picked them up already.

Even better, thank you!

							Thanx, Paul
