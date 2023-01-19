Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6B3C004D4
	for <rcu@archiver.kernel.org>; Thu, 19 Jan 2023 20:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjASUZ1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Jan 2023 15:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjASUZ0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Jan 2023 15:25:26 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59277E685
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 12:25:24 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id k4so3477332vsc.4
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 12:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNYsCT1OulNJOJ23TkVFfni9pow2SSxPZF4KOP4SuHc=;
        b=Vh+4tf70mqLqRxgxLcL9G2bXR4AwzNoYgWBS4WtTwgk83nwuC3Sbm58VFOk6qjj+jL
         deMZS/paX8VGjOhvNrxPKNKXyGVcPl2qjy+ho/sCacVuebffz36FUt1V/vkflciCskzH
         MxUVsb45C+pJZt5NhS4R741PCearHMlgnWFhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNYsCT1OulNJOJ23TkVFfni9pow2SSxPZF4KOP4SuHc=;
        b=ORpULG/EJ3mh3GZkTBA51gTnCkqscPWv69lj5y65cJWY93eCjznaY93ls6PCUvAppF
         bKLRa4Z4HVe42ZH4bDXMf5wduzFyV1iUvIi+myzfY78tNySaUlUGObveG9UvslX1DE8+
         O37+HPZSGjnGqMud3e1icEVZVPYpnBl/ZcZjPEauHqoI0QGa7bGOXtWntZiptEdW6V5I
         FGsmE2TouNrfFOOwKBrLpI5lq1fsenx6EisTLM2GNh56FhYFCwulteYNpqzPhINvDtzZ
         9cimNmyB7ZjQOCWI1dH0NlaASHo6APMHg9f3LiI5VqQoH9v/oL1P5vE84q+9d8uObErc
         9onw==
X-Gm-Message-State: AFqh2koRqAJbnNoSygKfOn+pZlqp0Tl70ej8CMujGXDlkIVIMVRwKNp0
        R6xPM6qENFp6fX1R4+Vx2RJH6w==
X-Google-Smtp-Source: AMrXdXtr9N5wNQPQDy+kNHCBAbxYeHE4XPqxGJ5eXHbBqy4Oul6EB1txRGoKJ5f9PUNq5DXGL94VGg==
X-Received: by 2002:a05:6102:7d1:b0:3d4:540:785a with SMTP id y17-20020a05610207d100b003d40540785amr7845982vsg.19.1674159923661;
        Thu, 19 Jan 2023 12:25:23 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b006bb82221013sm24544620qkb.0.2023.01.19.12.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 12:25:22 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:25:22 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Message-ID: <Y8mnMiIqA8EBsiCV@google.com>
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org>
 <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
 <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8h0lDnQ9Z0VtXfV@google.com>
 <Y8lMZ+E+pNKARLAf@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lMZ+E+pNKARLAf@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 19, 2023 at 02:57:59PM +0100, Frederic Weisbecker wrote:
> On Wed, Jan 18, 2023 at 10:37:08PM +0000, Joel Fernandes wrote:
> > 
> > That's a great idea. I found a way to do that without having to do the
> > EXPORT_SYMBOL (like in Zhouyi's patch).
> > 
> > Would the following be acceptable (only build-tested)?
> > 
> > I can run more tests and submit a patch:
> > 
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index 55405ebf23ab..f73bc520b70e 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
> >  bool cpu_is_hotpluggable(unsigned int cpu)
> >  {
> >  	struct device *dev = get_cpu_device(cpu);
> > -	return dev && container_of(dev, struct cpu, dev)->hotpluggable;
> > +	return dev && container_of(dev, struct cpu, dev)->hotpluggable
> > +		&& !tick_nohz_cpu_hotpluggable(cpu);
> >  }
> >  EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
> >  
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index bfd571f18cfd..9459fef5b857 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -216,6 +216,7 @@ extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
> >  				     enum tick_dep_bits bit);
> >  extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
> >  				       enum tick_dep_bits bit);
> > +extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
> >  
> >  /*
> >   * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
> > @@ -280,6 +281,7 @@ static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
> >  
> >  static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
> >  static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
> > +static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
> >  
> >  static inline void tick_dep_set(enum tick_dep_bits bit) { }
> >  static inline void tick_dep_clear(enum tick_dep_bits bit) { }
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 9c6f661fb436..d1cc7525240e 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -522,6 +522,11 @@ static int tick_nohz_cpu_down(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > +bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
> > +{
> > +	return tick_nohz_cpu_down(cpu) == 0;
> > +}
> > +
> 
> Can you make it the opposite? Have tick_nohz_cpu_down() call
> tick_nohz_cpu_hotpluggable()? To avoid future accidents.
> 
> Thanks.

You mean move the logic of tick_nohz_cpu_down() into
tick_nohz_cpu_hotpluggable()? That wont work because
tick_nohz_cpu_hotpluggable() returns a boolean, while tick_nohz_cpu_down(cpu)
returns an integer.

I could do something like the following and that should prevent the accident
you mentioned, which I think is that someone accidentally adds some code with
side-effects to tick_nohz_cpu_down() and ends up changing the behavior of
tick_nohz_cpu_hotpluggable(). Or was there a different accident you were
referring to?

I will submit a patch like the following, then. Thanks.

---8<-----------------------

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c98849577d4..7af8e33735a3 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
 bool cpu_is_hotpluggable(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
-	return dev && container_of(dev, struct cpu, dev)->hotpluggable;
+	return dev && container_of(dev, struct cpu, dev)->hotpluggable
+		&& tick_nohz_cpu_hotpluggable(cpu);
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
index ba2ac1469d47..6a2e52d5f0d0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -532,7 +532,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	tick_nohz_full_running = true;
 }
 
-static int tick_nohz_cpu_down(unsigned int cpu)
+static int tick_nohz_cpu_hotplug_ret(unsigned int cpu)
 {
 	/*
 	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
@@ -544,6 +544,16 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	return 0;
 }
 
+static int tick_nohz_cpu_down(unsigned int cpu)
+{
+	return tick_nohz_cpu_hotplug_ret(cpu);
+}
+
+bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
+{
+	return tick_nohz_cpu_hotplug_ret(cpu) == 0;
+}
+
 void __init tick_nohz_init(void)
 {
 	int cpu, ret;
-- 
2.39.0.246.g2a6d74b583-goog

