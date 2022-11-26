Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E16C4321E
	for <rcu@archiver.kernel.org>; Sat, 26 Nov 2022 02:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiKZC2E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Nov 2022 21:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKZC2D (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Nov 2022 21:28:03 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBAF15814
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 18:28:01 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id cz18so3744667qvb.13
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 18:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tC95WUlQqltGbn75svGveITOFZ0cbWQP93hKcfG6lXI=;
        b=eOJiJlxhf07yKAobx+hxeDH526ePYbMuRfI+3vnAfg8Cs8feHiJq+o9/Og1MK93KuA
         iJWcvzzXu+cKE9VDkp7BSUaxhJXtBRrOV9P3OGvOR9EFZ51tUjiOiNu5ULRamOepUAL4
         mrqgutAjdAPX/HP5UvRiIST9+QP24bNizpvSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC95WUlQqltGbn75svGveITOFZ0cbWQP93hKcfG6lXI=;
        b=SLzWNBZ1xb5Na80E68hwYg1gZuFCnNPIScHdmGahSv/SxFJjBL0ygYPXNYq6XM+EnK
         vxr3jnanHA0INmRobsCAclCN/SN1NDhZz+UbG1YGb6AdDGFhSfP5uzPzsY0tGdotBeo+
         0fvZayvK7cPEcjDWxknu6lDfmx0zKKomk2NRP5RT+COTKYgkIcvoOPA/uF8LXeKBq+0c
         dlLOV7YFB3feFaT3fSV0lpHr5QE2RxarzznRuoiOQQni2OMmpKYRceQ+EczfhGlh6dhw
         Ygo59g+bKkkI+lVs+mbkYFdOQ9udSrne1ld4ZVrW+J7tuzoStPfb8RHqNWho9ab+fWdE
         tY8A==
X-Gm-Message-State: ANoB5pndJZjClfIs5f++evOw5ZnF+QRGQysolNTjIcs55/lHbVnEiUPb
        6oRIn3mjOHbfK5HKiqg5YjKBQQ==
X-Google-Smtp-Source: AA0mqf7SbVaovaX04rcpLX2PVZF/RB4yUUnxWGzONzeEFY/VE43dOzz5i71UWXlJlRsjLItIB01Fgg==
X-Received: by 2002:a05:6214:370e:b0:4c6:9c41:13b1 with SMTP id np14-20020a056214370e00b004c69c4113b1mr33008835qvb.44.1669429680447;
        Fri, 25 Nov 2022 18:28:00 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006fb11eee465sm3780588qkk.64.2022.11.25.18.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 18:27:59 -0800 (PST)
Date:   Sat, 26 Nov 2022 02:27:59 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Message-ID: <Y4F5r9nLDtCrl6df@google.com>
References: <20221125155427.1381933-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125155427.1381933-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 25, 2022 at 11:54:27PM +0800, Zqiang wrote:
> Currently, for the case of num_online_cpus() <= 1, return directly,
> indicates the end of current grace period and then release old data.
> it's not accurate, for SMP system, when num_online_cpus() is equal
> one, maybe another cpu that in offline process(after invoke
> __cpu_disable()) is still in the rude RCU-Tasks critical section
> holding the old data, this lead to memory corruption.
> 
> Therefore, this commit add cpus_read_lock/unlock() before executing
> num_online_cpus().

I am not sure if this is needed. The only way what you suggest can happen is
if the tasks-RCU protected data is accessed after the num_online_cpus() value is
decremented on the CPU going offline.

However, the number of online CPUs value is changed on a CPU other than the
CPU going offline.

So there's no way the CPU going offline can run any code (it is already
dead courtesy of CPUHP_AP_IDLE_DEAD). So a corruption is impossible.

Or, did I miss something?

thanks,

 - Joel



> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 4a991311be9b..08e72c6462d8 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *work)
>  {
>  }
>  
> +static DEFINE_PER_CPU(struct work_struct, rude_work);
> +
>  // Wait for one rude RCU-tasks grace period.
>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>  {
> +	int cpu;
> +	struct work_struct *work;
> +
> +	cpus_read_lock();
>  	if (num_online_cpus() <= 1)
> -		return;	// Fastpath for only one CPU.
> +		goto end;// Fastpath for only one CPU.
>  
>  	rtp->n_ipis += cpumask_weight(cpu_online_mask);
> -	schedule_on_each_cpu(rcu_tasks_be_rude);
> +	for_each_online_cpu(cpu) {
> +		work = per_cpu_ptr(&rude_work, cpu);
> +		INIT_WORK(work, rcu_tasks_be_rude);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(per_cpu_ptr(&rude_work, cpu));
> +
> +end:
> +	cpus_read_unlock();
>  }
>  
>  void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
> -- 
> 2.25.1
> 
