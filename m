Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D4BEE6457
	for <rcu@archiver.kernel.org>; Fri, 15 Sep 2023 11:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjIOLdV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjIOLdU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Sep 2023 07:33:20 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE871B1
        for <rcu@vger.kernel.org>; Fri, 15 Sep 2023 04:33:14 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34961362f67so8002145ab.0
        for <rcu@vger.kernel.org>; Fri, 15 Sep 2023 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694777594; x=1695382394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Le4XGzd8MD4CHYbeES+YkYV/xna/OhuCHcjTmDaHTQ=;
        b=lwh5s9/8BeGtzSk8y5ueTlarfT9MrBrlWNYxwAUK8Zdn4nVKjZNHgFthgF2ok/LKXg
         i+06XE1gRitSSmhTV9Nr9WZA6mBfa2b0Imf716eFF53JMrxYTv40lZZh3FkPECFkC69e
         ctMLPl2vcRFGnfGYeTJAMDWz5Qz6HldCWjlOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694777594; x=1695382394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Le4XGzd8MD4CHYbeES+YkYV/xna/OhuCHcjTmDaHTQ=;
        b=Or61p33SDoRV7biNTQ+vOv3igyUgqEe8GcbtmIvLsBh1DxKV8PkVNTjj+QTalihRoz
         tjvbZtsm697YuS1/sYRmBf+Ow20/ojIGb902RkH+DObTPFuchF36wm8Se1kzD2ks5g+P
         Wp+Hya4J1uK19RXW2cqkdweHSqwvZYLYiJP9sVE99IAA06ym59BbfD/XRgFwfdIX6qEh
         9UaXBZtsgwq58GbrQIID7iodyTy9XBHjBXB0hm+NEs2g6zM+8q9BIKlRMHDiStqZ4gpV
         gXTCX+1ttSX/AntsplPTMq8vXk0KWpOuxaSBw+EWvk766A4mSxEuEiGiVvmTdq0Qjd7O
         Ik1w==
X-Gm-Message-State: AOJu0YzNY9Gr9yri4Zg63gXTe+YTfJDBzVfX5W613UarxYAggfmpnNqf
        ZuLE+AJ6iNQkaQ912w9C5MaVIeuqb1T6zuTVO/4=
X-Google-Smtp-Source: AGHT+IGEelthsNB4zRnm2essUX6l7jee97lR2XFdXK0ouz0SNcEAdaSnmJGNSfmbjtR3e+76JtvXkA==
X-Received: by 2002:a05:6e02:1529:b0:34f:14e5:5c89 with SMTP id i9-20020a056e02152900b0034f14e55c89mr4426909ilu.13.1694777594121;
        Fri, 15 Sep 2023 04:33:14 -0700 (PDT)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id z4-20020a056638000400b0042b70c5d242sm972176jao.116.2023.09.15.04.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 04:33:13 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:33:13 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <20230915113313.GA2909128@google.com>
References: <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
 <20230911022725.GA2542634@google.com>
 <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
 <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
 <fe78cd08-1b2c-4ab0-bbf7-8d324b4fa77f@paulmck-laptop>
 <20230914131351.GA2274683@google.com>
 <885bb95b-9068-45f9-ba46-3feb650a3c45@paulmck-laptop>
 <20230914185627.GA2520229@google.com>
 <20230914215324.GA1972295@google.com>
 <20230915001331.GA1235904@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230915001331.GA1235904@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 15, 2023 at 12:13:31AM +0000, Joel Fernandes wrote:
