Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68592C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 23:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35EF82071A
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 23:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592521776;
	bh=H6IO8yxoUcYmqjy//mv0HgVprmtMPdFrIekLt6GlDl0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=AsxiPcwKSStJ2xgb6OsjpGV9YgECnsaMb9red1kx6dQ923WCRQIAXxT/6FvVel+Yi
	 P0DGGV5GRKyo1wOnMrd0gV2rJMs30wMm9m47BCltSu/EBxz+/2jrinpaNjCArF+Qra
	 /kQqotwbU86dJ1V+AcD6GtZO9m3CDtyYg9itIEgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgFRXJg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbgFRXJf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 19:09:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AFFB206F1;
        Thu, 18 Jun 2020 23:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592521774;
        bh=H6IO8yxoUcYmqjy//mv0HgVprmtMPdFrIekLt6GlDl0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oXclqOsqiaFDbwxelChz35mjJPApOJ2t6/OJYOhfj6dU7zgftmHcmoDdH/grPVi8R
         qiBRLHyfXup4jsmkOF9JETm2t/hdfECKSaZz5fI0ZuvHvBzdfS3g27cednpHK1kjMh
         1LqZbZcH/yUlpFyewNUgD2uv831LZ7LXAVdeYAW0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 85C83352264E; Thu, 18 Jun 2020 16:09:34 -0700 (PDT)
Date:   Thu, 18 Jun 2020 16:09:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, urezki@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/7] rcu/segcblist: Prevent useless GP start if no CBs to
 accelerate
Message-ID: <20200618230934.GA31937@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618221119.GX2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618221119.GX2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 03:11:19PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 04:29:49PM -0400, Joel Fernandes (Google) wrote:
> 
> First, this looks like a very nice optimization, thank you!
> 
> > rcu_segcblist_accelerate() returns true if a GP is to be
> > started/requested and false if not. During tracing, I found that it is
> > asking that GPs be requested
> 
> s/GPs/unnecessary GPs/?  Plus "." at end of the sentence.
> 
> > The exact flow seems to be something like:
> > 1. Callbacks are queued on CPU A - into the NEXT list.
> > 2. softirq runs on CPU A, accelerate all CBs from NEXT->WAIT and request a GP X.
> > 3. GP thread wakes up on another CPU, starts the GP X and requests QS from CPU A.
> > 4. CPU A's softirq runs again presumably because of #3.
> 
> Yes, that is one reason RCU softirq might run again.
> 
> > 5. CPU A's softirq now does acceleration again, this time no CBs are
> >    accelerated since last attempt, but it still requests GP X+1 which
> >    could be useless.
> 
> I can't think of a case where this request helps.  How about: "but
> it still unnecessarily requests GP X+1"?
> 
> > The fix is, prevent the useless GP start if we detect no CBs are there
> > to accelerate.
> > 
> > With this, we have the following improvement in short runs of
> > rcutorture (5 seconds each):
> > +----+-------------------+-------------------+
> > | #  | Number of GPs     | Number of Wakeups |
> > +====+=========+=========+=========+=========+
> > | 1  | With    | Without | With    | Without |
> > +----+---------+---------+---------+---------+
> > | 2  |      75 |      89 |     113 |     119 |
> > +----+---------+---------+---------+---------+
> > | 3  |      62 |      91 |     105 |     123 |
> > +----+---------+---------+---------+---------+
> > | 4  |      60 |      79 |      98 |     110 |
> > +----+---------+---------+---------+---------+
> > | 5  |      63 |      79 |      99 |     112 |
> > +----+---------+---------+---------+---------+
> > | 6  |      57 |      89 |      96 |     123 |
> > +----+---------+---------+---------+---------+
> > | 7  |      64 |      85 |      97 |     118 |
> > +----+---------+---------+---------+---------+
> > | 8  |      58 |      83 |      98 |     113 |
> > +----+---------+---------+---------+---------+
> > | 9  |      57 |      77 |      89 |     104 |
> > +----+---------+---------+---------+---------+
> > | 10 |      66 |      82 |      98 |     119 |
> > +----+---------+---------+---------+---------+
> > | 11 |      52 |      82 |      83 |     117 |
> > +----+---------+---------+---------+---------+
> 
> So the reductions in wakeups ranges from 5% to 40%, with almost a 20%
> overall reduction in wakeups across all the runs.  That should be of
> some use to someone.  ;-)
> 
> I do run rcutorture quite a bit, but is there a more real-world
> benchmark that could be tried?
> 
> > Cc: urezki@gmail.com
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

