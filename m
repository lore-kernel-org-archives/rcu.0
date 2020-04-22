Return-Path: <SRS0=2A48=6G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B957C54FCB
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2819720776
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587572396;
	bh=61/yRnrk/28g15ZGFytP3M2QC8NNKUlwK7WBaKm5sUo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bgcj/KldkUHsmU29ySZRP3FCVJSM2jPRpW4fKBNjuHdkZWEAFLMzNf9hjxQAjqXsd
	 2j3i10lD7BKg0wLwYbZSQLkxhp9oPYi2+OxroWZVMdGu8NW9hK5RtLa2SAXwVL8yIO
	 ZGiQLg04UL//thdUff1wbIETnjydDvrtak8c3Q54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDVQT4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgDVQTz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Apr 2020 12:19:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B2A2076E;
        Wed, 22 Apr 2020 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587572395;
        bh=61/yRnrk/28g15ZGFytP3M2QC8NNKUlwK7WBaKm5sUo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EmObrqV+9bmomoVkaLSnF0Jx5QdxCCT0qVCPh/yLPQ+xXfjfqkKooaF5Smu2wCNQ0
         SGWGvDyZgNo6oVjLQ9EcfkyScXQPMjsSJN8AO3bDPmybEvEox32ap5MgT2yN2YrK4i
         d7TISh7DLMiBr9ghIRoZLCR4RrpHa4nVjjgfmFkk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1296E35203BC; Wed, 22 Apr 2020 09:19:55 -0700 (PDT)
Date:   Wed, 22 Apr 2020 09:19:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200422161955.GY17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200420165924.GA12078@pc636>
 <20200420172126.GG17661@paulmck-ThinkPad-P72>
 <20200420174019.GB12196@pc636>
 <20200421133947.cmdchrx73ru7szuz@linutronix.de>
 <20200421154101.GN17661@paulmck-ThinkPad-P72>
 <20200421170556.lvgb6gtjivjbr7gl@linutronix.de>
 <20200421180914.GT17661@paulmck-ThinkPad-P72>
 <20200422111324.cummbkw2faxoeaxk@linutronix.de>
 <20200422133346.GN17661@paulmck-ThinkPad-P72>
 <20200422154625.ub6xu5udlhtxsqdc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422154625.ub6xu5udlhtxsqdc@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 22, 2020 at 05:46:25PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-22 06:33:46 [-0700], Paul E. McKenney wrote:
> > On Wed, Apr 22, 2020 at 01:13:24PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-04-21 11:09:14 [-0700], Paul E. McKenney wrote:
> > > > > Yes but why do we do this raw_spinlock_t here? It is not yet needed on
> > > > > v5.6-RT as I *did* check. It also complicates the code for !RT but
> > > > > nobody responded to that part but…
> > > > 
> > > > I did respond by pointing out that the essentially similar call_rcu()
> > > > function ends up being invoked pretty much everywhere, including early
> > > > boot before rcu_init() has been invoked.  It is therefore only reasonable
> > > > to assume that there will be a need for kfree_rcu() to tolerate a similar
> > > > range of calling contexts.
> > > 
> > > Early in the boot we have IRQs disabled but also one CPU and no
> > > scheduling. That means that not a single lock is contained.
> > 
> > You are saying that call_rcu() is never invoked while holding a raw
> > spinlock?
> 
> I didn't say that. I said if you use spin_lock() with interrupts
> disabled *but* early in the boot process (without the scheduler active)
> then it is okay.
> This was a response to your "including early boot before …".
> But since you ask: On top of my head I know that
> task_struct is released via RCU by the scheduler in a preempt-disabled
> section. We have a similar workaround for the mm struct. So yes, we have
> at the very least those two.
> 
> > Fair enough, and thank you for checking!
> > 
> > The other work-queuing operations are also OK as they are, then?
> 
> yes.

Very good, and again, thank you!

							Thanx, Paul
