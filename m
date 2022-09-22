Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DE7C6FA86
	for <rcu@archiver.kernel.org>; Thu, 22 Sep 2022 09:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIVJ3n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Sep 2022 05:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIVJ3l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Sep 2022 05:29:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832EAA1B9
        for <rcu@vger.kernel.org>; Thu, 22 Sep 2022 02:29:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bh13so8582725pgb.4
        for <rcu@vger.kernel.org>; Thu, 22 Sep 2022 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=a8N8d4dED73OEJlQzGhQkUo7gZYaV9X+2SJYnMZ3eAo=;
        b=YwSWqokPHL+49+hy5E1hjGo9nDDpaeHuJNcuCCg4EoTiJ4CRVqSVlOkEnlP5X+vFja
         gzpVn9y+JQnh3q6dEEt9VUo7MVSgujZIEoY7tdeRgNBYKVQ16xQi6wdfNQ/WNoZCJtJX
         4dmWgg5Wc/hYHUN6vZBXdu0Q0GH7UzSwisLX/ZJJ3u33J7/MUmvpPpFFM6FTXk/84u+k
         jKp6tLy1qPEJlkpT6/Zh0eh6ETpMIqOjjJTLIgcMYV8uXyqUwteWnbAKVIvT6lbRCD5T
         /F8+13rcSn+V6nGdgnHdpXCnYczo1YBT8bOvA8Q4gVnuvcBDcDwgMhDh0pBGuPCxp/7i
         G7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a8N8d4dED73OEJlQzGhQkUo7gZYaV9X+2SJYnMZ3eAo=;
        b=afBDEY5bZ0xdqqSPyMCJJ9v0tA7ifUPxWNuI5J/iI//Axk8155eI4LQGtSj+QyBJmw
         4tur8nrOV+Tqats9IM0i099hC7EAt8tXX1f4rqabwZslAIt46+VC8UxtVCzF4W2EBXiW
         D6/OUY40aMAzc6iYaxs0oQ61YJYPBHQZKBfj1RfepUkpPZN97FEi814YVD72wuH9E50R
         WkEf9yFrb4w4oPfO6w3Mm6RAceG12SIr77Jpe4BHVntU9lHkZ/eJDLUWUGpdLSxOZgfe
         2rCt6FpfIhNm16Qm5hMosaYxJfiF3Ucvs37XhSGpFMXdJiGp6c5J5RgmS9JkyPXc1+eF
         Vd6g==
X-Gm-Message-State: ACrzQf3woC8T/MKJ23JqpET75h1CDR56D75QdNsIVbQCDyooqi0fs6VW
        EuSjrkHuPvZJOG+pww51/w==
X-Google-Smtp-Source: AMsMyM5RXe9yDmSzwrM1VO+F58GxD2fmRF319EpPYqYbtAds2IbieDTLQlK00/ZJVKe1wx4NmejbHg==
X-Received: by 2002:a63:cc4a:0:b0:439:1c48:2fed with SMTP id q10-20020a63cc4a000000b004391c482fedmr2277865pgi.618.1663838980026;
        Thu, 22 Sep 2022 02:29:40 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t3-20020aa79463000000b00553d573222fsm2620261pfq.199.2022.09.22.02.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:29:39 -0700 (PDT)
Date:   Thu, 22 Sep 2022 17:29:32 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen>
 <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen>
 <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 20, 2022 at 12:13:39PM -0700, Paul E. McKenney wrote:
> On Tue, Sep 20, 2022 at 11:46:45AM +0200, Frederic Weisbecker wrote:
> > On Tue, Sep 20, 2022 at 03:26:28PM +0800, Pingfan Liu wrote:
> > > On Fri, Sep 16, 2022 at 03:42:58PM +0200, Frederic Weisbecker wrote:
> > > > Note this is only locking the rdp's node, not the root node.
> > > > Therefore if CPU 0 and CPU 256 are going off at the same time and they
> > > > don't belong to the same node, the above won't protect against concurrent
> > > > TICK_DEP_BIT_RCU set/clear.
> > > > 
> > > 
> > > Nice, thanks for the careful thoughts. How about moving the counting
> > > place to the root node?
> > 
> > You could but then you'd need to lock the root node.
> > 
> > > > My suspicion is that we don't need this TICK_DEP_BIT_RCU tick dependency
> > > > anymore. I believe it was there because of issues that were fixed with:
> > > > 
> > > > 	53e87e3cdc15 (timers/nohz: Last resort update jiffies on nohz_full IRQ entry)
> > > > and:
> > > > 
> > > > 	a1ff03cd6fb9 (tick: Detect and fix jiffies update stall)
> > > > 
> > > > It's unfortunately just suspicion because the reason for that tick dependency
> > > > is unclear but I believe it should be safe to remove now.
> > > > 
> > > 
> > > I have gone through this tick dependency again, but got less.
> > > 
> > > I think at least from the RCU's viewpoint, it is useless since
> > > multi_cpu_stop()->rcu_momentary_dyntick_idle() has eliminate the
> > > requirement for tick interrupt.
> > 
> > Partly yes.
> > 
> > > Is there a way to have a convincing test so that these code can be removed?
> > > Or this code will be got along with?
> > 
> > Hmm, Paul might remember which rcutorture scenario would trigger it?
> 
> TREE04 on multisocket systems, preferably with faster CPU-hotplug
> operations.  This can be accomplished by adding this to the kvm.sh
> command line:
> 
> 	rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30
> 

Is it ok with "sh kvm.sh  --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs TREE04"

> It does take some time to run.  I did 4,000 hours worth of TREE04
                                        ^^^ '--duration=4000h' can serve this purpose?
Is it related with the cpu's freq?

> to confirm lack of bug.  But an 80-CPU dual-socket system can run
> 10 concurrent instances of TREE04, which gets things down to a more

The total demanded hours H = 4000/(system_cpu_num/8)?

> manageable 400 hours.  Please let me know if you don't have access
> to a few such systems.
>

I am happy to have a try if needed. I will try to get a powerful
machine, which can shrink the test time.

> I will let Frederic identify which commit(s) should be reverted in
> order to test the test.
> 

My understanding is after removing the tick dep by
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79aea7df4345..cbfc884f04a4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2171,8 +2171,6 @@ int rcutree_dead_cpu(unsigned int cpu)
        WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
        /* Adjust any no-longer-needed kthreads. */
        rcu_boost_kthread_setaffinity(rnp, -1);
-       // Stop-machine done, so allow nohz_full to disable tick.
-       tick_dep_clear(TICK_DEP_BIT_RCU);
        return 0;
 }

@@ -4008,8 +4006,6 @@ int rcutree_online_cpu(unsigned int cpu)
        sync_sched_exp_online_cleanup(cpu);
        rcutree_affinity_setting(cpu, -1);

-       // Stop-machine done, so allow nohz_full to disable tick.
-       tick_dep_clear(TICK_DEP_BIT_RCU);
        return 0;
 }

@@ -4031,8 +4027,6 @@ int rcutree_offline_cpu(unsigned int cpu)

        rcutree_affinity_setting(cpu, cpu);

-       // nohz_full CPUs need the tick for stop-machine to work quickly
-       tick_dep_set(TICK_DEP_BIT_RCU);
        return 0;
 }

If the TREE04 can success, then move on to revert the commit(s)
identified by Frederic, and do test again.

At this time, a TREE04 failure is expected.

If the above two results are observed, TICK_DEP_BIT_RCU can be
removed.

Is my understanding right?


Thanks,

	Pingfan
