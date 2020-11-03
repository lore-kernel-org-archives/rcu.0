Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E0C388F9
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD1B20757
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="iVpnDUGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgKCPdw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgKCPdw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 10:33:52 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26372C0613D1
        for <rcu@vger.kernel.org>; Tue,  3 Nov 2020 07:33:52 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id y20so18904250iod.5
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2020 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOkFShIvcUzC6IIWe+nbZVspE2Bn0Jpu0DWyaTr22tE=;
        b=iVpnDUGADTtM5z9B1Q4fm0j2KOKhtLqzlicMhnj6QMjWubr0WU6JCZKmwrUuLHkL+L
         ms6mmflECGT5Sh2YFs5yRkunpFjFnlD2q2/dVjPa+O871RG3vL9vcdq+6LIV95O5emvQ
         l0Sp7tRysizsxqLa3vWHxhkewEeIoLiJO1k9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOkFShIvcUzC6IIWe+nbZVspE2Bn0Jpu0DWyaTr22tE=;
        b=UyBV5K5eTbuLizjIYh/xviwmmdml8FBCivYX8DjTS5gj3x3yAxVz/IjoG0OXuWKm65
         hvmXt6sZ750UeqzabG9E3rhXBX0TKgZO1eBEWPJ9Wol8sS2B6hEetfstzug6HSvBWKbf
         cCzBxVqddhy/eDhZ+RA8g/EoyySuaOl12x3LWuWtIYMAVR+3TaLdx9furAgQHjQZ2O+E
         2CIqWEFBME+xvFMVopyJ7vyFgKU66PRkmM8NQGSYnd4S+DBBZ34V8JD3P6bcmOfggK7s
         MaUA3rfiQQ/ZFQ6ST2u1feMfjfY7R8jb8RROqViGvim9e6hGuThi+BO0pOG8UEq5R+Fn
         ibfA==
X-Gm-Message-State: AOAM5329fKP6RBfQjJ8qqi4lEe2c8liIyAQ5pxQZt01jsNETOFDE3+F1
        O1HjoEI4j4g5Q0rk1pKjr56Zzj6jmbJ3PTBVoGPj
X-Google-Smtp-Source: ABdhPJzRmQhr0W08TEvz9zLHYNIwDDs0PqgRXP+6iIcUUlWfmG1vtmHHCo/h4UxS6vvXcVw7inl5opNTgawpWgnoH6I=
X-Received: by 2002:a5d:9842:: with SMTP id p2mr14701308ios.113.1604417629220;
 Tue, 03 Nov 2020 07:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20201021073839.43935-1-zong.li@sifive.com> <CAJF2gTTnGSYAc3AZKCPvhNJsPm_TchPjPrtqc_WzaK7K5eNt+w@mail.gmail.com>
 <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
 <CANXhq0q_fOg7vsniVMtNd8VezW1yymf55FYRc61WMkXMOtZpgA@mail.gmail.com>
 <CAJF2gTR-_=_vDLsST9BVxRFC0OTR4_TYV-2=nH_Gux_zWDOk3Q@mail.gmail.com>
 <CAOnJCU+d5YQzKW2qs0NURJt1_5zrM6YXrkP4FzB_=zgbb-5DuA@mail.gmail.com>
 <CAJF2gTT9gZZftoUD4eMT0Th=oYOpsdYbrFdr=5kO2-N+ki51NA@mail.gmail.com>
 <CAOnJCULO7TuRhBcx6KUVr6t_jqouN-0rao9QXC1RgrU5ehutkw@mail.gmail.com>
 <20201030202818.72070cbd@oasis.local.home> <CAJF2gTSaSzvo2G7prqqtEOueGhERcrcM7VDjK=WeqtePhhZ+dg@mail.gmail.com>
In-Reply-To: <CAJF2gTSaSzvo2G7prqqtEOueGhERcrcM7VDjK=WeqtePhhZ+dg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 3 Nov 2020 07:33:37 -0800
Message-ID: <CAOnJCU+kMJCrwJ5MD2pYRoub1TpVGgpfX=6nNG2uFB6PNJLEiA@mail.gmail.com>
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
To:     Guo Ren <guoren@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Zong Li <zong.li@sifive.com>,
        Paul McKenney <paulmck@kernel.org>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, vincent.whitchurch@axis.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Colin Ian King <colin.king@canonical.com>,
        rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Oct 31, 2020 at 12:42 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Sat, Oct 31, 2020 at 8:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 30 Oct 2020 14:47:56 -0700
> > Atish Patra <atishp@atishpatra.org> wrote:
> >
> > > > Look at arm64, they __kprobes flag and I guess it would also prevent
> > > > ftrace call site.
> > > >
> > >
> > > Are you sure about that ? __kprobes puts the code in .kprobes.text section
> > > which is under whitelist sections in recordmcount.pl & recordmcount.c.
> >
> > Correct, ftrace can trace functions marked with __kprobes. That said,
> I guess wrong, thx for correct me.
>
> > the instruction you are looking at here, is in a file that is
> > blacklisted from recordmcount.
> >
> >   CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
> >
> > All ftrace flags are removed from the compiling of insn.c, and every
> > function in that file will not be traced.
> Yes, arm64 prevents the whole file from ftrace. My patch just use
> notrace flag setting on some functions.
>
> @Atish How do think:
> CFLAGS_REMOVE_cacheflush.o = $(CC_FLAGS_FTRACE)
> CFLAGS_REMOVE_sbi.o = $(CC_FLAGS_FTRACE)
>

Looks good to me. What should be done for copy_to_kernel_nofault ?
That is also in the calling path.

> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Regards,
Atish
