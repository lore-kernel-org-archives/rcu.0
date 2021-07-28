Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB912C4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 08:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3FC60FDB
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 08:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhG1IeE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 04:34:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58284 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhG1IeD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 04:34:03 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627461241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yH7V4KoLV/oIbRNFiSjPXcVqHiRIg9MDLRJB2qvY5R4=;
        b=hvQ/hQFC0GEZ653BfIyk+jijZLrh/HDndtOM/6+nj5z0u46MmPpAIBRNOki6/82VmPxTBG
        sZRRq9lEQvUiScP72f+HBWhaezB6MDs3MNBZcxOOTdd7L2M94y+SRMn5Cuz+fOaFLvJv3M
        oJHrUYzCfT25xSi6Mqk1pDxgaMAieeq1ior4nzeuX2CL5CuJWDGEsvGIWPq7Nh6sibLbd7
        vdZe9UBN5AGxLLj76QOsJQPBJvOZ+fmJI/nOpntm/BwTRWvwzKkgdfENC+jQ96OQQhIJSs
        HeOjCAsdbtIsuIgypmvqci4Xm9a+6yMfS1dnUruNDBW3T7cOtkEqrYtjO+kwcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627461241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yH7V4KoLV/oIbRNFiSjPXcVqHiRIg9MDLRJB2qvY5R4=;
        b=5nXKloJHD+ozhNsS39lVsxAx2ejmVqsy191lKy/ylciAjNYwH2DXO8ybLwgHnX4StFGbb/
        ZaQFOPGJJt7AWrBQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     paulmck@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] rcu/nocb: Extend checks for offloaded rdp by migrate_disable
In-Reply-To: <20210727233252.GF283787@lothringen>
References: <20210727163815.nwvg5delbqs3ysxl@linutronix.de> <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1> <87wnpbpn55.ffs@nanos.tec.linutronix.de> <20210727233252.GF283787@lothringen>
Date:   Wed, 28 Jul 2021 10:34:01 +0200
Message-ID: <87mtq63khy.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 28 2021 at 01:32, Frederic Weisbecker wrote:
> On Tue, Jul 27, 2021 at 09:33:42PM +0200, Thomas Gleixner wrote:
>> On Tue, Jul 27 2021 at 10:23, Paul E. McKenney wrote:
>> > On Tue, Jul 27, 2021 at 06:38:15PM +0200, Sebastian Andrzej Siewior wrote:
>> >> One thing that has been overseen is that a task within a migrate-disable
>> >> region (as on PREEMPT_RT with disabled BH) is fully preemptible but may
>> >> not be migrated to another CPU which should be enough to guarantee that
>> >> rdp remains stable.
>> >> 
>> >> Check also disabled migration of the task if the RCU data pointer is
>> >> from current CPU. Put the whole check within an SMP ifdef block since
>> >> without SMP there are not CPU migrations to worry about (also
>> >> task_struct::migration_disabled is missing).
>> >> 
>> >> Cc: Frederic Weisbecker <frederic@kernel.org>
>> >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> >> ---
>> >> I don't fully understand why the CPU-hotplug lock matters here but this
>> >> is beside the point ;)
>> >
>> > If I remember correctly, any attempt to change the offloaded state
>> > must hold off CPU-hotplug operations.  So if the current thread is
>> > holding off CPU-hotplug operations, no other thread can be doing
>> > an offload or de-offload operation.
>> 
>> It only prevents unplugging of a CPU, but not plugging a CPU.
>
> Hmm, but both _cpu_down() and _cpu_up() do cpus_write_lock().
> What did I overlook?

I meant, that preemption disable does not prevent plugging a CPU, but
the final unplug step is prevented because the stomp machine thread
cannot run. Similar for migrate_disable(). The final unplug step can
only happen when all non-pinned tasks have left the migrate disabled
section.

Thanks,

        tglx
