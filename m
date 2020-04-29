Return-Path: <SRS0=QSVt=6N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BB9C83000
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B7121D81
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588182475;
	bh=/qnzR5pVcRYlOZQWmIiyMjVEeHR1cy4NIm5vLkqBZ/w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KxZXZItnNBygKlKZ8NoqiNfdqWX+CoC4ENk7++MVYsR8f1WqLaRpx10EyZILOp8UQ
	 csrp6gzyZJBgu1JCcXtkWXTu9bDVvKU/KlVLnl58iSrYcenMRzlMhsa7w3GQMCoTjC
	 hAPT40/B+q6Ev7E/j+uXtfwvidufmx4lHhupBlTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD2Rrz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Rrz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Apr 2020 13:47:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC5EF21D7B;
        Wed, 29 Apr 2020 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588182475;
        bh=/qnzR5pVcRYlOZQWmIiyMjVEeHR1cy4NIm5vLkqBZ/w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CyiAhMSMcPYZRluWsKYjxGz8gYtsaqbXxNtI0MRhwq+Iq3XrskklAUIj3Agn7Ebrx
         aGqRrwwCYu+aDRlrjXVXHojbPCB+SN99s5oCKcPo4GtCQRXrQmXQ5LUs6kj/lvKzlI
         Rds1atySkVXb7twH5+WgrtBNBMOsnvO8Zx/oEFqo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CAA933522508; Wed, 29 Apr 2020 10:47:54 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:47:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     rcu@vger.kernel.org
Subject: Re: [bug report] rcutorture: Add races with task-exit processing
Message-ID: <20200429174754.GG7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200429132402.GD815283@mwanda>
 <20200429154421.GA7560@paulmck-ThinkPad-P72>
 <20200429174307.GC1992@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429174307.GC1992@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 29, 2020 at 08:43:07PM +0300, Dan Carpenter wrote:
> On Wed, Apr 29, 2020 at 08:44:21AM -0700, Paul E. McKenney wrote:
> > On Wed, Apr 29, 2020 at 04:24:02PM +0300, Dan Carpenter wrote:
> > > Hello Paul E. McKenney,
> > > 
> > > The patch e02882cd57e3: "rcutorture: Add races with task-exit
> > > processing" from Apr 24, 2020, leads to the following static checker
> > > warning:
> > > 
> > > 	kernel/rcu/rcutorture.c:2429 rcu_torture_read_exit()
> > > 	warn: 'rep' was already freed.
> > 
> > Ah, good catch, will fix!
> > 
> > > kernel/rcu/rcutorture.c
> > >   2369  static int rcu_torture_read_exit(void *unused)
> > >   2370  {
> > >   2371          int count = 0;
> > >   2372          bool errexit = false;
> > >   2373          int i;
> > >   2374          struct task_struct **rep;
> > >   2375          struct torture_random_state *trsp;
> > >   2376  
> > >   2377          // Allocate and initialize.
> > >   2378          set_user_nice(current, MAX_NICE);
> > >   2379          rep = kcalloc(read_exit, sizeof(*rep), GFP_KERNEL);
> > >   2380          trsp = kcalloc(read_exit, sizeof(*trsp), GFP_KERNEL);
> > >   2381          if (rep && trsp) {
> > >   2382                  for (i = 0; i < read_exit; i++)
> > >   2383                          torture_random_init(&trsp[i]);
> > >   2384                  VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of test");
> > >   2385          } else {
> > >   2386                  kfree(rep);
> > >                               ^^^
> > >   2387                  kfree(trsp);
> > >                               ^^^^
> > > Freed.
> > 
> > And setting both rep and trsp to NULL here takes care of this, correct?
> > As in kfree(NULL) is a no-op.  Or is your tool more strict?
> 
> Yes, yes.  Setting it to NULL works.  I thought about that, or returning
> and I wasn't sure which was prefered.

Ironically, what is likely to happen is restructuring the code to
eliminate the need for memory allocation.  The idea being to minimize
the time between RCU reader and kthread exit.

							Thanx, Paul
