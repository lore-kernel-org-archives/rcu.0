Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FDFC4321E
	for <rcu@archiver.kernel.org>; Sat, 26 Nov 2022 04:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKZEec (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Nov 2022 23:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiKZEeb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Nov 2022 23:34:31 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929ED1263F
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 20:34:26 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id x18so3815783qki.4
        for <rcu@vger.kernel.org>; Fri, 25 Nov 2022 20:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdWGgoppjAwlRY8F2+zs7StolKK3319MOyqp2+TCDOw=;
        b=SgzKK1rN9UUC2rhPboi8gHyl6+76bYhjv0uhfGIpIiYbRbHaI7YPuA0a2bvSSS0una
         uT1vd1Keq3WTEKiNInJwUYdb0iOh3fBLDbBxQ62deno1mTutw68jgmp85WVK0CsUT38n
         Vm/n86M90bAVAAzqxuW4lF6dBXUPp86HHwz1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdWGgoppjAwlRY8F2+zs7StolKK3319MOyqp2+TCDOw=;
        b=uEL1Opa9xzUQU6/j58hVm0cHT7WRv51wGTLlTsZyAY4H5rsjMIjZGp9tKribsydBFu
         4JdBlfT44RVBXFBdbklpNeJ21+mTSqXwM9rapMg7Y9sYFptM/rGO7qVOqDqheQJ3PRxf
         ERjPuYZuK7QzpNZJc4VgfowUqhDtyyk0SL0QbWlvwmwx7P3eo2LFfSW6bEUiejg8O4Uc
         PvtwPa7lfnQGwIY1xhl6a9NX7up46dUfDM/50Ga7wCA63ToCgjUwzaZBWh0yGXJfBDFL
         dsZF8Gmp1QsDhIAvUb/Byu04pIZEepJ8v8+ylY82BAqwznyN5SHOPCSAz+qk/gv7O4nH
         csnQ==
X-Gm-Message-State: ANoB5pkjE9q+6mvYTfVWkaddiu/LNBG0W7gy5TQ6qNtELJMUJ9QqtSH/
        +ZrL90U/MhnWzWBZgIv4I4Xx9w==
X-Google-Smtp-Source: AA0mqf4lpmAKcgNB3uDSP32hni7NpIXrHs1NZX77iAa+sJE7GQEV9oygtDncz5pO77t5PbAAlnZCOw==
X-Received: by 2002:a05:620a:90e:b0:6fb:c683:b74a with SMTP id v14-20020a05620a090e00b006fbc683b74amr36914475qkv.469.1669437265619;
        Fri, 25 Nov 2022 20:34:25 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bl38-20020a05620a1aa600b006fbb4b98a25sm3909457qkb.109.2022.11.25.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 20:34:25 -0800 (PST)
Date:   Sat, 26 Nov 2022 04:34:24 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        neeraj.iitr10@gmail.com,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Message-ID: <Y4GXUFn12oVkk/d8@google.com>
References: <20221125155427.1381933-1-qiang1.zhang@intel.com>
 <Y4F5r9nLDtCrl6df@google.com>
 <PH0PR11MB588009DA52C17BAE7388F99EDA119@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB588009DA52C17BAE7388F99EDA119@PH0PR11MB5880.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Nov 26, 2022 at 02:43:59AM +0000, Zhang, Qiang1 wrote:
> On Fri, Nov 25, 2022 at 11:54:27PM +0800, Zqiang wrote:
> > Currently, for the case of num_online_cpus() <= 1, return directly,
> > indicates the end of current grace period and then release old data.
> > it's not accurate, for SMP system, when num_online_cpus() is equal
> > one, maybe another cpu that in offline process(after invoke
> > __cpu_disable()) is still in the rude RCU-Tasks critical section
> > holding the old data, this lead to memory corruption.
> > 
> > Therefore, this commit add cpus_read_lock/unlock() before executing
> > num_online_cpus().
> 
> 
> >I am not sure if this is needed. The only way what you suggest can happen is
> >if the tasks-RCU protected data is accessed after the num_online_cpus() value is
> >decremented on the CPU going offline.
> >
> >However, the number of online CPUs value is changed on a CPU other than the
> >CPU going offline.
> >
> >So there's no way the CPU going offline can run any code (it is already
> >dead courtesy of CPUHP_AP_IDLE_DEAD). So a corruption is impossible.
> >
> >Or, did I miss something?
> 
> Hi joel
> 
> Suppose the system has two cpus
> 
> 	CPU0                                                                     CPU1
> 					     cpu_stopper_thread
>                                                                                   take_cpu_down
> 						    __cpu_disable
> 							dec __num_online_cpus 
>  rcu_tasks_rude_wait_gp                                      cpuhp_invoke_callback

Thanks for clarifying!

You are right, this can be a problem for anything in the stop machine on the
CPU going offline from CPUHP_AP_ONLINE to CPUHP_AP_IDLE_DEAD, during which
the code execute on that CPU is not accounted for in num_online_cpus().

Actually Neeraj found a similar issue 2 years ago and instead of hotplug
lock, he added a new attribute to rcu_state to track number of CPUs.

See:
https://lore.kernel.org/r/20200923210313.GS29330@paulmck-ThinkPad-P72
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2317853.html

Could we do something similar?

Off note is the comment in that thread:
  Actually blocking CPU hotplug would not only result in excessive overhead,
  but would also unnecessarily impede CPU-hotplug operations.

Neeraj is also on the thread and could chime in.

Thanks,

 - Joel


> 	num_online_cpus() == 1
> 		return;
>         
> when __num_online_cpus == 1, the CPU1 not completely offline.
> 
> Thanks
> Zqiang
> 
> >
> >thanks,
> >
> > - Joel
> 
> 
> 
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tasks.h | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 4a991311be9b..08e72c6462d8 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *work)
> >  {
> >  }
> >  
> > +static DEFINE_PER_CPU(struct work_struct, rude_work);
> > +
> >  // Wait for one rude RCU-tasks grace period.
> >  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> >  {
> > +	int cpu;
> > +	struct work_struct *work;
> > +
> > +	cpus_read_lock();
> >  	if (num_online_cpus() <= 1)
> > -		return;	// Fastpath for only one CPU.
> > +		goto end;// Fastpath for only one CPU.
> >  
> >  	rtp->n_ipis += cpumask_weight(cpu_online_mask);
> > -	schedule_on_each_cpu(rcu_tasks_be_rude);
> > +	for_each_online_cpu(cpu) {
> > +		work = per_cpu_ptr(&rude_work, cpu);
> > +		INIT_WORK(work, rcu_tasks_be_rude);
> > +		schedule_work_on(cpu, work);
> > +	}
> > +
> > +	for_each_online_cpu(cpu)
> > +		flush_work(per_cpu_ptr(&rude_work, cpu));
> > +
> > +end:
> > +	cpus_read_unlock();
> >  }
> >  
> >  void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
> > -- 
> > 2.25.1
> > 
