Return-Path: <SRS0=HAhG=EB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DBFC4363A
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 02:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F192C2222C
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 02:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EnW0FNHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421592AbgJZC40 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 25 Oct 2020 22:56:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38290 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420364AbgJZC40 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 25 Oct 2020 22:56:26 -0400
Received: by mail-ot1-f66.google.com with SMTP id b2so6202903ots.5
        for <rcu@vger.kernel.org>; Sun, 25 Oct 2020 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1A7KKpu8iHyelnMvFNOPHpastJBG2S7fqWEYdd55aZM=;
        b=EnW0FNHH+r03d90oq8rGBpzPagH7cu9Dhhb2NyS7D5ueAdaKA+G/a+BfYWtrs5YUKI
         dufXhw0/7KTydE5JUmyGswgoTGmB8XaG4O30hp4jc/2rQwTvrm5XWNQmsrasi0HpoKpa
         BH3ru72/cbiMlxVPYb3B5OKyrNPmHYw6CVwADY2ni6uL7fvqNBm/iFbYciJxCa2EJzSK
         h1rJ+Ap4SXrnFsrRCcXM2WdezQYC/+ZO1emUQB14SkcvvHa74n8Zy1Qy/tjEopEN0ZZ4
         s3ioyy6Av14dWNGcUxYHTBvkkehVa01VTo2qD0Bxb4ZiHXokGxnzxdGn706NTcxuww/M
         6fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1A7KKpu8iHyelnMvFNOPHpastJBG2S7fqWEYdd55aZM=;
        b=KW2hEIqLnrz/NyCezq+m5fY9oNdLxw/ORD7yUYY6YoYswMjANaQlt/GBB64HSkqhdZ
         1hlw3BtgV0PuPf8Scs1UwQNC2G2tt4lCEhUhrM7eYJ5ysPhFSi8qeyTqQjruqhF6y7Nx
         vb+T9aDdsIqJnFCebqxvVgYthEkr5ChqbhGBzOWbfozXYFa4btCovap//9U9SrGnWW1h
         SO102USj0GymvhOzRRTUxQUdY12qv51DomcP6kwx4L/PNZoYDGEAdJWAk5rL/kHWq5m/
         Dl4eBdDEUZTxBz08FLxr32P5j6NxhWKtA6GOLdeXc327sQy1gXMxCK10CDxMvOBSAVYN
         Hhtw==
X-Gm-Message-State: AOAM531l80gSgwldWkz83AkQBN7SI2IV0s9nGRzNzxDw6BDqITDO+sOH
        zMsORb5zTdSUdjxnb9zqspektXuo0CC4C4trrxTtZw==
X-Google-Smtp-Source: ABdhPJyLOUdems4JWzS/MRZn8GpPxi1lg+1JMAhEnm9vnRVUPvvsCtolJPvi2h6QcMszn37KmBclhtRFhGzGacKicbs=
X-Received: by 2002:a9d:bb2:: with SMTP id 47mr5794824oth.160.1603680985321;
 Sun, 25 Oct 2020 19:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201021073839.43935-1-zong.li@sifive.com> <50bdca78-0cbb-5c62-f241-ed50737131b2@canonical.com>
In-Reply-To: <50bdca78-0cbb-5c62-f241-ed50737131b2@canonical.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 26 Oct 2020 10:56:16 +0800
Message-ID: <CANXhq0p5G0PwL+bnsjdEbPMtU1qveLXyshQWuab2pe3Pn9UXfg@mail.gmail.com>
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
To:     Colin Ian King <colin.king@canonical.com>
Cc:     paulmck@kernel.org, josh@joshtriplett.org,
        Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, vincent.whitchurch@axis.com,
        tglx@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>, rcu@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Oct 24, 2020 at 3:29 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> On 21/10/2020 08:38, Zong Li wrote:
> > Like the commit cb9d7fd51d9f ("watchdog: Mark watchdog touch functions
> > as notrace"), some architectures assume that the stopped CPUs don't make
> > function calls to traceable functions when they are in the stopped
> > state. For example, it causes unexpected kernel crashed when switching
> > tracer on RISC-V.
> >
> > The following patches added calls to these two functions, fix it by
> > adding the notrace annotations.
> >
> > Fixes: 4ecf0a43e729 ("processor: get rid of cpu_relax_yield")
> > Fixes: 366237e7b083 ("stop_machine: Provide RCU quiescent state in
> > multi_cpu_stop()")
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  kernel/rcu/tree.c     | 2 +-
> >  kernel/stop_machine.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 06895ef85d69..2a52f42f64b6 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -409,7 +409,7 @@ bool rcu_eqs_special_set(int cpu)
> >   *
> >   * The caller must have disabled interrupts and must not be idle.
> >   */
> > -void rcu_momentary_dyntick_idle(void)
> > +notrace void rcu_momentary_dyntick_idle(void)
> >  {
> >       int special;
> >
> > diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> > index 865bb0228ab6..890b79cf0e7c 100644
> > --- a/kernel/stop_machine.c
> > +++ b/kernel/stop_machine.c
> > @@ -178,7 +178,7 @@ static void ack_state(struct multi_stop_data *msdata)
> >               set_state(msdata, msdata->state + 1);
> >  }
> >
> > -void __weak stop_machine_yield(const struct cpumask *cpumask)
> > +notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
> >  {
> >       cpu_relax();
> >  }
> >
>
> Apologies for taking so long to reply, I needed to test this on several
> devices.
>
> This not only fixes the ftrace issue I see on RISC-V but also a ftrace
> hang issue on ARM64 in 5.8 too.
>
> Tested-by: Colin Ian King <colin.king@canonical.com>
>
> Many thanks!

Many thanks all for reviewing and testing.

Hi Palmer,
As Steven suggested, could you help to pick up this patch in RISC-V tree?