> On Thu, Sep 14, 2023 at 09:53:24PM +0000, Joel Fernandes wrote:
> > On Thu, Sep 14, 2023 at 06:56:27PM +0000, Joel Fernandes wrote:
> > > On Thu, Sep 14, 2023 at 08:23:38AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Sep 14, 2023 at 01:13:51PM +0000, Joel Fernandes wrote:
> > > > > On Thu, Sep 14, 2023 at 04:11:26AM -0700, Paul E. McKenney wrote:
> > > > > > On Wed, Sep 13, 2023 at 04:30:20PM -0400, Joel Fernandes wrote:
> > > > > > > On Mon, Sep 11, 2023 at 4:16 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > [..]
> > > > > > > > > I am digging deeper to see why the rcu_preempt thread cannot be pushed out
> > > > > > > > > and then I'll also look at why is it being pushed out in the first place.
> > > > > > > > >
> > > > > > > > > At least I have a strong repro now running 5 instances of TREE03 in parallel
> > > > > > > > > for several hours.
> > > > > > > >
> > > > > > > > Very good!  Then why not boot with rcutorture.onoff_interval=0 and see if
> > > > > > > > the problem still occurs?  If yes, then there is definitely some reason
> > > > > > > > other than CPU hotplug that makes this happen.
> > > > > > > 
> > > > > > > Hi Paul,
> > > > > > > So looks so far like onoff_interval=0 makes the issue disappear. So
> > > > > > > likely hotplug related. I am ok with doing the cpus_read_lock during
> > > > > > > boost testing and seeing if that fixes it. If it does, I can move on
> > > > > > > to the next thing in my backlog.
> > > > > > > 
> > > > > > > What do you think? Or should I spend more time root-causing it? It is
> > > > > > > most like runaway RT threads combined with the CPU hotplug threads,
> > > > > > > making scheduling of the rcu_preempt thread not happen. But I can't
> > > > > > > say for sure without more/better tracing (Speaking of better tracing,
> > > > > > > I am adding core-dump support to rcutorture, but it is not there yet).
> > > > > > 
> > > > > > This would not be the first time rcutorture has had trouble with those
> > > > > > threads, so I am for adding the cpus_read_lock().
> > > > > > 
> > > > > > Additional root-causing might be helpful, but then again, you might
> > > > > > have higher priority things to worry about.  ;-)
> > > > > 
> > > > > No worries. Unfortunately putting cpus_read_lock() around the boost test
> > > > > causes hangs. I tried something like the following [1]. If you have a diff, I can
> > > > > quickly try something to see if the issue goes away as well.
> > > > 
> > > > The other approaches that occur to me are:
> > > > 
> > > > 1.	Synchronize with the torture.c CPU-hotplug code.  This is a bit
> > > > 	tricky as well.
> > > > 
> > > > 2.	Rearrange the testing to convert one of the TREE0* scenarios that
> > > > 	is not in CFLIST (TREE06 or TREE08) to a real-time configuration,
> > > > 	with boosting but without CPU hotplug.	Then remove boosting
> > > > 	from TREE04.
> > > > 
> > > > Of these, #2 seems most productive.  But is there a better way?
> > > 
> > > We could have the gp thread at higher priority for TREE03. What I see
> > > consistently is that the GP thread gets migrated from CPU M to CPU N only to
> > > be immediately sent back. Dumping the state showed CPU N is running ksoftirqd
> > > which is also a rt priority 2.  Making rcu_preempt 3 and ksoftirqd 2 might
> > > give less of a run-around to rcu_preempt maybe enough to prevent the grace
> > > period from stalling. I am not sure if this will fix it, but I am running a
> > > test to see how it goes, will let you know.
> > 
> > That led to a lot of fireworks. :-) I am thinking though, do we really need
> > to run a boost kthread on all CPUs? I think that might be the root cause
> > because the boost threads run on all CPUs except perhaps the one dying.
> > 
> > We could run them on just the odd, or even ones and still be able to get
> > sufficient boost testing. This may be especially important without RT
> > throttling. I'll go ahead and queue a test like that.
> 
> Sorry if I am too noisy. So far only letting the rcutorture boost threads
> exist on odd CPUs, I am seeing the issue go away (but I'm running an extended
> test to confirm).
> 
> On the other hand, I came up with a real fix [1] and I am currently testing it.
> This is to fix a live lock between RT push and CPU hotplug's
> select_fallback_rq()-induced push. I am not sure if the fix works but I have
> some faith based on what I'm seeing in traces. Fingers crossed. I also feel
> the real fix is needed to prevent these issues even if we're able to hide it
> by halving the total rcutorture boost threads.

So that fixed it without any changes to RCU. Below is the updated patch also
for the archives. Though I'm rewriting it slightly differently and testing
that more. The main thing I am doing in the new patch is I find that RT
should not select !cpu_active() CPUs since those have the scheduler turned
off. Though checking for cpu_dying() also works. I could not find any
instance where cpu_dying() != cpu_active() but there could be a tiny window
where that is true. Anyway, I'll make some noise with scheduler folks once I
have the new version of the patch tested.

Also halving the number of RT boost threads makes it less likely to occur but
does not work. Not too surprising since the issue actually may not be related
to too many RT threads but rather a lockup between hotplug and RT..

---8<-----------------------

From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH] Fix livelock between RT and select_fallback_rq

Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/sched/rt.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e5074115..a089d6f24e5b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -526,6 +526,11 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 }
 #endif
 
+static inline bool rt_task_fits_in_cpu(struct task_struct *p, int cpu)
+{
+	return rt_task_fits_capacity(p, cpu) && !cpu_dying(cpu);
+}
+
 #ifdef CONFIG_RT_GROUP_SCHED
 
 static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
@@ -1641,14 +1646,14 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	       unlikely(rt_task(curr)) &&
 	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
 
-	if (test || !rt_task_fits_capacity(p, cpu)) {
+	if (test || !rt_task_fits_in_cpu(p, cpu)) {
 		int target = find_lowest_rq(p);
 
 		/*
 		 * Bail out if we were forcing a migration to find a better
 		 * fitting CPU but our search failed.
 		 */
-		if (!test && target != -1 && !rt_task_fits_capacity(p, target))
+		if (!test && target != -1 && !rt_task_fits_in_cpu(p, target))
 			goto out_unlock;
 
 		/*
@@ -1892,21 +1897,9 @@ static int find_lowest_rq(struct task_struct *task)
 	if (task->nr_cpus_allowed == 1)
 		return -1; /* No other targets possible */
 
-	/*
-	 * If we're on asym system ensure we consider the different capacities
-	 * of the CPUs when searching for the lowest_mask.
-	 */
-	if (sched_asym_cpucap_active()) {
-
-		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
+	ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
 					  task, lowest_mask,
-					  rt_task_fits_capacity);
-	} else {
-
-		ret = cpupri_find(&task_rq(task)->rd->cpupri,
-				  task, lowest_mask);
-	}
-
+					  rt_task_fits_in_cpu);
 	if (!ret)
 		return -1; /* No targets found */
 
-- 
2.42.0.459.ge4e396fd5e-goog

