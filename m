Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC1DC4361B
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 18:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E333222ADC
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 18:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgLOSBr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgLOSBr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Dec 2020 13:01:47 -0500
Date:   Tue, 15 Dec 2020 10:01:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608055266;
        bh=wMptYU//DX/GghwPyzRrLCYt0vjXqBmZ0hEHOtPOBUg=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sxQDv2MPfoEx2MwgNPJUtadi1631ewoLHxoTbHFmyuF28tBZxYxFNpJ7RrYjgujCM
         +gLtCRdCtr9GneNUn5lPgUlcC9ByPGCBvF//x1o1h3NAXYpcCtQLlIkPvxftKJfX1l
         zL5BhgofpvVl80/VZeQcOhCJA0kCEYGMDpE6Dr4PaVpGsGyLAvGkrhYI0WGi5lwHJF
         xC7F8BP2V4so0WtYDggNKbyHS6NglKZLw6+JpMJnjh/ilO1E8VxnOld+udhSkNa5OB
         7d7rNtHHmv+RQEY9e/68lIkj+6/RN9UsDBz/LwtDZUYwFWJMufNS8YP9Xo+NokmYsT
         ZHx197ZZtwcOA==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] A few smaller RCU related patches from the RT tree
Message-ID: <20201215180106.GC2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201215141649.796472-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201215141649.796472-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 15, 2020 at 03:16:44PM +0100, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> I know the timming of this regarding the merge window is bad. I meant to
> send them for days…

Not a problem!

However, unless any of these are urgent, I plan to submit them not into
this merge window, but rather into the v5.12 merge window.  (I don't
see any of them being urgent, but I could well be missing something.)

> Initially I planned to send only 5/5 of the series but then I stumbled
> upon the other RCU related patches and I don't see a reason I shouldn't
> post them.
> I still have one patch regarding rcutorture which I hold on to until the
> current issues are resolved (in case you are curious: Scott made sure BH
> can disabled properly in atomic context on RT (while keeping this
> limitation to RT only builds). The current softirq implementation does
> not allow to disable BH in atomic context).

Queued and pushed, thank you all!  Nice automation of PREEMPT_RT
configuration.

I have done my usual wordsmithing, so if any of you see anything I messed
up, please don't keep it a secret.

I also updated #2 and #3 to change kernel-parameters.txt accordingly.

							Thanx, Paul
