Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C57C4338F
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 23:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D9B60FE7
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 23:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhG0Xcz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232740AbhG0Xcz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jul 2021 19:32:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6DB860F6C;
        Tue, 27 Jul 2021 23:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627428775;
        bh=qDnFhNgmXJ1roJ/JeJ6UilhB+6fiLFJ7rqYwTzhc4E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+8gCXnqwPt063ZhG9Clo91kdRZa5427Licux3dX+QySFdeTBrolQR6tmPj//uxx7
         KXJZOPm93GaJeq1qHd85ATX31zK+B0AkxB8ZBEP0MXYXaoP3Yk6sPzkZ0T/unfii2a
         RBzkgy288iLYSu3ZjS6YeoMB5Ou6ohc+sVSAcIFL8J879TVJMF0MhgFogjcl6WVbpy
         Y2h1DT+k/1Xccp/R/P9ydHyQYzB/+nCzbaw6jr2XrCGGLG+5XBTz9xNTDp5M0LSH2+
         jIRixkeOQ7pkIiOQ5AKLb2Tn0QlEGyFaLOEXMgbaOUaPrM/X0l01WvXtFZmPu/7b1+
         jZJWhNkcJZKwg==
Date:   Wed, 28 Jul 2021 01:32:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] rcu/nocb: Extend checks for offloaded rdp by
 migrate_disable
Message-ID: <20210727233252.GF283787@lothringen>
References: <20210727163815.nwvg5delbqs3ysxl@linutronix.de>
 <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1>
 <87wnpbpn55.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnpbpn55.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 27, 2021 at 09:33:42PM +0200, Thomas Gleixner wrote:
> On Tue, Jul 27 2021 at 10:23, Paul E. McKenney wrote:
> > On Tue, Jul 27, 2021 at 06:38:15PM +0200, Sebastian Andrzej Siewior wrote:
> >> One thing that has been overseen is that a task within a migrate-disable
> >> region (as on PREEMPT_RT with disabled BH) is fully preemptible but may
> >> not be migrated to another CPU which should be enough to guarantee that
> >> rdp remains stable.
> >> 
> >> Check also disabled migration of the task if the RCU data pointer is
> >> from current CPU. Put the whole check within an SMP ifdef block since
> >> without SMP there are not CPU migrations to worry about (also
> >> task_struct::migration_disabled is missing).
> >> 
> >> Cc: Frederic Weisbecker <frederic@kernel.org>
> >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> ---
> >> I don't fully understand why the CPU-hotplug lock matters here but this
> >> is beside the point ;)
> >
> > If I remember correctly, any attempt to change the offloaded state
> > must hold off CPU-hotplug operations.  So if the current thread is
> > holding off CPU-hotplug operations, no other thread can be doing
> > an offload or de-offload operation.
> 
> It only prevents unplugging of a CPU, but not plugging a CPU.

Hmm, but both _cpu_down() and _cpu_up() do cpus_write_lock().
What did I overlook?

PS: just had a quick look and no RCU cpu up operation seem to even check
RCU nocb offload state. So we should be fine ( -ENOSPC for further
famous last words to engrave).

Thanks.
