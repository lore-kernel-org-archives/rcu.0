Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5690EC32793
	for <rcu@archiver.kernel.org>; Wed, 18 Jan 2023 22:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjARWhO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Jan 2023 17:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjARWhN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Jan 2023 17:37:13 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BA6233FE
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 14:37:11 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d16so150921qtw.8
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 14:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8nilPDHPTNTDsdy0as1344ajayaNhEwa9q313GGoo8=;
        b=Bho8E1plr/ocpXHVTvujLXsfY4hrvu6oX58J6SQ+NrBLrIN6gRFDOMfV8/FcLMPxal
         4M8s2QrijLuRykES/Ohudiv6Pv5ZnfkucJUjFos4kBkGtZYvzeTP/lL0oc1+7gyY4IT3
         +bUKBqM461ySYDVIVMf+sPSyDJliXYkZwmge4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8nilPDHPTNTDsdy0as1344ajayaNhEwa9q313GGoo8=;
        b=eSqnbiKMLlQz4ULqwJYJNXC/naHDoTxTv2SHenebp2rgpO8u0Mw94o27OUHPy/XFjk
         gIIQcPNY3yRm63d8+/bbqOg1FphAS/oe3zsAbEHVwQGU5ajN8n1yuXvp/DWxe65f5QO2
         +UNGt/2BXanEQwQyDHWujkN/Oz5cqRxmFIIFL5qh29N+KcSQuW/MWdDfcJ1aoeMYjDxs
         ZGnlyBPLrqzZ7IH6YLGfwORWVFO4Grs8U717ze3VW8XVb6yyrb6gzw+z38IihrjP655q
         sHv7vJSaO8GW4jxJVxyLXGxzHmC7xVhj0EVkYK3+NLYZodukvVyWnQheC38xIKligIM0
         Y+Ng==
X-Gm-Message-State: AFqh2krqUZL7y3K4KpxDJcKyqsp0qpC/oJG9djX/zmqSEKIeyGXNETOy
        +IO3ApPeEZXC5TXNC/zgVHZIkw==
X-Google-Smtp-Source: AMrXdXvTTJkmISBqPJxvnZwaAWKCdAocfGG7LX1HBRXrXsw3kIdSOqt9XiY8OCUZRFRbe0r4FcCMAQ==
X-Received: by 2002:ac8:6891:0:b0:3b0:8493:233a with SMTP id m17-20020ac86891000000b003b08493233amr11310881qtq.10.1674081430277;
        Wed, 18 Jan 2023 14:37:10 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id e13-20020ac84b4d000000b003b62cd6e60esm5908420qts.43.2023.01.18.14.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 14:37:09 -0800 (PST)
Date:   Wed, 18 Jan 2023 22:37:08 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Message-ID: <Y8h0lDnQ9Z0VtXfV@google.com>
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org>
 <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
 <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 17, 2023 at 08:00:58PM -0800, Paul E. McKenney wrote:
[...]
> > > > > Is there a plan to make CPU hotplug failures more frequent?
> > > >
> > > > I am not aware of such a plan but I was going by "There are quite some
> > > > reasons why a CPU-hotplug or a hot-unplug operation can fail, which is
> > > > not a fatal problem, really." in [1].
> > > >
> > > > What about an rcutorture to skip hotplug for a certain cpu id,
> > > > rcutorture.skip_hotplug_cpus="0". Can be a last resort. But we/I
> > > > should debug this issue more before getting to that.
> > >
> > > Yes, in fact there already are some checks along those lines, for example,
> > > the torture_offline() function's check of cpu_is_hotpluggable().  So for
> > > example, as I understand it, a CONFIG_NO_HZ_FULL=y system should mark
> > > the housekeeping CPU as !cpu_is_hotpluggable().
> > 
> > I don't think CONFIG_NO_HZ_FULL does any such marking (at least I am
> > not seeing it). Even on x86, if you enable
> > CONFIG_BOOTPARAM_HOTPLUG_CPU0=y , and CONFIG_NO_HZ_FULL=y, and run
> > rcutorture with boot args:
> > 
> > nohz_full=0-3 rcutorture.onoff_interval=100 rcutorture.onoff_holdoff=2
> > rcutorture.shutdown_secs=30
> > 
> > You will see this in the kernel logs:
> > [    2.816022] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > [    2.975913] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > 
> > So RCU torture test clearly thought the CPUs were hot-pluggable, when
> > they was chance for them to return -EBUSY (due to housekeeping and
> > what not). So this issue seems to be architecture independent, in that
> > sense.
> > 
> > So the 2 ways forward I see are:
> > - Make the torture test aware of which CPUs are 'house keeping'
> > - Make it possible to turn off CPU0 hotplugging on ARM64 by default
> > (via CONFIG or boot option).
> > 
> > Another option could be, forgive -EBUSY on CPU0 for
> > CONFIG_NO_HZ_FULL=y.  Is it possible to assign a non-0 CPU id as a
> > housekeeping CPU?
> 
> I would be happier to forgive failure to offline housekeeping CPUs than
> blanket forgiveness of CPU 0.  Especially given that I recently got
> burned by a non-zero boot cpu.  ;-)
> 
> But wouldn't it be even better for cpu_is_hotpluggable() to know the
> NO_HZ_FULL rules of the road?

That's a great idea. I found a way to do that without having to do the
EXPORT_SYMBOL (like in Zhouyi's patch).

Would the following be acceptable (only build-tested)?

I can run more tests and submit a patch:

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 55405ebf23ab..f73bc520b70e 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
 bool cpu_is_hotpluggable(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
-	return dev && container_of(dev, struct cpu, dev)->hotpluggable;
+	return dev && container_of(dev, struct cpu, dev)->hotpluggable
+		&& !tick_nohz_cpu_hotpluggable(cpu);
 }
 EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
 
diff --git a/include/linux/tick.h b/include/linux/tick.h
index bfd571f18cfd..9459fef5b857 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -216,6 +216,7 @@ extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
+extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
 
 /*
  * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
@@ -280,6 +281,7 @@ static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
 static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
+static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
 
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9c6f661fb436..d1cc7525240e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -522,6 +522,11 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	return 0;
 }
 
+bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
+{
+	return tick_nohz_cpu_down(cpu) == 0;
+}
+
 void __init tick_nohz_init(void)
 {
 	int cpu, ret;
-- 
2.39.0.246.g2a6d74b583-goog

