Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4496BC43217
	for <rcu@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJMPkM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJMPkI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:08 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BFB15FDB
        for <rcu@vger.kernel.org>; Thu, 13 Oct 2022 08:39:46 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r19so1559080qtx.6
        for <rcu@vger.kernel.org>; Thu, 13 Oct 2022 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bJGejV+5UqqoOtNX772kflH+cMijJELmWVNopKE40M=;
        b=oE9CdTSv8+Xt0aYUhUqZN7FPDAmiV6BO2e5EUmbWXFQrvr/z970xWK2CqgaSd/+QYE
         JrDRu7XINubTWtVhVtkHw/o1XXNuE0nfdOnd3s7vKkwMEjLHvC2Rrwy4Q+Lz7mK4jUnU
         12pLlt9fkyYJofZE9hbVncfaACdNajt99AgAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bJGejV+5UqqoOtNX772kflH+cMijJELmWVNopKE40M=;
        b=oOrftJGU/L7n97WAmRFBaB2fUhMFfCr59kUy2WxkOhHK2qc8l7E5hCLpvqTAP6zy9l
         NPQ4us9eaHh9eu+LWTcNd2eOANp0l2az3fJZK3KO2/iwQAem091g2pggEyNExVFO2KLt
         +1DL3+gUJd1H3eeGiesF9K5G6xkQpaH1DtbZr5QY2rPf+ZRvf7NXQ0O/MawBctfyG0UV
         mscYEphSbZYn112H0FP7JiaIUQVJDQsE+a6DhFXwFjMNPlaJWoOhcFXRZO6nHHb66ENI
         ZO1m6Ai0/+hh2yWJe7Sue9CzwZW+aYxnaNMZI8ssxaGxuyqwBjBrWo3luPdLp1raYbS1
         nPOg==
X-Gm-Message-State: ACrzQf2H7NaVFu2gJf9UAQvRdfLzJbFv7+wS39yIMIgDTNmGpUSYJJsu
        4o3LmgjfqnfaMAiQA5Vl8fGoDg==
X-Google-Smtp-Source: AMsMyM4B7MUwdK3YxoHiFpH/xe+SP1fPnidaSr32FseB7PRrcV0pHh5JH3sByK3Cx8tqonj+uPiLeQ==
X-Received: by 2002:a05:622a:40d:b0:397:bd61:ef1d with SMTP id n13-20020a05622a040d00b00397bd61ef1dmr371643qtx.404.1665675586051;
        Thu, 13 Oct 2022 08:39:46 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d22-20020a376816000000b006ce0733caebsm42050qkc.14.2022.10.13.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:45 -0700 (PDT)
Date:   Thu, 13 Oct 2022 15:39:45 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix use __this_cpu_read() warning in preemptible
 code
Message-ID: <Y0gxQQzLdJLOp7wI@google.com>
References: <20221013044148.2894320-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013044148.2894320-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 13, 2022 at 12:41:48PM +0800, Zqiang wrote:
> BUG: using __this_cpu_read() in preemptible [00000000]
> code: rcu_torture_fqs/398
> caller is __this_cpu_preempt_check+0x13/0x20
> CPU: 3 PID: 398 Comm: rcu_torture_fqs Not tainted 6.0.0-rc1-yoctodev-standard+
> Call Trace:
> <TASK>
> dump_stack_lvl+0x5b/0x86
> dump_stack+0x10/0x16
> check_preemption_disabled+0xe5/0xf0
> __this_cpu_preempt_check+0x13/0x20
> rcu_force_quiescent_state.part.0+0x1c/0x170
> rcu_force_quiescent_state+0x1e/0x30
> rcu_torture_fqs+0xca/0x160
> ? rcu_torture_boost+0x430/0x430
> kthread+0x192/0x1d0
> ? kthread_complete_and_exit+0x30/0x30
> ret_from_fork+0x22/0x30
> </TASK>
> 
> When enable rcutorture.fqs_duration, the rcu_force_quiescent_state() be
> invoked in rcu_torture_fqs task context, invoke __this_cpu_read() in
> preemptible code section will trigger the above calltrace.

Makes sense, so in theory the GP thread might get migrated after sampling
rcu_data.mynode but that's Ok since it wont change the behavior of the code
following it AFAICS.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> This commit convert __this_cpu_read() to raw_cpu_read() to avoid
> this warning.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96d678c9cfb6..282002e62cf3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2436,7 +2436,7 @@ void rcu_force_quiescent_state(void)
>  	struct rcu_node *rnp_old = NULL;
>  
>  	/* Funnel through hierarchy to reduce memory contention. */
> -	rnp = __this_cpu_read(rcu_data.mynode);
> +	rnp = raw_cpu_read(rcu_data.mynode);
>  	for (; rnp != NULL; rnp = rnp->parent) {
>  		ret = (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) ||
>  		       !raw_spin_trylock(&rnp->fqslock);
> -- 
> 2.25.1
> 
