Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D49AC433B4
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 00:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590E261184
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 00:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhETAf4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 May 2021 20:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhETAfz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 May 2021 20:35:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 414D961184;
        Thu, 20 May 2021 00:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621470875;
        bh=vM0rmIZYEhftmpGLJ0wW2b4mTDF87Ea5eJ0DqQxose4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CU4HA4zu+Vd0nnf7/w3Ozmn0H87GXQCCPOJc8EZ6YSN2cjDZnheRWF5kf+PagcdRE
         ZGZg86C08CXOuKrOg2Jm6vx3dJZyK0IEj42hdHXx+L2UNpULV3Q4S5+BorUGvUWR9Q
         HxmAtMEjY6gN9ZgrudQ9MAVhfZGZtAU/kY7ygEyE37Sg1Tq/oG/2NSSqdERrdIm9S3
         1f6RfXz+XcTsntVEhFLK8iFhfva2xT5Arplq98NCqB5vslh6jM/byRzAjndFnEkiXz
         tcor/N8Ww0qIZj8dnpd3lkS6MTeWsf9i6XFfNNGX36E0PvZP50B7XVmtp9D4JPmJrf
         G0LcbDSg1tQBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 11CEE5C0138; Wed, 19 May 2021 17:34:35 -0700 (PDT)
Date:   Wed, 19 May 2021 17:34:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 2/3] rcu/nocb: Remove NOCB deferred wakeup from
 rcutree_dead_cpu()
Message-ID: <20210520003435.GE4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210519000930.15702-1-frederic@kernel.org>
 <20210519000930.15702-3-frederic@kernel.org>
 <20210519155905.GY4441@paulmck-ThinkPad-P17-Gen-1>
 <20210520002553.GA22836@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520002553.GA22836@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 20, 2021 at 02:25:53AM +0200, Frederic Weisbecker wrote:
> On Wed, May 19, 2021 at 08:59:05AM -0700, Paul E. McKenney wrote:
> > On Wed, May 19, 2021 at 02:09:29AM +0200, Frederic Weisbecker wrote:
> > > At CPU offline time, we make sure to flush any pending wakeup for the
> > > nocb_gp kthread linked to the outgoing CPU.
> > > 
> > > Now we are making sure of that twice:
> > > 
> > > 1) From rcu_report_dead() when the outgoing CPU makes the very last
> > >    local cleanups by itself before switching offline.
> > > 
> > > 2) From rcutree_dead_cpu(). Here the offlining CPU has gone and is truly
> > >    now offline. Another CPU takes care of post-portem cleaning up and
> > >    check if the offline CPU had pending wakeup.
> > > 
> > > Both ways are fine but we have to choose one or the other because we
> > > don't need to repeat that action. Simply benefit from cache locality
> > > and keep only the first solution.
> > 
> > But between those two calls, the CPU takes a full pass through the
> > scheduler and heads into the idle loop.  What if there is a call_rcu()
> > along the way, and if this was the last online CPU in its rcuog kthread's
> > group of CPUs?  Wouldn't that callback be stranded until one of those
> > CPUs came back online?
> 
> Nope, rcu_report_dead() is called from the idle path right before
> arch_cpu_idle_dead(). There should be no call to the scheduler until the
> CPU comes back online.

You are of course correct.  I have pulled this one in as well, thank you!

							Thanx, Paul
