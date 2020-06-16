Return-Path: <SRS0=B8+c=75=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E41BC433DF
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE2F208B8
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 16:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592326344;
	bh=XeB8RfXxntVxzyrTfg70RUh4UjEGQCPWv1lwVLpthu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xJAnxGYUU6KUoycrOfz4/xPJGpFewHmEioStuleurb3NZJ1yjyenb52Dmgww5rvPu
	 JnWBDGpMHKurvFWsOT2f/R4Xq2yxhqWEw9weO3dNNCZjDbhI3LfNmB+ppm/hcbjVjZ
	 lGD8NfhXrKSqslEKInZhIqaICqatx+J1mEYiEsF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgFPQwX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgFPQwX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 12:52:23 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C3A21534
        for <rcu@vger.kernel.org>; Tue, 16 Jun 2020 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592326342;
        bh=XeB8RfXxntVxzyrTfg70RUh4UjEGQCPWv1lwVLpthu8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IopV3ocfvIbZY5iNuUz+Prt9RPPcu8j9dNlB7uwO1RMYdecRi7THhpTXOEoTowsEM
         I/mnPkLPie9GPfiDwXuDqlNw6KgxP6GsVbE7C+nqZQPeNHvFDOh6jMvhmW+VsPNbyE
         CMgboltnVR4XKIZMf4g/dutOH0Ilj0je4P3ug9/s=
Received: by mail-wr1-f48.google.com with SMTP id b6so2366297wrs.11
        for <rcu@vger.kernel.org>; Tue, 16 Jun 2020 09:52:22 -0700 (PDT)
X-Gm-Message-State: AOAM531TbL8hMV5AVtdm8SFu2EQcaNQuGWmDks+xXpGihyXC4Lj70ql7
        dNpSmCGl7MXvGsMJWE+eXwLGo8ftoJOgiHtTla3k4Q==
X-Google-Smtp-Source: ABdhPJya86zs5ua3UHDfJ8AyO/vlLTTEAa2ptum00sS1wlyK4hLZRdXce+xtjtmf6hy8V9J+uddsFUOnEBmn45Ic2iw=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr3891054wrm.75.1592326340746;
 Tue, 16 Jun 2020 09:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200611235305.GA32342@paulmck-ThinkPad-P72> <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com>
 <871rmkzcc8.fsf@nanos.tec.linutronix.de> <87wo4cxubv.fsf@nanos.tec.linutronix.de>
 <20200615201647.GC12037@google.com> <871rmfcskb.fsf@nanos.tec.linutronix.de> <20200616143018.GD12037@google.com>
In-Reply-To: <20200616143018.GD12037@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Jun 2020 09:52:09 -0700
X-Gmail-Original-Message-ID: <CALCETrViTVCaqmF1wQCAdPR7k9ZYOvRDdzjkVBMwrVH6nh3zMg@mail.gmail.com>
Message-ID: <CALCETrViTVCaqmF1wQCAdPR7k9ZYOvRDdzjkVBMwrVH6nh3zMg@mail.gmail.com>
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 16, 2020 at 7:30 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Jun 16, 2020 at 10:40:04AM +0200, Thomas Gleixner wrote:
> > Joel,
> >
> > Joel Fernandes <joel@joelfernandes.org> writes:
> > > On Fri, Jun 12, 2020 at 03:55:00PM +0200, Thomas Gleixner wrote:
> > >> This is also correct vs. user mode entries in NOHZ full scenarios because
> > >> user mode entries bring RCU out of EQS and force the RCU irq nesting state
> > >
> > > I had to re-read this sentence a couple of times. The 'user mode entries'
> > > sounds like 'entry into user mode'. It would be good to reword it to 'IRQ
> > > entry in user mode'.
> >
> > :)
> >
> > > My knowledge predates the rcu-watching reworks so apologies on the below
> > > question but I still didn't fully follow why when the idle task behaves
> > > differently from being in user mode. Even with user mode we should have:
> > >
> > > <user mode>  (in EQS)
> > >   <irq entry>   <---------- exits EQS so now rcu is watching
> > >      <softirq entry in the exit path>
> > >         <timer tick irq entry>  <-- the buggy !watching logic prevents rcu_irq_enter
> > >         -> report QS since tick thinks it is first level.
> > >
> > > Is there a subtlety here I'm missing? I checked the RCU code and I did not
> > > see anywhere that rcu_user_enter() makes it behave differently. Both
> > > rcu_user_enter() and rcu_idle_enter() call rcu_eqs_enter().
> >
> > The interrupt hit user mode entry does:
> >
> >     idtentry_enter_cond_rcu()
> >       if (user_mode(regs))
> >          enter_from_user_mode()
> >            user_exit_irqoff()
> >              __context_tracking_exit(CONTEXT_USER)
> >                rcu_user_exit()
> >                  rcu_eqs_exit(1)
> >                    ...
> >                    WRITE_ONCE(rdp->dynticks_nmi_nesting,
> >                               DYNTICK_IRQ_NONIDLE);
> >
> > i.e. for interrupts which enter from user mode we are not invoking
> > rcu_irq_enter() at all.
> >
> > The return from interrupt path has nothing to do with that because
> > that's an entry in kernel mode.
>
> Hi Thomas,
> Ah, IRQ entry in user mode triggers the context-tracking path. Makes sense now, thanks.
>
> This will help me when I have to propose to get rid of dynticks_nmi_nesting again :)
>

Propose away, but just keep in mind that horrible architectures like
x86 really can nest non-maskable interrupts that hit kernel code more
than one deep.

--Andy
