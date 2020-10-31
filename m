Return-Path: <SRS0=fQEH=EG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151DBC00A89
	for <rcu@archiver.kernel.org>; Sat, 31 Oct 2020 00:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF92208B6
	for <rcu@archiver.kernel.org>; Sat, 31 Oct 2020 00:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgJaA2Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Oct 2020 20:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJaA2X (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Oct 2020 20:28:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6268206E5;
        Sat, 31 Oct 2020 00:28:20 +0000 (UTC)
Date:   Fri, 30 Oct 2020 20:28:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Guo Ren <guoren@kernel.org>, Zong Li <zong.li@sifive.com>,
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
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
Message-ID: <20201030202818.72070cbd@oasis.local.home>
In-Reply-To: <CAOnJCULO7TuRhBcx6KUVr6t_jqouN-0rao9QXC1RgrU5ehutkw@mail.gmail.com>
References: <20201021073839.43935-1-zong.li@sifive.com>
        <CAJF2gTTnGSYAc3AZKCPvhNJsPm_TchPjPrtqc_WzaK7K5eNt+w@mail.gmail.com>
        <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
        <CANXhq0q_fOg7vsniVMtNd8VezW1yymf55FYRc61WMkXMOtZpgA@mail.gmail.com>
        <CAJF2gTR-_=_vDLsST9BVxRFC0OTR4_TYV-2=nH_Gux_zWDOk3Q@mail.gmail.com>
        <CAOnJCU+d5YQzKW2qs0NURJt1_5zrM6YXrkP4FzB_=zgbb-5DuA@mail.gmail.com>
        <CAJF2gTT9gZZftoUD4eMT0Th=oYOpsdYbrFdr=5kO2-N+ki51NA@mail.gmail.com>
        <CAOnJCULO7TuRhBcx6KUVr6t_jqouN-0rao9QXC1RgrU5ehutkw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 30 Oct 2020 14:47:56 -0700
Atish Patra <atishp@atishpatra.org> wrote:

> > Look at arm64, they __kprobes flag and I guess it would also prevent
> > ftrace call site.
> >  
> 
> Are you sure about that ? __kprobes puts the code in .kprobes.text section
> which is under whitelist sections in recordmcount.pl & recordmcount.c.

Correct, ftrace can trace functions marked with __kprobes. That said,
the instruction you are looking at here, is in a file that is
blacklisted from recordmcount.

  CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)

All ftrace flags are removed from the compiling of insn.c, and every
function in that file will not be traced.

-- Steve
