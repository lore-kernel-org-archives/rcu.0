Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C913AC433FE
	for <rcu@archiver.kernel.org>; Mon, 14 Nov 2022 11:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiKNLnA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Nov 2022 06:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbiKNLm7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Nov 2022 06:42:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06C8B1F3;
        Mon, 14 Nov 2022 03:42:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79418B80E6E;
        Mon, 14 Nov 2022 11:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34C5C433C1;
        Mon, 14 Nov 2022 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426176;
        bh=cElhjJ0UR19yWolWrIUq1fZhpZ8tH9RoJkGIhEQZRQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9gaMol2HUKT1L22m5BZRxoi1h9nPDPpMFx5ZDhDOulmeg+Z/deLzREg8mmfxJS9+
         Y2Wrt/TR/p1VoLm1frDBIZkZOcnGzoR687kYZaSfsiWDukJd4JWzCezuE4oT3fViw0
         OLA3MC1VTVllu/z4WVyvm6AAouycxOcGD15s7B6hpc8xn+TqD5zn+Qeg/j09m5GvM8
         OLL5I9fwHJNAUJSTOkEpGYMYcq8bjyblWRI6AvPDDJt4KWPRY7UXJSnvwdzP15caXm
         POu201Wo+P1Klh3JYoVvQzx49tS3JO+KsXYTuwe/R2jTlSFTUwmWTnHs/A9ejgTMgc
         6IsDWrdasssCA==
Date:   Mon, 14 Nov 2022 12:42:52 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v7 2/6] sched: Add helper kstat_cpu_softirqs_sum()
Message-ID: <20221114114252.GA590078@lothringen>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111130709.247-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 11, 2022 at 09:07:05PM +0800, Zhen Lei wrote:
> Similar to kstat_cpu_irqs_sum(), it counts the sum of all software
> interrupts on a specified CPU.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  include/linux/kernel_stat.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> index 90e2fdc17d79ff8..898076e173a928a 100644
> --- a/include/linux/kernel_stat.h
> +++ b/include/linux/kernel_stat.h
> @@ -67,6 +67,17 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
>         return kstat_cpu(cpu).softirqs[irq];
>  }
>  
> +static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
> +{
> +	int i;
> +	unsigned int sum = 0;
> +
> +	for (i = 0; i < NR_SOFTIRQS; i++)
> +		sum += kstat_softirqs_cpu(i, cpu);

This should return a u64 or at least an unsigned long so that high
numbers of CPUs don't overflow easily.

Thanks.

> +
> +	return sum;
> +}
> +
>  /*
>   * Number of interrupts per specific IRQ source, since bootup
>   */
> -- 
> 2.25.1
> 
