Return-Path: <SRS0=QSVt=6N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCBDC83000
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 15:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95D42073E
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588175062;
	bh=chkVjbPCAioBMxgoybr6lcWrrf28wRwLranO7g1Jbkw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=DVkCnmTXdYmY1DtPe/BooMh42qyBbaD4T+1LcVE5WUN2mlMeeSYsCGj1u7QUbiMVa
	 sOk6vxNQTcrTT45uyHsVsnOr5jHO9CYWNpXNBHxeWEI4o5I7K182rIgFlsvb2sbiKF
	 nwSNRRUMefJAu1YKQFbXb4CWow2GhP9gP470UwcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD2PoW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2PoW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Apr 2020 11:44:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A2B2072A;
        Wed, 29 Apr 2020 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588175061;
        bh=chkVjbPCAioBMxgoybr6lcWrrf28wRwLranO7g1Jbkw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dEzeEUn9jomQALFoNfYq19mhjCWsp/HQcg0wTwnMxS+y5QUmLFBj9yKGy6USec+lK
         qPzOGyI7B+5/M9ij6JgQLqpQb0rQrJU/TstHBrykd8/EwpGCSNEQPcHp9qiFS/3wez
         c37RSDdE7+KBnBCXba4gHbXOOYNG9wmvbJz9Mc8Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ABF5B35226DB; Wed, 29 Apr 2020 08:44:21 -0700 (PDT)
Date:   Wed, 29 Apr 2020 08:44:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     rcu@vger.kernel.org
Subject: Re: [bug report] rcutorture: Add races with task-exit processing
Message-ID: <20200429154421.GA7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200429132402.GD815283@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429132402.GD815283@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 29, 2020 at 04:24:02PM +0300, Dan Carpenter wrote:
> Hello Paul E. McKenney,
> 
> The patch e02882cd57e3: "rcutorture: Add races with task-exit
> processing" from Apr 24, 2020, leads to the following static checker
> warning:
> 
> 	kernel/rcu/rcutorture.c:2429 rcu_torture_read_exit()
> 	warn: 'rep' was already freed.

Ah, good catch, will fix!

> kernel/rcu/rcutorture.c
>   2369  static int rcu_torture_read_exit(void *unused)
>   2370  {
>   2371          int count = 0;
>   2372          bool errexit = false;
>   2373          int i;
>   2374          struct task_struct **rep;
>   2375          struct torture_random_state *trsp;
>   2376  
>   2377          // Allocate and initialize.
>   2378          set_user_nice(current, MAX_NICE);
>   2379          rep = kcalloc(read_exit, sizeof(*rep), GFP_KERNEL);
>   2380          trsp = kcalloc(read_exit, sizeof(*trsp), GFP_KERNEL);
>   2381          if (rep && trsp) {
>   2382                  for (i = 0; i < read_exit; i++)
>   2383                          torture_random_init(&trsp[i]);
>   2384                  VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of test");
>   2385          } else {
>   2386                  kfree(rep);
>                               ^^^
>   2387                  kfree(trsp);
>                               ^^^^
> Freed.

And setting both rep and trsp to NULL here takes care of this, correct?
As in kfree(NULL) is a no-op.  Or is your tool more strict?

							Thanx, Paul

>   2388                  errexit = true;
>   2389                  VERBOSE_TOROUT_ERRSTRING("out of memory");
>   2390          }
>   2391  
>   2392          // Each pass through this loop does one read-exit episode.
>   2393          while (!errexit && ! READ_ONCE(read_exit_child_stop)) {
>   2394                  if (++count > read_exit_burst) {
>   2395                          VERBOSE_TOROUT_STRING("rcu_torture_read_exit: End of episode");
>   2396                          schedule_timeout_uninterruptible(HZ * read_exit_delay);
>   2397                          VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of episode");
>   2398                          count = 0;
>   2399                  }
>   2400                  // Spawn children.
>   2401                  for (i = 0; i < read_exit && i <= num_online_cpus(); i++) {
>   2402                          // We don't want per-child console messages.
>   2403                          rep[i] = kthread_run(rcu_torture_read_exit_child,
>   2404                                               &trsp[i], "%s",
>   2405                                               "rcu_torture_read_exit_child");
>   2406                          if (IS_ERR(rep[i])) {
>   2407                                  VERBOSE_TOROUT_ERRSTRING("out of memory");
>   2408                                  errexit = true;
>   2409                                  rep[i] = NULL;
>   2410                                  break;
>   2411                          }
>   2412                          cond_resched();
>   2413                  }
>   2414                  n_read_exits += i;
>   2415                  // Reap children.
>   2416                  for (i--; i >= 0; i--) {
>   2417                          kthread_stop(rep[i]);
>   2418                          rep[i] = NULL;
>   2419                          cond_resched();
>   2420                  }
>   2421                  rcu_barrier(); // Wait for task_struct freeing, avoid OOM.
>   2422                  stutter_wait("rcu_torture_read_exit");
>   2423          }
>   2424  
>   2425          // Clean up and exit.
>   2426          smp_store_release(&read_exit_child_stopped, true); // After reaping.
>   2427          smp_mb(); // Store before wakeup.
>   2428          wake_up(&read_exit_wq);
>   2429          kfree(rep);
>                       ^^^
>   2430          kfree(trsp);
>                       ^^^^
> Double freed.
> 
>   2431          while (!torture_must_stop())
>   2432                  schedule_timeout_uninterruptible(1);
>   2433          torture_kthread_stopping("rcu_torture_read_exit");
>   2434          return 0;
>   2435  }
> 
> regards,
> dan carpenter
