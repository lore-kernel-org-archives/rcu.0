Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC43C4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 11:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE3460F02
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 11:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhG1Lu7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 07:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234537AbhG1Lu6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 07:50:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA02E60EB2;
        Wed, 28 Jul 2021 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627473057;
        bh=6rEx0RNqbxKp4kacWWIqPszWXMhCcZNEnFNwkEehxb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+Ds5djxghp4bD/CHDXbW1wXJGBdquub9Y4zOZn/YDVNqu9ihl9ZfbJ2LqyJKeODb
         TnAy1tCAp26K1MK4L8sJXNgjSZqOVk1ZxsoqXCd2f6Yzksl4cKHb7Gw4Sq4cWgjHb+
         3RnF+rebMZwsGcftsU1FKQC9WowrXS3oQ77/tZZpQcV6la8GAjVudnQaqHkrqGBakd
         IMe1Eh38xIdwSmt9rxaFLqdXbJNW1Ssmz4m0rgNP7uX4+u0L7syYQdt9S9zUVH1dMf
         MiyV7eu1yzSLsHfMwEcAlntiS1VnDIzdeLksooadsjQx/CrMF0Fnhwf5Vf7R943ddY
         56Ay46OcZ/BQg==
Date:   Wed, 28 Jul 2021 13:50:54 +0200
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
Message-ID: <20210728115054.GB293265@lothringen>
References: <20210727163815.nwvg5delbqs3ysxl@linutronix.de>
 <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1>
 <87wnpbpn55.ffs@nanos.tec.linutronix.de>
 <20210727233252.GF283787@lothringen>
 <87mtq63khy.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtq63khy.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 28, 2021 at 10:34:01AM +0200, Thomas Gleixner wrote:
> On Wed, Jul 28 2021 at 01:32, Frederic Weisbecker wrote:
> > On Tue, Jul 27, 2021 at 09:33:42PM +0200, Thomas Gleixner wrote:
> >> On Tue, Jul 27 2021 at 10:23, Paul E. McKenney wrote:
> >> > On Tue, Jul 27, 2021 at 06:38:15PM +0200, Sebastian Andrzej Siewior wrote:
> >> >> One thing that has been overseen is that a task within a migrate-disable
> >> >> region (as on PREEMPT_RT with disabled BH) is fully preemptible but may
> >> >> not be migrated to another CPU which should be enough to guarantee that
> >> >> rdp remains stable.
> >> >> 
> >> >> Check also disabled migration of the task if the RCU data pointer is
> >> >> from current CPU. Put the whole check within an SMP ifdef block since
> >> >> without SMP there are not CPU migrations to worry about (also
> >> >> task_struct::migration_disabled is missing).
> >> >> 
> >> >> Cc: Frederic Weisbecker <frederic@kernel.org>
> >> >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> >> ---
> >> >> I don't fully understand why the CPU-hotplug lock matters here but this
> >> >> is beside the point ;)
> >> >
> >> > If I remember correctly, any attempt to change the offloaded state
> >> > must hold off CPU-hotplug operations.  So if the current thread is
> >> > holding off CPU-hotplug operations, no other thread can be doing
> >> > an offload or de-offload operation.
> >> 
> >> It only prevents unplugging of a CPU, but not plugging a CPU.
> >
> > Hmm, but both _cpu_down() and _cpu_up() do cpus_write_lock().
> > What did I overlook?
> 
> I meant, that preemption disable does not prevent plugging a CPU, but
> the final unplug step is prevented because the stomp machine thread
> cannot run. Similar for migrate_disable(). The final unplug step can
> only happen when all non-pinned tasks have left the migrate disabled
> section.

Ah ok so that should be fine since we rely on cpu_hotplug_lock to protect
against CPU hotplug here, preemption disabled is there for other purposes.

Thanks.
