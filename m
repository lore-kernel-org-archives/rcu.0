Return-Path: <SRS0=WZu2=3P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CACFC35242
	for <rcu@archiver.kernel.org>; Sun, 26 Jan 2020 01:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDA82075E
	for <rcu@archiver.kernel.org>; Sun, 26 Jan 2020 01:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580001835;
	bh=GT9CakDKgzHGUsSd9Pzep51RqWx2T4j5nL8jJpuNXfU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MK04IzLk64ZDS9PfmTYxcgYLQ0Aubrv31qxc25k8bLg01D7SO25TvK43ZpeKP3wRN
	 K6K8tIU+euCi9PsGJz9vau7vIjQyPOYrYZT1zTPUQeJY8dEfIxnG3SdlT/7swtT6iH
	 LZ3HGoR//oJUEJQJhC/bhYz7XouS6fIdzCV/Qp2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAZBXz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 25 Jan 2020 20:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgAZBXz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 25 Jan 2020 20:23:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35DE2071E;
        Sun, 26 Jan 2020 01:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580001834;
        bh=GT9CakDKgzHGUsSd9Pzep51RqWx2T4j5nL8jJpuNXfU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cHMhoBBGZV26DndY6i79l0/oheY4IbhYgCsuqfMECWp+RWh41bvab2aVqy5sh4VP2
         zzY5c7ceHPkAgkzOeJIIw+jRuMUcrqF1H9vWDxzZF26XayhojEOK1n8F6qZrqmiqZb
         iWqsFYhbU643ZDKtlj+M0bfkHQQLNXzrJJ2KrkZc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A43853522863; Sat, 25 Jan 2020 17:23:54 -0800 (PST)
Date:   Sat, 25 Jan 2020 17:23:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     madhuparnabhowmik10@gmail.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com, oleg@redhat.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] sched.h: Annotate sighand_struct with __rcu
Message-ID: <20200126012354.GH2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
 <37A3FF92-0958-46DD-AFB1-CE72000B153F@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37A3FF92-0958-46DD-AFB1-CE72000B153F@ubuntu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 25, 2020 at 10:41:06PM +0100, Christian Brauner wrote:
> On January 24, 2020 5:59:08 AM GMT+01:00, madhuparnabhowmik10@gmail.com wrote:
> >From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >
> >This patch fixes the following sparse errors by annotating the
> >sighand_struct with __rcu
> >
> >kernel/fork.c:1511:9: error: incompatible types in comparison
> >expression
> >kernel/exit.c:100:19: error: incompatible types in comparison
> >expression
> >kernel/signal.c:1370:27: error: incompatible types in comparison
> >expression
> >
> >This fix introduces the following sparse error in signal.c due to
> >checking the sighand pointer without rcu primitives:
> >
> >kernel/signal.c:1386:21: error: incompatible types in comparison
> >expression
> >
> >This new sparse error is also fixed in this patch.
> >
> >Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> >---
> > include/linux/sched.h | 2 +-
> > kernel/signal.c       | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/linux/sched.h b/include/linux/sched.h
> >index b511e178a89f..7a351360ad54 100644
> >--- a/include/linux/sched.h
> >+++ b/include/linux/sched.h
> >@@ -918,7 +918,7 @@ struct task_struct {
> > 
> > 	/* Signal handlers: */
> > 	struct signal_struct		*signal;
> >-	struct sighand_struct		*sighand;
> >+	struct sighand_struct __rcu		*sighand;
> > 	sigset_t			blocked;
> > 	sigset_t			real_blocked;
> > 	/* Restored if set_restore_sigmask() was used: */
> >diff --git a/kernel/signal.c b/kernel/signal.c
> >index bcd46f547db3..9ad8dea93dbb 100644
> >--- a/kernel/signal.c
> >+++ b/kernel/signal.c
> >@@ -1383,7 +1383,7 @@ struct sighand_struct *__lock_task_sighand(struct
> >task_struct *tsk,
> > 		 * must see ->sighand == NULL.
> > 		 */
> > 		spin_lock_irqsave(&sighand->siglock, *flags);
> >-		if (likely(sighand == tsk->sighand))
> >+		if (likely(sighand == rcu_access_pointer(tsk->sighand)))
> > 			break;
> > 		spin_unlock_irqrestore(&sighand->siglock, *flags);
> > 	}
> 
> If Paul is happy with this and nobody wants to take it I'll pick this up.

Works for me!

							Thanx, Paul
