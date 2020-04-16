Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B331C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 17:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657212076D
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587058195;
	bh=9CG+wHfBpsjr7K/XdwZff0JWTD6/Z+EF3ohipVY8kOg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=lxcRH7MjRb9GVEXlZRaUnCtm2tf2Adp7YDTWkH7CkKc/tZbjDVyzDk7DGyuFuVL5b
	 i0YuraE330FOs9qqwO2T9DrNoRDLjNCP5FyMQXDmRn3k/V4fciNQhrZfiH9h2FOzNg
	 0wDsUNaCgehUNW9YAlm/OiJko87QKwKkSv9uC9H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgDPR3z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgDPR3y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 13:29:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B422063A;
        Thu, 16 Apr 2020 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587058193;
        bh=9CG+wHfBpsjr7K/XdwZff0JWTD6/Z+EF3ohipVY8kOg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JadGTwH7Y+xOrJF6tGYZVU11cCgi3aWygHxQRHp2/MNA8y7ZO7XKIAFAA9QRoBz7C
         HfEyBU+61tMHt5JuLHKO8L2OZH2y7ZERMoBMrtgm095mWntxgCCaJEgqadJa55uvwB
         PheRkFz9OIyOWD87Kel2CPW6QyKZJiRRz6OTxDUw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BCE7B35226A9; Thu, 16 Apr 2020 10:29:53 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:29:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416172953.GR17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416150038.GA7772@pc636>
 <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
 <20200416153844.GA8191@pc636>
 <20200416154647.ceotefna34pdxpfi@linutronix.de>
 <20200416160129.GA8337@pc636>
 <20200416161149.lkvkfwevanff36kb@linutronix.de>
 <20200416161819.GA8551@pc636>
 <20200416163302.3fsroillwk2om5dh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416163302.3fsroillwk2om5dh@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 06:33:02PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-16 18:18:19 [+0200], Uladzislau Rezki wrote:
> > On Thu, Apr 16, 2020 at 06:11:49PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-04-16 18:01:29 [+0200], Uladzislau Rezki wrote:
> > > > > As written in my previous email to Joel (who somehow fell of the Cc
> > > > > list in this part of the thread):
> > > > > |local_irq_save() + spin_lock() is the problem, see
> > > > > |    https://www.kernel.org/doc/html/latest/locking/locktypes.html#spinlock-t-and-rwlock-t
> > > > > 
> > > > You mean that in CONFIG_PREEMPT_RT:
> > > > 
> > > > <snip>
> > > >  local_irq_save(flags);
> > > >  krcp = this_cpu_ptr(&krc);
> > > >  spin_lock(&krcp->lock);
> > > > <snip>
> > > > 
> > > > it will not be preempted, what does not follow PREEMPT_RT policy. Is that correct?
> > > 
> > > No. local_irq_save() disables interrupts and spin_lock() acquires a
> > > sleeping lock which may schedule() if contended. The documentation has
> > > this piece:
> > >
> > Ah. Got it. Then it is a problem, agree. Do you have something
> > that would guarantee of being staying on the same CPU?
> > migration_disable()?
> 
> migrate_disable() would work.

Or moving to a raw spinlock, correct?

							Thanx, Paul