As discussed over IRC, I updated the patch as shown below.  Does that
work for you?

							Thanx, Paul

------------------------------------------------------------------------

commit ec037e1f438074eb16fd68a63d699fc419c9ba0c
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Thu Jun 18 16:29:49 2020 -0400

    rcu/segcblist: Prevent useless GP start if no CBs to accelerate
    
    The rcu_segcblist_accelerate() function returns true iff it is necessary
    to request another grace period.  A tracing session showed that this
    function unnecessarily requests grace periods.
    
    For exmaple, consider the following sequence of events:
    1. Callbacks are queued only on the NEXT segment of CPU A's callback list.
    2. CPU A runs RCU_SOFTIRQ, accelerating these callbacks from NEXT to WAIT.
    3. Thus rcu_segcblist_accelerate() returns true, requesting grace period N.
    4. RCU's grace-period kthread wakes up on CPU B and starts grace period N.
    4. CPU A notices the new grace period and invokes RCU_SOFTIRQ.
    5. CPU A's RCU_SOFTIRQ again invokes rcu_segcblist_accelerate(), but
       there are no new callbacks.  However, rcu_segcblist_accelerate()
       nevertheless (uselessly) requests a new grace period N+1.
    
    This extra grace period results in additional lock contention and also
    additional wakeups, all for no good reason.
    
    This commit therefore adds a check to rcu_segcblist_accelerate() that
    prevents the return of true when there are no new callbacks.
    
    This change reduces the number of grace periods (GPs) and wakeups in each
    of eleven five-second rcutorture runs as follows:
    
    +----+-------------------+-------------------+
    | #  | Number of GPs     | Number of Wakeups |
    +====+=========+=========+=========+=========+
    | 1  | With    | Without | With    | Without |
    +----+---------+---------+---------+---------+
    | 2  |      75 |      89 |     113 |     119 |
    +----+---------+---------+---------+---------+
    | 3  |      62 |      91 |     105 |     123 |
    +----+---------+---------+---------+---------+
    | 4  |      60 |      79 |      98 |     110 |
    +----+---------+---------+---------+---------+
    | 5  |      63 |      79 |      99 |     112 |
    +----+---------+---------+---------+---------+
    | 6  |      57 |      89 |      96 |     123 |
    +----+---------+---------+---------+---------+
    | 7  |      64 |      85 |      97 |     118 |
    +----+---------+---------+---------+---------+
    | 8  |      58 |      83 |      98 |     113 |
    +----+---------+---------+---------+---------+
    | 9  |      57 |      77 |      89 |     104 |
    +----+---------+---------+---------+---------+
    | 10 |      66 |      82 |      98 |     119 |
    +----+---------+---------+---------+---------+
    | 11 |      52 |      82 |      83 |     117 |
    +----+---------+---------+---------+---------+
    
    The reduction in the number of wakeups ranges from 5% to 40%.
    
    Cc: urezki@gmail.com
    [ paulmck: Rework commit log and comment. ]
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 9a0f661..2d2a6b6b9 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -475,8 +475,16 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * Also advance to the oldest segment of callbacks whose
 	 * ->gp_seq[] completion is at or after that passed in via "seq",
 	 * skipping any empty segments.
+	 *
+	 * Note that segment "i" (and any lower-numbered segments
+	 * containing older callbacks) will be unaffected, and their
+	 * grace-period numbers remain unchanged.  For example, if i ==
+	 * WAIT_TAIL, then neither WAIT_TAIL nor DONE_TAIL will be touched.
+	 * Instead, the CBs in NEXT_TAIL will be merged with those in
+	 * NEXT_READY_TAIL and the grace-period number of NEXT_READY_TAIL
+	 * would be updated.  NEXT_TAIL would then be empty.
 	 */
-	if (++i >= RCU_NEXT_TAIL)
+	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
 		return false;
 
 	/*
