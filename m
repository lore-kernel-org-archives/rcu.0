Return-Path: <SRS0=fQEH=EG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A72C388F7
	for <rcu@archiver.kernel.org>; Sat, 31 Oct 2020 07:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB88322241
	for <rcu@archiver.kernel.org>; Sat, 31 Oct 2020 07:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604130163;
	bh=oi5Erw8ptiShmFnsFP95vlnIhS9KpblRKlS7+BrH0hM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lXFGE0umDgsVhFJ4fmC8scny/SBBHg1l5an0maANgzDDKU8D1lHE3a9cvw8dj/EnB
	 D6S6G7ZMJxT1WXGZonjvjEDuhLP9GhdvesMKdGdZZcrKtlckfj3hup/gpFLRd0Q6mz
	 BUZDL1N9zoJm5cOgpVOggykBz1zL/PZ1WQuELJD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgJaHmm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Oct 2020 03:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgJaHmm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Oct 2020 03:42:42 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C27C822241;
        Sat, 31 Oct 2020 07:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604130162;
        bh=oi5Erw8ptiShmFnsFP95vlnIhS9KpblRKlS7+BrH0hM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LrWrz0Qa8oElMhI8dyu2VN1FEgaPk/ZbZ6ymB1aaDktS+tZh7cXHdaYQF7WeLfGwM
         yqMeKe3C7i6pWMyxBZVMOOV7vLv/V4dKBKZRVRfbvAwFFAqu+DcFbXKfbR1fC/2NoN
         M1T/BwiwtpF9lN7Aq58nh4Js8SYqsbb9nrsoT1vw=
Received: by mail-lf1-f42.google.com with SMTP id l2so10822077lfk.0;
        Sat, 31 Oct 2020 00:42:41 -0700 (PDT)
X-Gm-Message-State: AOAM532ClRvKNonWGpk76PVjJEoVTgVRVjTduoxa7+erah5RnbhyGsmU
        66trqtQu7ehC7FZaZblxda6b/GicUZ9lpecbgL0=
X-Google-Smtp-Source: ABdhPJzX8AI5qWnKvtMzn7QT46/Zv5KpxetvK2uNBsN76JSnc7tXgXt73ZVLx/5jzD1UGV1QJqAznSCvylGchOrXDRA=
X-Received: by 2002:a19:6b10:: with SMTP id d16mr2205633lfa.121.1604130160109;
 Sat, 31 Oct 2020 00:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201021073839.43935-1-zong.li@sifive.com> <CAJF2gTTnGSYAc3AZKCPvhNJsPm_TchPjPrtqc_WzaK7K5eNt+w@mail.gmail.com>
 <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
 <CANXhq0q_fOg7vsniVMtNd8VezW1yymf55FYRc61WMkXMOtZpgA@mail.gmail.com>
 <CAJF2gTR-_=_vDLsST9BVxRFC0OTR4_TYV-2=nH_Gux_zWDOk3Q@mail.gmail.com>
 <CAOnJCU+d5YQzKW2qs0NURJt1_5zrM6YXrkP4FzB_=zgbb-5DuA@mail.gmail.com>
 <CAJF2gTT9gZZftoUD4eMT0Th=oYOpsdYbrFdr=5kO2-N+ki51NA@mail.gmail.com>
 <CAOnJCULO7TuRhBcx6KUVr6t_jqouN-0rao9QXC1RgrU5ehutkw@mail.gmail.com> <20201030202818.72070cbd@oasis.local.home>
In-Reply-To: <20201030202818.72070cbd@oasis.local.home>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 31 Oct 2020 15:42:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSaSzvo2G7prqqtEOueGhERcrcM7VDjK=WeqtePhhZ+dg@mail.gmail.com>
Message-ID: <CAJF2gTSaSzvo2G7prqqtEOueGhERcrcM7VDjK=WeqtePhhZ+dg@mail.gmail.com>
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Atish Patra <atishp@atishpatra.org>, Zong Li <zong.li@sifive.com>,
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

On Sat, Oct 31, 2020 at 8:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 30 Oct 2020 14:47:56 -0700
> Atish Patra <atishp@atishpatra.org> wrote:
>
> > > Look at arm64, they __kprobes flag and I guess it would also prevent
> > > ftrace call site.
> > >
> >
> > Are you sure about that ? __kprobes puts the code in .kprobes.text section
> > which is under whitelist sections in recordmcount.pl & recordmcount.c.
>
> Correct, ftrace can trace functions marked with __kprobes. That said,
I guess wrong, thx for correct me.

> the instruction you are looking at here, is in a file that is
> blacklisted from recordmcount.
>
>   CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
>
> All ftrace flags are removed from the compiling of insn.c, and every
> function in that file will not be traced.
Yes, arm64 prevents the whole file from ftrace. My patch just use
notrace flag setting on some functions.

@Atish How do think:
CFLAGS_REMOVE_cacheflush.o = $(CC_FLAGS_FTRACE)
CFLAGS_REMOVE_sbi.o = $(CC_FLAGS_FTRACE)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
