Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C8C0032E
	for <rcu@archiver.kernel.org>; Wed, 25 Oct 2023 10:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjJYKcM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Oct 2023 06:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJYKcL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Oct 2023 06:32:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F88CB0;
        Wed, 25 Oct 2023 03:32:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0125C433C7;
        Wed, 25 Oct 2023 10:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698229929;
        bh=qnhvyqAbScSS7DqI8YnTAhrhFJz18xmcGfOkvSOx8uI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeDt6GO+aB5o6rgyqhj8iGGgm6X0jZ0PWiY4RQQs80zxh434h52VIl0NHFPwMKgqP
         1Ki+/SLLEMdR6iK/GA7vyg0ETid+qkr4WBp8npcjZSf8PkF6Sblsi8iqieLk6uqx41
         6TxIzHFK2q1OyO5ta8usXHN+atCc83yzbr2RanJIRilrvEcg3zD8ZIIDXavj1nM54d
         JrBtloWJt5EZx7iPqJW8eArnbvTGZJ6obUTFgYFxixdkGQoC29lvsv5uqaFk5jkSNT
         gq614zH2sZsHHLoiv3YBNDweET5lmwoIlR7a7w3Lgrz+si6qyrKFsLgzqzfF9vvZZ5
         7IRkJ7o8VrR0g==
Date:   Wed, 25 Oct 2023 12:32:05 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] rcu: Introduce rcu_cpu_online()
Message-ID: <ZTjupRkA9Ce6Dv4p@localhost.localdomain>
References: <20231024214625.6483-1-frederic@kernel.org>
 <20231024214625.6483-2-frederic@kernel.org>
 <CALm+0cVP+4ogirqUYMXp63vb7yisXCB0xpq+DSX9kqth0BpW6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cVP+4ogirqUYMXp63vb7yisXCB0xpq+DSX9kqth0BpW6g@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Wed, Oct 25, 2023 at 10:29:46AM +0800, Z qiang a écrit :
> >
> > Export the RCU point of view as to when a CPU is considered offline
> > (ie: when does RCU consider that a CPU is sufficiently down in the
> > hotplug process to not feature any possible read side).
> >
> > This will be used by RCU-tasks whose vision of an offline CPU should
> > reasonably match the one of RCU core.
> >
> > Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/rcu.h  | 2 ++
> >  kernel/rcu/tree.c | 7 +++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 0d866eaa4cc8..b531c33e9545 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -500,6 +500,7 @@ static inline void rcu_expedite_gp(void) { }
> >  static inline void rcu_unexpedite_gp(void) { }
> >  static inline void rcu_async_hurry(void) { }
> >  static inline void rcu_async_relax(void) { }
> > +static inline bool rcu_cpu_online(int cpu) { return true; }
> >  #else /* #ifdef CONFIG_TINY_RCU */
> >  bool rcu_gp_is_normal(void);     /* Internal RCU use. */
> >  bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
> > @@ -509,6 +510,7 @@ void rcu_unexpedite_gp(void);
> >  void rcu_async_hurry(void);
> >  void rcu_async_relax(void);
> >  void rcupdate_announce_bootup_oddness(void);
> > +bool rcu_cpu_online(int cpu);
> >  #ifdef CONFIG_TASKS_RCU_GENERIC
> >  void show_rcu_tasks_gp_kthreads(void);
> >  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 700524726079..fd21c1506092 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4202,6 +4202,13 @@ static bool rcu_rdp_cpu_online(struct rcu_data *rdp)
> >         return !!(rdp->grpmask & rcu_rnp_online_cpus(rdp->mynode));
> >  }
> >
> > +bool rcu_cpu_online(int cpu)
> > +{
> > +       struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >
> >
> 
> Should 'struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu)' be used ?

Oh! Good catch!

> 
> Thanks
> Zqiang
> 
> 
> >
> > +
> > +       return rcu_rdp_cpu_online(rdp);
> > +}
> > +
> >  #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU)
> >
> >  /*
> > --
> > 2.41.0
> >
