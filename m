Return-Path: <SRS0=/mld=CU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE22C433E2
	for <rcu@archiver.kernel.org>; Fri, 11 Sep 2020 03:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EB621D40
	for <rcu@archiver.kernel.org>; Fri, 11 Sep 2020 03:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTZ0VJBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgIKDST (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIKDSP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Sep 2020 23:18:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF7AC061573;
        Thu, 10 Sep 2020 20:18:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w3so10865906ljo.5;
        Thu, 10 Sep 2020 20:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zdf2mY0Hpp+zhTED7uaaOQ2cMS5QXQ9s91tBQuejTgo=;
        b=GTZ0VJBs0+r85HTOcssbbpkMyr9mZ5OeWIdDfFFJA9JWUlE34+guN4WfJMgeXrxRLq
         QaBGugeqSPXQkw4ooLb/WqhTBECmzx4rhwvbguOteDedJXVGlFdzjs59slGqNAYTT5aS
         /HnnJlAogmWOimEnITOvzaN3acxGLFvmlH+m/vImtYOjxdea54hCBBpMlwJb9YHW+a7T
         wylUBmgXUYHKm3Q2J3ODVEBOl9TGkcM2pwrdOZ1w8JtOs6rUjVjZHB+kpxnLDICH5awp
         nRi5/fUahAD/K22h2Y+0QBHxnXPgMJ/L9Y4BpdBTdO+GZXVQ+PsO3HPhruNVIEC1S6f9
         xHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zdf2mY0Hpp+zhTED7uaaOQ2cMS5QXQ9s91tBQuejTgo=;
        b=RlTHVyfIkBp0zlNM1wvKZGDVUFeWGyWAW3F5SMZdFPsCIkSTd8CSV/4bB+mB72cqE0
         vA+SS3Z68xnO8eyd9Fk1Auqx6joFVZOh00X4QoI/9qNRoS3fqmS0r6IFWkJ9oBMAeurv
         WpSNoIxgF+ud73TKBOcOvAy1Zwvd0/Bz14udk5SRYiwrygu1j9I2ueAkgbYc8R8pcwgC
         nujyOparBD69tEBT/dLYTKIIUprEa2Rhd0QdYXPC5cz0m3L/pclneP+sAWPNZloTH4QM
         BU0y7SWCSyOcljalQwHi1ZmsLvhhobcqAkuYaoHIbMlLoLDRt8ICrf8V3JQue+qRZY4G
         W1dg==
X-Gm-Message-State: AOAM532T+Ij+vPAskgLSBtpaWgmPHzL9ue+GW+M+6BjXBex1BSUGV5zC
        ctQ3nJM3ea+IpEecsHIzNqcddPqojYrTkFPIEiY=
X-Google-Smtp-Source: ABdhPJyYAl75efBV+5KmHCF0d/2RYY9Sn7aNJx1H5//c8E2GxJK93up+JiNHw1s73brzahSfIWqMcumFUA45tjT63to=
X-Received: by 2002:a2e:8593:: with SMTP id b19mr5644163lji.290.1599794293056;
 Thu, 10 Sep 2020 20:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200910201956.GA24190@paulmck-ThinkPad-P72> <20200910202052.5073-4-paulmck@kernel.org>
In-Reply-To: <20200910202052.5073-4-paulmck@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Sep 2020 20:18:01 -0700
Message-ID: <CAADnVQK4Rgrzq+cUKCMkr5anZF+UbHmAc7-FH4BjA23aMM03rQ@mail.gmail.com>
Subject: Re: [PATCH RFC tip/core/rcu 4/4] rcu-tasks: Shorten per-grace-period
 sleep for RCU Tasks Trace
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 10, 2020 at 1:20 PM <paulmck@kernel.org> wrote:
>
> From: "Paul E. McKenney" <paulmck@kernel.org>
>
> The various RCU tasks flavors currently wait 100 milliseconds between each
> grace period in order to prevent CPU-bound loops and to favor efficiency
> over latency.  However, RCU Tasks Trace needs to have a grace-period
> latency of roughly 25 milliseconds, which is completely infeasible given
> the 100-millisecond per-grace-period sleep.  This commit therefore reduces
> this sleep duration to 5 milliseconds (or one jiffy, whichever is longer)
> in kernels built with CONFIG_TASKS_TRACE_RCU_READ_MB=y.

The commit log is either misleading or wrong?
If I read the code correctly in CONFIG_TASKS_TRACE_RCU_READ_MB=y
case the existing HZ/10 "paranoid sleep" is preserved.
It's for the MB=n case it is reduced to HZ/200.
Also I don't understand why you're talking about milliseconds but
all numbers are HZ based. HZ/10 gives different number of
milliseconds depending on HZ.
