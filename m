Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724D7EEAA7D
	for <rcu@archiver.kernel.org>; Fri, 15 Sep 2023 00:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjIOANi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Sep 2023 20:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjIOANh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Sep 2023 20:13:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FA32102
        for <rcu@vger.kernel.org>; Thu, 14 Sep 2023 17:13:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7950fac19f2so58229239f.3
        for <rcu@vger.kernel.org>; Thu, 14 Sep 2023 17:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694736813; x=1695341613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B7TVWyI+f9n6het7cinZmQ752kh6BcAmp+a0ajOAQ30=;
        b=wMylBaMeDxdg3Q1BuWcJ2QP1U67QfMjcYWvNhwsiTXcTEDetH9uVHFD0UVvovh/KRx
         YCGsQg96sbGDqNwbwWcXoffg6c/n4YzXC/G5InvyIBBaWjPaahEXw1SZBMbvFgwmBDc7
         PkX4P1acJl9MZpPKS67akwd41DsnX8cBVkAI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694736813; x=1695341613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7TVWyI+f9n6het7cinZmQ752kh6BcAmp+a0ajOAQ30=;
        b=dSCWZtCsPI4uqmDe16h7FxxsY+ab866ChmnhJRk1F2tM35QIXTm3jKzOl6zc4TMqbP
         FYe4WaSw6Fmts7LF8OFQk5i68TKjW/dE6HzMa7D8n2WYt/X/XeNFl4orYTT+FnviVk0g
         TAqi2zQuvTlcLhW+916nAwmN+3RtPkwqQdbPCI5sf2EAI76jXsaMI8c/c9J64brlkn1/
         H+FxuvN2fR1oruQmZ+lQln4Nozfs/dUztLA6luF/mQzQcPThdxF2EiWKt/Fs1gpPokU+
         GCLJ9u1fED1AkFpfV+M4/MAvHJ6oVtfsocQpT+5xbDsgsZmZ7wtykG0tTEu7tnekJTi1
         IQGw==
X-Gm-Message-State: AOJu0YwhG6wYHwuzGCwrbSglV1Z4LUBmLVSTSi7ETYmPf5YIbpUNte+I
        Hq/xlK/a8TYxT4wPPPGeAHNugwag3LCIGv+Wxf8=
X-Google-Smtp-Source: AGHT+IG+MqAVD1KOQeC2en+UQBIZo5Wc6ndnyimnKNwXbsx1AwBhc4J/X5zdJ5J1Y9zY5NaMfxzELg==
X-Received: by 2002:a6b:dc0c:0:b0:780:d76c:b640 with SMTP id s12-20020a6bdc0c000000b00780d76cb640mr49329ioc.9.1694736813145;
        Thu, 14 Sep 2023 17:13:33 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id z25-20020a029f19000000b0042b929d3d2fsm749852jal.86.2023.09.14.17.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 17:13:32 -0700 (PDT)
Date:   Fri, 15 Sep 2023 00:13:31 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <20230915001331.GA1235904@google.com>
References: <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
 <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
 <20230911022725.GA2542634@google.com>
 <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
 <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
 <fe78cd08-1b2c-4ab0-bbf7-8d324b4fa77f@paulmck-laptop>
 <20230914131351.GA2274683@google.com>
 <885bb95b-9068-45f9-ba46-3feb650a3c45@paulmck-laptop>
 <20230914185627.GA2520229@google.com>
 <20230914215324.GA1972295@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914215324.GA1972295@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 14, 2023 at 09:53:24PM +0000, Joel Fernandes wrote:
