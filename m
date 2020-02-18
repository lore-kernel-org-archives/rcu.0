Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B508DC34026
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 16:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8874122B48
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582043246;
	bh=g4SX2EAdv0Lss0yuIHjV1Q7lezMQULs/fMZcNV/QQ3k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=DNjPi4PQZP4xppAO8g20pLsDqWroDs9ud0ZBSVBZcUgv9TOiXOwa5Ucm846bhy1aQ
	 fkSLdcWgpCSWIUS6BDPE4pkaYV0gIsphrEJ2IN02mWbOJ58P4lTsU5m6ns0YYW+N6E
	 7R6kWfqNgsBCGs+9k7PMAnBBBrWZmpNmeJYXwpHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRQ1U (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:27:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgBRQ1U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 11:27:20 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE90C2176D;
        Tue, 18 Feb 2020 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582043239;
        bh=g4SX2EAdv0Lss0yuIHjV1Q7lezMQULs/fMZcNV/QQ3k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pe5KoDGt6L1fPDtMVwjJLIbK+9fwD4nJTudR24F5UDL43yAqkUcW8/y4JeEoweyw8
         uXovH1U/+3jmz7sXzSoWYTGgu6Ihz/jSkPAoxaEQMgvaB4Pd2LpcqBY53Gsi2eXybn
         n8d4YrOeWfk11Nh5hWN7NrqIDyIJFIOo3tKccAs4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 84A8D3520365; Tue, 18 Feb 2020 08:27:19 -0800 (PST)
Date:   Tue, 18 Feb 2020 08:27:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200218162719.GE2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
 <20200217181615.GP2935@paulmck-ThinkPad-P72>
 <20200218075648.GW14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218075648.GW14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 18, 2020 at 08:56:48AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 17, 2020 at 10:16:16AM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 17, 2020 at 01:38:51PM +0100, Peter Zijlstra wrote:
> > > On Fri, Feb 14, 2020 at 04:25:18PM -0800, paulmck@kernel.org wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > 
> > > > The RCU tasks list of callbacks, rcu_tasks_cbs_head, is sampled locklessly
> > > > by rcu_tasks_kthread() when waiting for work to do.  This commit therefore
> > > > applies READ_ONCE() to that lockless sampling and WRITE_ONCE() to the
> > > > single potential store outside of rcu_tasks_kthread.
> > > > 
> > > > This data race was reported by KCSAN.  Not appropriate for backporting
> > > > due to failure being unlikely.
> > > 
> > > What failure is possible here? AFAICT this is (again) one of them
> > > load-complare-against-constant-discard patterns that are impossible to
> > > mess up.
> > 
> > First, please keep in mind that this is RCU code.  Rather uncomplicated
> > for RCU, to be sure, but still RCU code.
> > 
> > The failure modes are thus as follows:
> > 
> > o	I produce a patch for which KCSAN gives a legitimate warning,
> > 	but this warning is obscured by a pile of other warnings.
> > 	Yes, we should continue improving KCSAN's ability to adapt
> > 	to the users desired compiler-optimization risk level, but
> > 	in RCU's case that risk level is set quite low.
> > 
> > 	In RCU, what others are calling false positives are therefore
> > 	addressed.  Yes, this does cost me a bit of work, but it is
> > 	trivial compared to the work required to track down a real bug.
> > 
> > o	Someone optimizes or otherwise changes the wait/wakeup code,
> > 	which inadvertently gives the compiler more scope for mischief.
> > 
> > In short, within RCU, I am handling all KCSAN complaints.  This is looking
> > to be an extremely inexpensive insurance policy for RCU.  Other subsystems
> > are of course free to make their own tradeoffs, and subsystems having
> > less-aggressive concurrency control might be well-advised to take a
> > different path than the one I am taking.
> 
> I just took offence at the Changelog wording. It seems to suggest there
> actually is a problem, there is not.

Quoting the changelog: "Not appropriate for backporting due to failure
being unlikely."

Good enough?

							Thanx, Paul
