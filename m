Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8017C54FC9
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 13:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4D320738
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 13:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgDUNaL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgDUNaL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 09:30:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB333206F4;
        Tue, 21 Apr 2020 13:30:09 +0000 (UTC)
Date:   Tue, 21 Apr 2020 09:30:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200421093008.7a0d55ab@gandalf.local.home>
In-Reply-To: <20200421051805.GA5124@pc636>
References: <20200420162534.GD17661@paulmck-ThinkPad-P72>
        <20200420162900.GA11867@pc636>
        <20200420164657.GE17661@paulmck-ThinkPad-P72>
        <20200420165924.GA12078@pc636>
        <20200420172126.GG17661@paulmck-ThinkPad-P72>
        <20200420174019.GB12196@pc636>
        <20200420175915.GH17661@paulmck-ThinkPad-P72>
        <20200420190650.GA12775@pc636>
        <20200420201723.GA4192@pc636>
        <20200420212257.4332734f@oasis.local.home>
        <20200421051805.GA5124@pc636>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 21 Apr 2020 07:18:05 +0200
Uladzislau Rezki <urezki@gmail.com> wrote:

> <snip>
> root@pc636:/sys/kernel/debug/tracing# cat set_ftrace_filter
> measure_schedule_delayed_work.constprop.86
> root@pc636:/sys/kernel/debug/tracing# cat tracing_thresh
> 5
> root@pc636:/sys/kernel/debug/tracing# cat current_tracer
> function_graph
> root@pc636:/sys/kernel/debug/tracing#
> <snip>
> 
> Also i set 5 microseconds threshold to filter out what is less
> and added the latency-format trace option.

Ah, I forgot that tracing_thresh affects function graph tracing.

The tracing infrastructure has so many features, I can't even keep up ;-)

-- Steve
