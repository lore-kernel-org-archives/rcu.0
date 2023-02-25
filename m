Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45022C7EE2D
	for <rcu@archiver.kernel.org>; Sat, 25 Feb 2023 03:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBYDwG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 24 Feb 2023 22:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBYDwF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 24 Feb 2023 22:52:05 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA743CE13
        for <rcu@vger.kernel.org>; Fri, 24 Feb 2023 19:52:03 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id ne1so852834qvb.9
        for <rcu@vger.kernel.org>; Fri, 24 Feb 2023 19:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cap6xQmPHBvjdcGeJlJgWFVVJbClgYrfp7t39LtrF10=;
        b=XzWLptnZrEVRXTWiip1QZK5SNab05B4ViV/MHphKcdm1qEDqPtl0ULDGgHFGqDKoRf
         LIWs5S/dqqr7K/beBw/uol4k1Twv00poy2W7nKrzBzwFNDjdLzj2ldq7ZSCam1rI0dcu
         0+rfdDoDnAHmKhPZGrfaRAWBeZYrFGuP5UQbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cap6xQmPHBvjdcGeJlJgWFVVJbClgYrfp7t39LtrF10=;
        b=gk6jTocsO4yzWycWda+DJhSdruHr4cWl8LhS2g+cTbCswGyKy8PMFD5KGqPKn4s1qp
         /6hMnNbTOlyZ4ds87o6sINud/vZHp+LawpVYkJqp1IZSQdesu4Jvahi02livSVZVpwhZ
         DppTEr0n021M+YhiX7t+TswIOusJtLdc5CjiR/ZehxeTAn1VwJzIRfiVJGU2G8J9YXwm
         489OXcAg21KGVNapPHZy9+X0ebewpgqu72FTRiAYUW/CVEHLvxgqGJCaeBMhG7rhL7x3
         NJ2R3eu5gs8WFYbKp2gXfPF5zlhWhRTtvJqo/zR9KZD6CHDeDawFgUYvxp0GwVE2ruIR
         bxTw==
X-Gm-Message-State: AO0yUKVUmZPb9glKe+MGCE583WQmvx3BGvlOxLS7efWg7R19b0jomike
        yjoLWwQgJFjcfXPPlemmkcXYXA==
X-Google-Smtp-Source: AK7set9klPrxVLtnJeCkqo/NcTxcHxt7v1frYZ4tbtKKoY81dE4qHovzL22x87PWMxg/WuYIlvIPpw==
X-Received: by 2002:a05:6214:e6d:b0:56c:2344:a58b with SMTP id jz13-20020a0562140e6d00b0056c2344a58bmr3726321qvb.12.1677297122827;
        Fri, 24 Feb 2023 19:52:02 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s62-20020a372c41000000b0071eddd3bebbsm546510qkh.81.2023.02.24.19.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 19:52:02 -0800 (PST)
Date:   Sat, 25 Feb 2023 03:52:01 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [PATCH RFC] rcu: Add a minimum time for marking boot as completed
Message-ID: <Y/mF4RXV85eV6zWq@google.com>
References: <20230225032716.3320124-1-joel@joelfernandes.org>
 <ea03e810-95f0-abd8-2a83-f83174a99dbf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea03e810-95f0-abd8-2a83-f83174a99dbf@infradead.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 24, 2023 at 07:32:22PM -0800, Randy Dunlap wrote:
> Hi--
> 
> On 2/24/23 19:27, Joel Fernandes (Google) wrote:
> > On many systems, a great deal of boot happens after the kernel thinks the boot
> > has completed. It is difficult to determine if the system has really booted
> > from the kernel side. Some features like lazy-RCU can risk slowing down boot
> > time if, say, a callback has been added that the boot synchronously depends on.
> > 
> > Further, it is better to boot systems which pass 'rcu_normal_after_boot' to
> > stay expedited for as long as the system is still booting.
> > 
> > For these reasons, this commit adds a config option
> > 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_delay.
> > 
> > By default, this value is 20s. A system designer can choose to specify a value
> > here to keep RCU from marking boot completion.  The boot sequence will not be
> > marked ended until at least boot_end_delay milliseconds have passed.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  4 +++
> >  kernel/rcu/Kconfig                            | 12 +++++++++
> >  kernel/rcu/update.c                           | 25 +++++++++++++++++--
> >  3 files changed, 39 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 2429b5e3184b..0943139fdf01 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5085,6 +5085,10 @@
> >  	rcutorture.verbose= [KNL]
> >  			Enable additional printk() statements.
> >  
> > +	rcupdate.boot_end_delay= [KNL]
> 
> Tell units:
> 
> > +			Minimum time that must elapse before the boot
> 

