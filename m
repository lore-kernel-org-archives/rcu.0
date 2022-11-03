Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E45CC4332F
	for <rcu@archiver.kernel.org>; Thu,  3 Nov 2022 13:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiKCNgO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Nov 2022 09:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiKCNgN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Nov 2022 09:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF963D5
        for <rcu@vger.kernel.org>; Thu,  3 Nov 2022 06:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DFE761EB6
        for <rcu@vger.kernel.org>; Thu,  3 Nov 2022 13:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D7BC433D7;
        Thu,  3 Nov 2022 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667482571;
        bh=wNp9OyXE67p/Luqjik8n1jn5TboII2UTcY84rwy1sPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iP+lbzq+s1VlIBNn22QTbZiDDlU1ZWSHoaVai2a2oGSEar6EY3gCFacPlXBYjS93A
         N8KOORYkzOw7Rm3nxylBB9C6hdopOCNt5zLNujkhiarRa7yDPDFavhWc+zfqU7e2N2
         1UHRUp0MFJvTORMjbnpGmTDTGgFnX8S34C8/9QyxGy3qc3BVn7xGKhDNv20kGVMJot
         SlM3Jd2D283C+mfKyI7yipXZQB+zZ6H6PtM+PiZtuQzEoB3SyeD5JffOQVNF5lPwzv
         YIOTvgWIzdd0lafSZJs6O+RfbcCGIMZwgboNRpu5X7iXf+Xyu0mnbq1RrGcs5/O5/f
         O39N2ovwE6SSQ==
Date:   Thu, 3 Nov 2022 14:36:07 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] srcu: Fix a rare race issue in __srcu_read_(un)lock()
Message-ID: <20221103133607.GB1410480@lothringen>
References: <20221103131313.41536-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103131313.41536-1-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 03, 2022 at 09:13:13PM +0800, Pingfan Liu wrote:
> Clarify at first:
>   This issue is totally detected by code suspicion, not a real experience.
> 
> Scene:
> 
>   __srcu_read_(un)lock() uses percpu variable srcu_(un)lock_count[2].
> Normally, the percpu can help avoid the non-atomic RMW issue, but in
> some rare cases, it can not.
> 
> Supposing that __srcu_read_lock() runs on cpuX, the statement
>     this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> can be decomposed into two sub group:
>     -1. get the address of this_cpu_ptr(ssp->sda)->srcu_lock_count[idx],
> denoted as addressX and let unsigned long *pX = addressX;
>     -2. *pX = *pX + 1;

It's not supposed to happen:

* The weak version of this_cpu_inc() disables interrupts during the whole.
* x86 adds directly to gs/fs memory
* arm64, loongarch, s390 disable preemption

This has to be a fundamental constraint of this_cpu_*() ops implementation.

Thanks.



> 
> Now, assuming there are two tasks, denoted as taskA and taskB, three
> cpus, denoted as cpuX, cpuY and cpuZ. Let both taskA and taskB finish
> the first step as above on cpuX, but migrate to cpuY and cpuZ
> individually just before the second step. Then both of them continue to
> execute concurrently from the second step. This will raise a typical
> non-atomic RMW issue.
> 
> Solution:
> 
>   This issue can be tackled by disable preemption around the two sub
> groups.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: rcu@vger.kernel.org
> ---
>  kernel/rcu/srcutree.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1c304fec89c0..a38a3779dc01 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -636,7 +636,11 @@ int __srcu_read_lock(struct srcu_struct *ssp)
>  	int idx;
>  
>  	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> +	__preempt_count_inc();
> +	barrier();
>  	this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> +	barrier();
> +	__preempt_count_dec();
>  	smp_mb(); /* B */  /* Avoid leaking the critical section. */
>  	return idx;
>  }
> @@ -650,7 +654,11 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock);
>  void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
>  {
>  	smp_mb(); /* C */  /* Avoid leaking the critical section. */
> +	__preempt_count_inc();
> +	barrier();
>  	this_cpu_inc(ssp->sda->srcu_unlock_count[idx]);
> +	barrier();
> +	__preempt_count_dec();
>  }
>  EXPORT_SYMBOL_GPL(__srcu_read_unlock);
>  
> -- 
> 2.31.1
> 
