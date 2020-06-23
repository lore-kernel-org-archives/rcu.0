Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97656C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754D0208C9
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 19:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tUR9PvFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbgFWTee (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbgFWTed (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 23 Jun 2020 15:34:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB03C061573
        for <rcu@vger.kernel.org>; Tue, 23 Jun 2020 12:34:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so14281817qts.5
        for <rcu@vger.kernel.org>; Tue, 23 Jun 2020 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1KH0rH4AzuBPYQeNW5blpz22/GCRUG77096zZyppVno=;
        b=tUR9PvFC3GgnpjVtmtnBBlPb+Ew1cd1NhAJa3TjHqvezwd9XwE4uo2OQ7hQISqZF0Y
         VxPD1iR1R6wecw9ysY6xSnD2CsciZsNd/4xhVH0YuKzKkU7hg9xwNNBJ83Adnz2YpmyP
         urm15SXUQpcsMuSrFBW7iZAunMQWLUzPHcPmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KH0rH4AzuBPYQeNW5blpz22/GCRUG77096zZyppVno=;
        b=BoZnvLZ3B2yUtPtceaxqGLjPivFKDtcADQvvAFifS0ZaSlZKW0JVYLoes7G1y0VoJ4
         K6iLnWGvX2yIXixpdiM0922nJsWlx9NAg+RmghtiRKNCBzlr5CTstMrd+jG3hEcH6XoZ
         vw53kk7kDHa/zj5NtCS1mQ3jp1UGO6FVtuDp906j3q77nLV1mZ6AmL06wDnDbGOR0NKb
         nQoakRbFQ+1LjcyjFF2f8RjU7+2EhJO4MGESqNNKwvfJWYvcwBv9uz9SPaUpC7tIfgyV
         dmpQzVAzopT5+QtMS77uHb+LFsU0be6XVEofYEm4GuQC9ztfk8k9VWZOaeFDf1PIrvc6
         /b8w==
X-Gm-Message-State: AOAM53124biv0bUcpxbwNW2CHp3WIksx8DZfHxq+zJE+R9jbzKpaUJ0o
        LT8apVCTEa4mwPFn5801Mka8bg==
X-Google-Smtp-Source: ABdhPJyODTmkyFeqdCWZE2FRa+eXXwdEG2dXmWJq2l+EEmDpeSfVft+TA5lSLgNAhYOl9TJtOShCIA==
X-Received: by 2002:ac8:4507:: with SMTP id q7mr21352369qtn.142.1592940872546;
        Tue, 23 Jun 2020 12:34:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v69sm1375392qkb.96.2020.06.23.12.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 12:34:31 -0700 (PDT)
Date:   Tue, 23 Jun 2020 15:34:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH tip/core/rcu 02/26] mm/mmap.c: Add cond_resched() for
 exit_mmap() CPU stalls
Message-ID: <20200623193431.GA68372@google.com>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
 <20200623002147.25750-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623002147.25750-2-paulmck@kernel.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 22, 2020 at 05:21:23PM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> A large process running on a heavily loaded system can encounter the
> following RCU CPU stall warning:
> 
>   rcu: INFO: rcu_sched self-detected stall on CPU
>   rcu: \x093-....: (20998 ticks this GP) idle=4ea/1/0x4000000000000002 softirq=556558/556558 fqs=5190
>   \x09(t=21013 jiffies g=1005461 q=132576)
>   NMI backtrace for cpu 3
>   CPU: 3 PID: 501900 Comm: aio-free-ring-w Kdump: loaded Not tainted 5.2.9-108_fbk12_rc3_3858_gb83b75af7909 #1
>   Hardware name: Wiwynn   HoneyBadger/PantherPlus, BIOS HBM6.71 02/03/2016
>   Call Trace:
>    <IRQ>
>    dump_stack+0x46/0x60
>    nmi_cpu_backtrace.cold.3+0x13/0x50
>    ? lapic_can_unplug_cpu.cold.27+0x34/0x34
>    nmi_trigger_cpumask_backtrace+0xba/0xca
>    rcu_dump_cpu_stacks+0x99/0xc7
>    rcu_sched_clock_irq.cold.87+0x1aa/0x397
>    ? tick_sched_do_timer+0x60/0x60
>    update_process_times+0x28/0x60
>    tick_sched_timer+0x37/0x70
>    __hrtimer_run_queues+0xfe/0x270
>    hrtimer_interrupt+0xf4/0x210
>    smp_apic_timer_interrupt+0x5e/0x120
>    apic_timer_interrupt+0xf/0x20
>    </IRQ>
>   RIP: 0010:kmem_cache_free+0x223/0x300
>   Code: 88 00 00 00 0f 85 ca 00 00 00 41 8b 55 18 31 f6 f7 da 41 f6 45 0a 02 40 0f 94 c6 83 c6 05 9c 41 5e fa e8 a0 a7 01 00 41 56 9d <49> 8b 47 08 a8 03 0f 85 87 00 00 00 65 48 ff 08 e9 3d fe ff ff 65
>   RSP: 0018:ffffc9000e8e3da8 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
>   RAX: 0000000000020000 RBX: ffff88861b9de960 RCX: 0000000000000030
>   RDX: fffffffffffe41e8 RSI: 000060777fe3a100 RDI: 000000000001be18
>   RBP: ffffea00186e7780 R08: ffffffffffffffff R09: ffffffffffffffff
>   R10: ffff88861b9dea28 R11: ffff88887ffde000 R12: ffffffff81230a1f
>   R13: ffff888854684dc0 R14: 0000000000000206 R15: ffff8888547dbc00
>    ? remove_vma+0x4f/0x60
>    remove_vma+0x4f/0x60
>    exit_mmap+0xd6/0x160
>    mmput+0x4a/0x110
>    do_exit+0x278/0xae0
>    ? syscall_trace_enter+0x1d3/0x2b0
>    ? handle_mm_fault+0xaa/0x1c0
>    do_group_exit+0x3a/0xa0
>    __x64_sys_exit_group+0x14/0x20
>    do_syscall_64+0x42/0x100
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> And on a PREEMPT=n kernel, the "while (vma)" loop in exit_mmap() can run
> for a very long time given a large process.  This commit therefore adds
> a cond_resched() to this loop, providing RCU any needed quiescent states.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <linux-mm@kvack.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  mm/mmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 59a4682..972f839 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3159,6 +3159,7 @@ void exit_mmap(struct mm_struct *mm)
>  		if (vma->vm_flags & VM_ACCOUNT)
>  			nr_accounted += vma_pages(vma);
>  		vma = remove_vma(vma);
> +		cond_resched();

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Just for my understanding, cond_resched_tasks_rcu_qs() may not help here
because preemption is not disabled right? Still I see no harm in using it
here either as it may give a slight speed up for tasks-RCU.

thanks,

 - Joel

>  	}
>  	vm_unacct_memory(nr_accounted);
>  }
> -- 
> 2.9.5
> 
