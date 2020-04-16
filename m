Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E7CC2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903C821924
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 19:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgDPT02 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgDPT00 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 15:26:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F70D20715;
        Thu, 16 Apr 2020 19:26:24 +0000 (UTC)
Date:   Thu, 16 Apr 2020 15:26:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416152623.48125628@gandalf.local.home>
In-Reply-To: <20200416185934.GD149999@google.com>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
        <20200416144254.GC90777@google.com>
        <20200416151824.a372pdiphube3x3l@linutronix.de>
        <20200416184112.GA149999@google.com>
        <20200416185934.GD149999@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 16 Apr 2020 14:59:34 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> But, then will it be safe for kfree_rcu() callers from hard IRQ context to
> call this in PREEMPT_RT? That could would just break then as you cannot sleep
> in hard IRQ context even on PREEMPT_RT.

But where in PREEMPT_RT would it be called in hard IRQ context?

Note, most interrupt handlers in PREEMPT_RT are turned into threads (except
for a very few, which shouldn't be calling kfree_rcu()).

-- Steve
