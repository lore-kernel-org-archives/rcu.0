Return-Path: <SRS0=M2zx=DY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF42BC433E7
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 20:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849A62076A
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 20:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439786AbgJQUYM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Oct 2020 16:24:12 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34453 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2439784AbgJQUYM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Oct 2020 16:24:12 -0400
Received: (qmail 843765 invoked by uid 1000); 17 Oct 2020 16:24:11 -0400
Date:   Sat, 17 Oct 2020 16:24:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     joel@joelfernandes.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki \(Sony\)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain
 smp_mb()
Message-ID: <20201017202411.GC842001@rowland.harvard.edu>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org>
 <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com>
 <20201017031941.GD4015033@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017031941.GD4015033@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

[I sent this reply earlier, but since it hasn't shown up in the mailing 
list archives, I may have forgotten to include the proper CC's.  At the 
risk of repeating myself, here it is again.]

On Fri, Oct 16, 2020 at 11:19:41PM -0400, joel@joelfernandes.org wrote:
> So I made a litmus test to show that smp_mb() is needed also after the update
> to length. Basically, otherwise it is possible the callback will see garbage
> that the module cleanup/unload did.
> 
> C rcubarrier+ctrldep
> 
> (*
>  * Result: Never
>  *
>  * This litmus test shows that rcu_barrier (P1) prematurely
>  * returning by reading len 0 can cause issues if P0 does
>  * NOT have a smb_mb() after WRITE_ONCE(len, 1).
>  * mod_data == 2 means module was unloaded (so data is garbage).
>  *)
> 
> { int len = 0; int enq = 0; }
> 
> P0(int *len, int *mod_data, int *enq)
> {
> 	int r0;
> 
> 	WRITE_ONCE(*len, 1);
> 	smp_mb();		/* Needed! */
> 	WRITE_ONCE(*enq, 1);
> 
> 	r0 = READ_ONCE(*mod_data);
> }
> 
> P1(int *len, int *mod_data, int *enq)
> {
> 	int r0;
> 	int r1;
> 
> 	r1 = READ_ONCE(*enq);
> 
> 	// barrier Just for test purpose ("exists" clause) to force the..
> 	// ..rcu_barrier() to see enq before len
> 	smp_mb();		
> 	r0 = READ_ONCE(*len);
> 
> 	// implicit memory barrier due to conditional */
> 	if (r0 == 0)
> 		WRITE_ONCE(*mod_data, 2);
> }
> 
> // Did P0 read garbage?
> exists (0:r0=2 /\ 1:r0=0 /\ 1:r1=1)

Is this exists clause really what you meant?  Not only can it not be 
satisfied, it couldn't even be satisfied if you left out the 0:r0=2 
part.  And smp_mb() is stronger than neessary to enforce this.

However, some memory barrier is needed.  If the smp_mb() in P1 were 
omitted then P1 would be free to reorder its reads, and the exists 
clause could be satisfied as follows:

	P0			P1
	------------------------------------------
				Read len = 0
	Write len = 1
	smp_mb();
	Write enq = 1
				Read enq = 1
				Write mod_data = 2
	Read mod_data = 2

Alan
