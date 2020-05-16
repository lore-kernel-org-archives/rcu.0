Return-Path: <SRS0=BJlB=66=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD82C433DF
	for <rcu@archiver.kernel.org>; Sat, 16 May 2020 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BE6206D4
	for <rcu@archiver.kernel.org>; Sat, 16 May 2020 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589649144;
	bh=7BUjCabPx6WoCwcfAvKuiYbT/eq0evFo0tCNOJ2KFsM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=CCfiptj7jFeBWH2yT4lk/fLOT2C92nB9KTa1uvP0ef9Pc/Ue8eWeSFnkdOu9fEkST
	 KQzi1Lspy/Si8fy0wpZFBMCtbqxA7a5MnQUqEtLysBCBl58NA756Z+krANZTCE4HUB
	 YGa3DzvSd7eD3ZVxrj5rG4y9f6eY0OXsgs7uhUIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgEPRMY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 16 May 2020 13:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgEPRMY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 16 May 2020 13:12:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2092065C;
        Sat, 16 May 2020 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589649143;
        bh=7BUjCabPx6WoCwcfAvKuiYbT/eq0evFo0tCNOJ2KFsM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JJk+NRs1XPcDLScVdcaOk7kheXGKiId/Gke6W0uGSSBCrwAHJM2Ty1N8rpgRzRUdk
         gG8Tyu0OhI5somHQWbjFl4ilsWabZ0//10pCHq3/aITEPfm67l3PkbJskG1QMXAcm6
         6vDmsyDosxt02PzG80CidglZdIUlA2myPiFUQ7os=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 37F4C3522CED; Sat, 16 May 2020 10:12:23 -0700 (PDT)
Date:   Sat, 16 May 2020 10:12:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Petr Mladek <pmladek@suse.com>,
        rcu@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        vpillai@digitalocean.com
Subject: Re: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
Message-ID: <20200516171223.GC2639@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200504120505.89351-1-joel@joelfernandes.org>
 <20200504171532.GR2869@paulmck-ThinkPad-P72>
 <20200504174413.GA8883@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504174413.GA8883@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 04, 2020 at 10:44:13AM -0700, Paul E. McKenney wrote:
> On Mon, May 04, 2020 at 10:15:32AM -0700, Paul E. McKenney wrote:
> > On Mon, May 04, 2020 at 08:05:00AM -0400, Joel Fernandes (Google) wrote:
> > > These patches clean up the usage of dynticks nesting counters simplifying the
> > > code, while preserving the usecases.
> > > 
> > > It is a much needed simplification, makes the code less confusing, and prevents
> > > future bugs such as those that arise from forgetting that the
> > > dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
> > > common situations.
> > > 
> > > rcutorture testing with all TREE RCU configurations succeed with
> > > CONFIG_RCU_EQS_DEBUG=y and CONFIG_PROVE_LOCKING=y.
> > > 
> > > v1->v2:
> > > - Rebase on v5.6-rc6
> > > 
> > > v2->v3:
> > > - Rebase on rcu/dev with adjustments for tasks-RCU.
> > 
> > Thank you!
> > 
> > But this does not apply to any of v5.6-rc6, v5.7-rc1, or v5.7-rc2.
> > 
> > Where should I be trying to apply it?
> 
> OK, morning blindness overcome.  I new see the "rcu/dev" in v2->v3.
> 
> Please accept my apologies for the noise.

And I have allegedly resolved the conflicts with Thomas's and Peter's
series, or at least the noinstr-rcu-nmi-2020-05-15 branch of that series.
At least one conflict was completely invisible to "git rebase" (but
fortunately blindingly obvious to the compiler).  This naturally makes
me suspect that additional adjustments might be needed.  Especially
given that misplaced instrumentation_begin() and instrumentation_end()
calls are invisible not only to the compiler, but also to rcutorture in
my setup.  (For example, tracing before instrumentation_begin() or after
instrumentation_end() is a bug.)

So could you please carefully check these commits?  They are now on the
-rcu tree's "dev" branch.

							Thanx, Paul
