Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FC1C0044D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 20:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A7320658
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 20:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VG07PfzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbgCPUSE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:18:04 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45952 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732518AbgCPUSE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 16:18:04 -0400
Received: by mail-il1-f195.google.com with SMTP id m9so4399655ilq.12
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4LE69CtgmHSa6+ujtK+0FhmSJ81UdxYmv4ZawIVShQ=;
        b=VG07PfzCoXZaY28uW8BV7Y3nOHaSbqzz/9XQN7J6vP6qShNjz/QNiUqmhsEEOHV7Hu
         Vyusdy+r17T/7fL7QeaUDnZVAMpL2ab3dVHBPz03z93l6POEAca/Qm2n6fQJtOPAwEm/
         n4sBnhSjql19s679ntzoCd7F8n9eKAkt0vssY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4LE69CtgmHSa6+ujtK+0FhmSJ81UdxYmv4ZawIVShQ=;
        b=fLVBINgLpfghTVEKQqikI8pfK2oxOc4NHC22Ay1b15g3wu7Oo/OAMQHc5F+TGV6NeO
         qAK+sj1pI5CyShrrZH++f3GcIklb4xGWBBOLN9eefWjF1nL59wjSYI/O4uz2mKjKjQPB
         /nTfA/svoeAEg2772N9gjR1b4XKVHvo9NIucpDf1rcxIU9jb8VYkxH2X3M6JfBr+n4zs
         FpeGJsjeIkIG4+jZgzuLfpQ3FbkbHILsRb2BkqGRPdLjZ+wV13lK/47lw92pt537spx0
         RuGRB4kjFsou2NK47BhIfFMABU4TmHc+dRuFy0OMVIkPIRyRh5P94DpJLoqTUGkZlW0M
         /24Q==
X-Gm-Message-State: ANhLgQ1G9NEllv0CDvDZoLNPXwoINWZG1S9Myp1VfoEPvR6+RLgnxCJt
        jAKm8VRoCOEX5wq1E5k7fLlOiHKHoDIHYplIb+Vu8w==
X-Google-Smtp-Source: ADFU+vv4rUs/X7PQ1b3v37vyN6v0ioG/SiBa6ADtvcphgyGrf9G16NSPrMbVGu5XqyGKkDPtaqbOoXmrrZqJXJ76Rfk=
X-Received: by 2002:a92:1e0e:: with SMTP id e14mr1659768ile.13.1584389882356;
 Mon, 16 Mar 2020 13:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200312181618.GA21271@paulmck-ThinkPad-P72> <20200312181702.8443-9-paulmck@kernel.org>
 <20200316194754.GA172196@google.com>
In-Reply-To: <20200316194754.GA172196@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 16 Mar 2020 16:17:51 -0400
Message-ID: <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude variant
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com," <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 16, 2020 at 3:47 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Mar 12, 2020 at 11:16:55AM -0700, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > This commit adds a "rude" variant of RCU-tasks that has as quiescent
> > states schedule(), cond_resched_tasks_rcu_qs(), userspace execution,
> > and (in theory, anyway) cond_resched().  Updates make use of IPIs and
> > force an IPI and a context switch on each online CPU.  This variant
> > is useful in some situations in tracing.
>
> Would it be possible to better clarify that the "rude version" works only
> from preempt-disabled regions? Is that also true for the "non-rude" version?
>
> Also it would be good to clarify better in cover letter, how these new
> flavors relate to the existing Tasks-RCU implementation.
>
> In the existing one, a quiescent state is a task updating its context switch
> counters such that it went to sleep at least once, implying there is no
> chance it is on an about to be destroyed trampoline.
>
> However, here we are trying to determine if a task state is no longer on an
> RQ (which I gleaned from the first patch). Sounds very similar, would the
> context switch counters not help in that determination as well? If it is Ok,
> it would be good to describe in cover letter about what is exactly is a
> quiescent state and what exactly is a reader section in the cover letter, for
> both non-rude and rude version. Thanks!

Just curious, why is the "rude" version better than SRCU? Seems the
schedule_on_each_cpu() would be much slower than SRCU especially if
there are 1000s of CPUs involved. Is there any reason that is a better
alternative?

thanks,

 - Joel