> On Thu, Sep 14, 2023 at 06:56:27PM +0000, Joel Fernandes wrote:
> > On Thu, Sep 14, 2023 at 08:23:38AM -0700, Paul E. McKenney wrote:
> > > On Thu, Sep 14, 2023 at 01:13:51PM +0000, Joel Fernandes wrote:
> > > > On Thu, Sep 14, 2023 at 04:11:26AM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Sep 13, 2023 at 04:30:20PM -0400, Joel Fernandes wrote:
> > > > > > On Mon, Sep 11, 2023 at 4:16 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > [..]
> > > > > > > > I am digging deeper to see why the rcu_preempt thread cannot be pushed out
> > > > > > > > and then I'll also look at why is it being pushed out in the first place.
> > > > > > > >
> > > > > > > > At least I have a strong repro now running 5 instances of TREE03 in parallel
> > > > > > > > for several hours.
> > > > > > >
> > > > > > > Very good!  Then why not boot with rcutorture.onoff_interval=0 and see if
> > > > > > > the problem still occurs?  If yes, then there is definitely some reason
> > > > > > > other than CPU hotplug that makes this happen.
> > > > > > 
> > > > > > Hi Paul,
> > > > > > So looks so far like onoff_interval=0 makes the issue disappear. So
> > > > > > likely hotplug related. I am ok with doing the cpus_read_lock during
> > > > > > boost testing and seeing if that fixes it. If it does, I can move on
> > > > > > to the next thing in my backlog.
> > > > > > 
> > > > > > What do you think? Or should I spend more time root-causing it? It is
> > > > > > most like runaway RT threads combined with the CPU hotplug threads,
> > > > > > making scheduling of the rcu_preempt thread not happen. But I can't
> > > > > > say for sure without more/better tracing (Speaking of better tracing,
> > > > > > I am adding core-dump support to rcutorture, but it is not there yet).
> > > > > 
> > > > > This would not be the first time rcutorture has had trouble with those
> > > > > threads, so I am for adding the cpus_read_lock().
> > > > > 
> > > > > Additional root-causing might be helpful, but then again, you might
> > > > > have higher priority things to worry about.  ;-)
> > > > 
> > > > No worries. Unfortunately putting cpus_read_lock() around the boost test
> > > > causes hangs. I tried something like the following [1]. If you have a diff, I can
> > > > quickly try something to see if the issue goes away as well.
> > > 
> > > The other approaches that occur to me are:
> > > 
> > > 1.	Synchronize with the torture.c CPU-hotplug code.  This is a bit
> > > 	tricky as well.
> > > 
> > > 2.	Rearrange the testing to convert one of the TREE0* scenarios that
> > > 	is not in CFLIST (TREE06 or TREE08) to a real-time configuration,
> > > 	with boosting but without CPU hotplug.	Then remove boosting
> > > 	from TREE04.
> > > 
> > > Of these, #2 seems most productive.  But is there a better way?
> > 
> > We could have the gp thread at higher priority for TREE03. What I see
> > consistently is that the GP thread gets migrated from CPU M to CPU N only to
> > be immediately sent back. Dumping the state showed CPU N is running ksoftirqd
> > which is also a rt priority 2.  Making rcu_preempt 3 and ksoftirqd 2 might
> > give less of a run-around to rcu_preempt maybe enough to prevent the grace
> > period from stalling. I am not sure if this will fix it, but I am running a
> > test to see how it goes, will let you know.
> 
> That led to a lot of fireworks. :-) I am thinking though, do we really need
> to run a boost kthread on all CPUs? I think that might be the root cause
> because the boost threads run on all CPUs except perhaps the one dying.
> 
> We could run them on just the odd, or even ones and still be able to get
> sufficient boost testing. This may be especially important without RT
> throttling. I'll go ahead and queue a test like that.

Sorry if I am too noisy. So far only letting the rcutorture boost threads
exist on odd CPUs, I am seeing the issue go away (but I'm running an extended
test to confirm).

On the other hand, I came up with a real fix [1] and I am currently testing it.
This is to fix a live lock between RT push and CPU hotplug's
select_fallback_rq()-induced push. I am not sure if the fix works but I have
some faith based on what I'm seeing in traces. Fingers crossed. I also feel
the real fix is needed to prevent these issues even if we're able to hide it
by halving the total rcutorture boost threads.

[1]
---8<-----------------------

From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH] Fix livelock between RT and select_fallback_rq

Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/sched/rt.c | 4 ++--
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e5074115..b92aab35d7ec 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1945,7 +1945,7 @@ static int find_lowest_rq(struct task_struct *task)
 
 			best_cpu = cpumask_any_and_distribute(lowest_mask,
 							      sched_domain_span(sd));
-			if (best_cpu < nr_cpu_ids) {
+			if (best_cpu < nr_cpu_ids && !cpu_dying(best_cpu)) {
 				rcu_read_unlock();
 				return best_cpu;
 			}
@@ -1962,7 +1962,7 @@ static int find_lowest_rq(struct task_struct *task)
 		return this_cpu;
 
 	cpu = cpumask_any_distribute(lowest_mask);
-	if (cpu < nr_cpu_ids)
+	if (cpu < nr_cpu_ids && !cpu_dying(cpu))
 		return cpu;
 
 	return -1;
-- 
2.42.0.459.ge4e396fd5e-goog

