Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3345C433EF
	for <rcu@archiver.kernel.org>; Mon,  7 Mar 2022 17:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbiCGR65 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiCGR65 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Mar 2022 12:58:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5593C22BD5
        for <rcu@vger.kernel.org>; Mon,  7 Mar 2022 09:58:02 -0800 (PST)
Date:   Mon, 7 Mar 2022 18:57:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646675880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHePnKRgEAubu98Ld1vEdOQE2k29ZqhWVqmmoMoftJc=;
        b=LeAXhe+X/LVhUdq0onlh0nXBRywGlZ8/BIQKQf26zsBgtjD+jZGlLvfHO7Noz1V3P6T2hF
        NaqrOjdm5oMyZ88hJ9fijSuiiYvOJOYW96GDG5IS5TuozraYEHCqzEPGaRi6CVIvQ1S6Pp
        hFc+vNM/C/YI4kZxcFGu/iWRNgJYIQ783BEbto8qPraB1nN6J8IqwgR5g2n8b0YevomptV
        VK6QsPV7HGQ1pq9ygEB/Lh5Mm8SCpvFrWEEt1YMtukpqfSigji9dgFuEzmLUK2koqe5vqg
        MEISeX8igiilweL9d3UCstoUKysj3/xWY8yMbWV1vxla00dYSF8DqM1Bt70LMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646675880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHePnKRgEAubu98Ld1vEdOQE2k29ZqhWVqmmoMoftJc=;
        b=VvIMxD88JgRxZrKcSAL2uPX1kwqczVfLYaHsZeCw9GUG/a/MIQi+ILEx57n/e7TZ0mOf3b
        VSfx6eqOFbKjkKDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu-tasks: Use rcuwait for the rcu_tasks_kthread().
Message-ID: <YiZHp68bPJvLzvhV@linutronix.de>
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiHy7Y5fTU3jRdMi@linutronix.de>
 <20220305044007.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <YiXp4+2atG0Ni2rJ@linutronix.de>
 <20220307150913.GI4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220307150913.GI4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2022-03-07 07:09:13 [-0800], Paul E. McKenney wrote:
> > Correct. Possible due to the removal of wait_queue_head (plus there is
> > nothing else that would stand in the way otherwise).
>=20
> Very good!
>=20
> If the overhead becomes a problem in mainline, presumably we can do
> a compile-time switch based on CONFIG_PREEMPT_RT or similar.

the rcuwake is a lot cheaper than waitqueue in terms of code or data
involved, locks, =E2=80=A6. The _HARD flag is a nop on !RT.
So it should be a win-win situation here.

> > > If so, I am wondering if there are other
> > > irq_work instances that need to move to _HARD.
> >=20
> > We already have:
> > kernel/rcu/tree.c:      rdp->rcu_iw =3D IRQ_WORK_INIT_HARD(rcu_iw_handl=
er);
>=20
> Because you prompted me to change it from IRQ_WORK_INIT() some time
> back?  ;-)

Right. We have printk() for instance using the !HARD irq-work so this
mostly a case-by-case decision usually avoiding HARD.

> 							Thanx, Paul

Sebastian
