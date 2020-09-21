Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC7EC43465
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 12:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AA620708
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 12:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600690578;
	bh=eBBhAlX3XFV5kv5wITd4mE3fjJvue5h4/NKL4o0iD3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eHTSZgnv4uwc8aSgbeN8mOdcWJBdnfFwHVrlq0r35nAlWldm+aglBdTcCxj6zPVXJ
	 fMT2Ew2I8ttoQ5WBQ26n6SnoM4f2dW5m1YxJ/ssv2CiwnDsKZHxbxFo+jwJbyCxbIQ
	 dm7/T48eTyEilGf5iRf+4v/FAH3+GrFCXerM2DNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIUMQP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Sep 2020 08:16:15 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42688 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIUMQO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Sep 2020 08:16:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id x14so16667491oic.9;
        Mon, 21 Sep 2020 05:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcFPSidHF3BVoPv8XvLOttLzybHltg4dD5z0pmUwA4k=;
        b=BHACPtf71A42ThNl5cbAaffQiYBjgIjSIr19OH/UIiM4BsXK+oyV+h17hZ+t8fXJNR
         qTG5jV0p9CY/o7h52gUvqcMdTTjXJuVSLT1FNRBoDwVdLqMwcwSgk/hqpDzV4kJiimCs
         PtCSHYL9WyTj1Rds5NbZjKIwygFpWLzhd7AHsaja0oVqcX9Vf/JUlUoWbRw0EbepxnJj
         uF5NuhFoN2Ya+MLus371WE8UxpoUno03C3Osk7PgvDh7ytU5Dnbyz7fhztHVJMZNCtRA
         wyxiIVkyTYqLpNEFNEqG+Azb7plCefW8EE/6MEJp4Tx09YGAMyI+kOtVWeTu/biRyxaz
         Ta3w==
X-Gm-Message-State: AOAM532W8dw/Gx0kozDvoKD9wfQbN0AdZJ5IEIL7iQYz5WELtCIs/ikB
        k2AcUIkREXoxa4yl7vEMReKkBYenQQO9TtRnr/BifPYQ
X-Google-Smtp-Source: ABdhPJxrhYmJXx4HqgrQAwiD/iI/AFKi/FS63u8LkFKXt79EwBh06A4HspKgmhCScDgCaweYOBOoq4S9EXW29sbf18I=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr18128162oid.110.1600690573429;
 Mon, 21 Sep 2020 05:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200915103157.345404192@infradead.org> <20200915103806.479637218@infradead.org>
 <87wo0npk72.fsf@turtle.gmx.de> <20200921103741.GC5901@zn.tnic>
In-Reply-To: <20200921103741.GC5901@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 14:15:58 +0200
Message-ID: <CAJZ5v0hmf3iV2bVKN8-vRyrsmnYHX99RgK4kgr7kz5DfrNE8sA@mail.gmail.com>
Subject: Re: [PATCH] rcu/tree: Export rcu_idle_{enter,exit} to module
To:     Borislav Petkov <bp@alien8.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sven Joachim <svenjoac@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 21, 2020 at 12:37 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Lemme add whatever get_maintainer spits, to Cc.
>
> On Mon, Sep 21, 2020 at 11:12:33AM +0200, Sven Joachim wrote:
> > On 2020-09-15 12:32 +0200, Peter Zijlstra wrote:
> >
> > > The C3 BusMaster idle code takes lock in a number of places, some deep
> > > inside the ACPI code. Instead of wrapping it all in RCU_NONIDLE, have
> > > the driver take over RCU-idle duty and avoid flipping RCU state back
> > > and forth a lot.
> > >
> > > ( by marking 'C3 && bm_check' as RCU_IDLE, we _must_ call enter_bm() for
> > >   that combination, otherwise we'll loose RCU-idle, this requires
> > >   shuffling some code around )
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > I got modpost errors in 5.9-rc6 after this patch:
> >
> > ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
> > ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!
> >
> > Reverting commit 1fecfdbb7acc made them go away.  Notably my
> > configuration had CONFIG_ACPI_PROCESSOR=m,  changing that
> > to CONFIG_ACPI_PROCESSOR=y let the build succeed as well.
>
> I guess this. Running randconfigs on it for a while, to see what else
> breaks.
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Mon, 21 Sep 2020 12:31:36 +0200
>
> Fix this link error:
>
>   ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
>   ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!
>
> when CONFIG_ACPI_PROCESSOR is built as module. PeterZ says that in light
> of ARM needing those soon too, they should simply be exported.
>
> Fixes: 1fecfdbb7acc ("ACPI: processor: Take over RCU-idle for C3-BM idle")
> Reported-by: Sven Joachim <svenjoac@gmx.de>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Well, I guess I should take this through cpuidle?

Any concerns about doing that?  Paul?

> ---
>  kernel/rcu/tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8ce77d9ac716..f78ee759af9c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -673,6 +673,7 @@ void rcu_idle_enter(void)
>         lockdep_assert_irqs_disabled();
>         rcu_eqs_enter(false);
>  }
> +EXPORT_SYMBOL_GPL(rcu_idle_enter);
>
>  #ifdef CONFIG_NO_HZ_FULL
>  /**
> @@ -886,6 +887,7 @@ void rcu_idle_exit(void)
>         rcu_eqs_exit(false);
>         local_irq_restore(flags);
>  }
> +EXPORT_SYMBOL_GPL(rcu_idle_exit);
>
>  #ifdef CONFIG_NO_HZ_FULL
>  /**
> --
> 2.21.0
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
