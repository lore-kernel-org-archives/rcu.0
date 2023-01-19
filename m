Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE9FC00A5A
	for <rcu@archiver.kernel.org>; Thu, 19 Jan 2023 13:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjASN6I (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Jan 2023 08:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjASN6F (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Jan 2023 08:58:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845C98A67
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 05:58:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07289616F6
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 13:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12483C43392;
        Thu, 19 Jan 2023 13:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674136682;
        bh=epbO/VybMvBMU2YFWAcNyutM/yOiKghht0mu5n9HyFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbqtyKipCFEz1meg/C62GcT9wXf2cWZ7VqY3dcDRqKhJ1GYal7pCvJCDAb58W8f/j
         FMqFpRjupf6a3D3KS+nwPZPuqxPRkJj7JO05sczig+wi8gR52HacjpHgGIr2reQXXD
         QOYSM+t5er6GERSmfRWEoE04Z4XxRajiLJcIrLDrpkA/o8ql2PiyRCQciHmP65+0kG
         ijQMGZdoKRxpp982xl9JSeZX8bnrhkLpx+P3HJIgTPDyTbja6mmNrkFxGMOv8mhA5k
         48cmHce44kQ137PGKyEVsd7wpJTuws/rOMdAYGBA7G5uXhQJa/p9Z5fPSA+5E4HJDp
         f/pe9a3KTwITw==
Date:   Thu, 19 Jan 2023 14:57:59 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Message-ID: <Y8lMZ+E+pNKARLAf@lothringen>
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org>
 <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
 <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8h0lDnQ9Z0VtXfV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8h0lDnQ9Z0VtXfV@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 18, 2023 at 10:37:08PM +0000, Joel Fernandes wrote:
> 
> That's a great idea. I found a way to do that without having to do the
> EXPORT_SYMBOL (like in Zhouyi's patch).
> 
> Would the following be acceptable (only build-tested)?
> 
> I can run more tests and submit a patch:
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 55405ebf23ab..f73bc520b70e 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
>  bool cpu_is_hotpluggable(unsigned int cpu)
>  {
>  	struct device *dev = get_cpu_device(cpu);
> -	return dev && container_of(dev, struct cpu, dev)->hotpluggable;
> +	return dev && container_of(dev, struct cpu, dev)->hotpluggable
> +		&& !tick_nohz_cpu_hotpluggable(cpu);
>  }
>  EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
>  
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index bfd571f18cfd..9459fef5b857 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -216,6 +216,7 @@ extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
>  				     enum tick_dep_bits bit);
>  extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
>  				       enum tick_dep_bits bit);
> +extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
>  
>  /*
>   * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
> @@ -280,6 +281,7 @@ static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
>  
>  static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
>  static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
> +static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
>  
>  static inline void tick_dep_set(enum tick_dep_bits bit) { }
>  static inline void tick_dep_clear(enum tick_dep_bits bit) { }
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 9c6f661fb436..d1cc7525240e 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -522,6 +522,11 @@ static int tick_nohz_cpu_down(unsigned int cpu)
>  	return 0;
>  }
>  
> +bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
> +{
> +	return tick_nohz_cpu_down(cpu) == 0;
> +}
> +

Can you make it the opposite? Have tick_nohz_cpu_down() call
tick_nohz_cpu_hotpluggable()? To avoid future accidents.

Thanks.


>  void __init tick_nohz_init(void)
>  {
>  	int cpu, ret;
> -- 
> 2.39.0.246.g2a6d74b583-goog
> 