Fixed.

> +			Minimum time in milliseconds that must elapse before the boot
> 
> > +			sequence can be marked as completed.
> > +
> >  	rcupdate.rcu_cpu_stall_ftrace_dump= [KNL]
> >  			Dump ftrace buffer after reporting RCU CPU
> >  			stall warning.
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 9071182b1284..1033a38bddad 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -217,6 +217,18 @@ config RCU_BOOST_DELAY
> >  
> >  	  Accept the default if unsure.
> >  
> > +config RCU_BOOT_END_DELAY
> > +	int "Minimum delay before RCU considers boot has completed"
> > +	range 0 120000
> > +	default 20000
> > +	help
> > +	  This option specifies the minmum time since boot before which
> 
> tpyo:	                            minimum
> 
> > +	  RCU believes the system is booted. The actual delay can be
> > +	  higher than this if the kernel takes a long time to initialize
> > +	  but it will never be smaller than this.

Fixed.

> +	  Specified in milliseconds.
> 
> > +
> > +	  Accept the default if unsure.
> > +
> >  config RCU_EXP_KTHREAD
> >  	bool "Perform RCU expedited work in a real-time kthread"
> >  	depends on RCU_BOOST && RCU_EXPERT
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index 19bf6fa3ee6a..5b73341d9b89 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -62,6 +62,10 @@ module_param(rcu_normal_after_boot, int, 0444);
> >  #endif
> >  #endif /* #ifndef CONFIG_TINY_RCU */
> >  
> > +/* Minimum time until RCU considers boot as completed. */
> > +static int boot_end_delay = CONFIG_RCU_BOOT_END_DELAY;
> > +module_param(boot_end_delay, int, 0444);
> > +
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >  /**
> >   * rcu_read_lock_held_common() - might we be in RCU-sched read-side critical section?
> > @@ -225,12 +229,29 @@ void rcu_unexpedite_gp(void)
> >  EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
> >  
> >  static bool rcu_boot_ended __read_mostly;
> > -
> >  /*
> > - * Inform RCU of the end of the in-kernel boot sequence.
> > + * Inform RCU of the end of the in-kernel boot sequence. The boot sequence will
> > + * not be marked ended until at least boot_end_delay milliseconds have passed.
> >   */
> > +void rcu_end_inkernel_boot(void);
> > +static void boot_rcu_work_fn(struct work_struct *work)
> > +{
> > +	rcu_end_inkernel_boot();
> > +}
> > +static DECLARE_DELAYED_WORK(boot_rcu_work, boot_rcu_work_fn);
> > +
> >  void rcu_end_inkernel_boot(void)
> >  {
> > +	if (boot_end_delay) {
> > +		u64 boot_ms = ktime_get_boot_fast_ns() / 1000000UL;
> 
> Is that division OK on 32-bit?  Might have to use a helper macro. (I dunno.)

Ah, maybe. I am not sure if the compiler generates the right stubs. At least
in userspace it does and there's no problem on 32-bit system. I will research
it more, perhaps by building a 32-bit kernel and seeing what the compiler
does.

Will re-spin later after any more feedback.

thanks,

 - Joel

> 
> > +
> > +		if (boot_ms < boot_end_delay) {
> > +			schedule_delayed_work(&boot_rcu_work,
> > +					boot_end_delay - boot_ms);
> > +			return;
> > +		}
> > +	}
> > +
> >  	rcu_unexpedite_gp();
> >  	rcu_async_relax();
> >  	if (rcu_normal_after_boot)
> 
> -- 
> ~Randy
