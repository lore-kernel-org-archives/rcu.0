Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA040C11F65
	for <rcu@archiver.kernel.org>; Wed, 30 Jun 2021 18:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2C861431
	for <rcu@archiver.kernel.org>; Wed, 30 Jun 2021 18:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhF3TAZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhF3TAZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Jun 2021 15:00:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B359AC061756
        for <rcu@vger.kernel.org>; Wed, 30 Jun 2021 11:57:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t17so7110691lfq.0
        for <rcu@vger.kernel.org>; Wed, 30 Jun 2021 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4ZsNrFdTKRSSU16xkBNQvyZH1A0US2Smt1DG8Rq3j8=;
        b=H3Gd1j8eTbiYOg+PUUTJVDmcyMEp7aGDn/EZhOEbBA1OZvnekKIA/KnOtwn79o6p8p
         B2DbtkJKB0NpRQNKJ7nOUFfTGwTDYfZmGRIjjP+X+eCtwnH7m/+htv47X6nFH2yYO/wF
         gxsFuFTJzoWwivl/JKIrxDypi7tiXUb322K7mbe0oTKSILWwVywMLQIQREiFBoF2VGO4
         lXqs0MTPoVDOLfhcHxUyQ81nYrv055G0xgoiJyIsrgLOQQrTloKzspPAFQZtxGNh1BBb
         syIl3/BGZ+asncQZVKLnEsMkSlT4V6OD0cuMmQADbQYxwGjB5P6YlzarqUnd4RCfLnnw
         aqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4ZsNrFdTKRSSU16xkBNQvyZH1A0US2Smt1DG8Rq3j8=;
        b=jXznrnsfUF+rrc1H7nJD1cCJPkAMYRzIcdL62Tck2nmgWz64mr6I6qI5Jp4D3kyfwh
         UUWG3Qur5RlWyuBkiHTzXDPP5nmQ/0xoMcQLD2J2FXLKAgXTebO/puIozoEsa7FNy/97
         lj7qtQpeJS2+04KXtw+zOLNlWxSPD9Yr5/JOtAxH50josorwUeFpabBn9bgMtZdiFZLP
         ODVmrm+4a/g2D2tuxXw1P4+8RrebeuwMYMM+9v8hJ8y06tKv3ebA4F2TPVS8hicAKeJ3
         HEWJp0yddF2FC16Q+hc8bqGf5DImBAKR3U7tOdvwtQraYlYVJ5LrHwMDOsHAJZ2MqDJU
         Bpvw==
X-Gm-Message-State: AOAM532G4FHE+nwD+qJODfegssHG7QOOBHMBEKNGcL+dkcPQ0rHLVk2K
        f/fQQkcrCF5U0YpqQWdYA00=
X-Google-Smtp-Source: ABdhPJxzPWPClgjTTVEbko35IqC9dj+wymz4/HJ3cwByi9v5bucAtvFcPfhWl5jrXlknfQmnqlcikA==
X-Received: by 2002:a05:6512:1088:: with SMTP id j8mr28913786lfg.67.1625079472951;
        Wed, 30 Jun 2021 11:57:52 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y8sm41335lfe.112.2021.06.30.11.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 11:57:52 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 30 Jun 2021 20:57:50 +0200
To:     Liu Song <fishland@aliyun.com>, paulmck@kernel.org
Cc:     paulmck@kernel.org, liu.song11@zte.com.cn, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Use per_cpu_ptr to get the pointer of per_cpu
 variable
Message-ID: <20210630185750.GA56532@pc638.lan>
References: <20210630140802.39138-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630140802.39138-1-fishland@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 30, 2021 at 10:08:02PM +0800, Liu Song wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> In rcu, most codes have used per_cpu_ptr to obtain per_cpu variable
> pointers. This patch adjusts a few codes that have not done so.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> ---
>  kernel/rcu/tasks.h      | 2 +-
>  kernel/rcu/tree.c       | 4 ++--
>  kernel/rcu/tree_stall.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 350ebf5051f9..0275217cb6e4 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -875,7 +875,7 @@ static void trc_read_check_handler(void *t_in)
>  	// Allow future IPIs to be sent on CPU and for task.
>  	// Also order this IPI handler against any later manipulations of
>  	// the intended task.
> -	smp_store_release(&per_cpu(trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
> +	smp_store_release(per_cpu_ptr(&trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
>  	smp_store_release(&texp->trc_ipi_to_cpu, -1); // ^^^
>  }
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8e78b2430c16..5cab8e39a731 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -399,7 +399,7 @@ bool rcu_eqs_special_set(int cpu)
>  	int old;
>  	int new;
>  	int new_old;
> -	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  
>  	new_old = atomic_read(&rdp->dynticks);
>  	do {
> @@ -1333,7 +1333,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>  	 */
>  	jtsq = READ_ONCE(jiffies_to_sched_qs);
>  	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
> -	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
> +	rnhqp = per_cpu_ptr(&rcu_data.rcu_need_heavy_qs, rdp->cpu);
>  	if (!READ_ONCE(*rnhqp) &&
>  	    (time_after(jiffies, rcu_state.gp_start + jtsq * 2) ||
>  	     time_after(jiffies, rcu_state.jiffies_resched) ||
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 59b95cc5cbdf..990fdb793d57 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -349,7 +349,7 @@ static void rcu_dump_cpu_stacks(void)
>  
>  static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
>  {
> -	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  
>  	sprintf(cp, "last_accelerate: %04lx/%04lx dyntick_enabled: %d",
>  		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
> -- 
> 2.20.1
> 
To me it looks OK.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
