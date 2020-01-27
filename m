Return-Path: <SRS0=q3PZ=3Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14317C2D0DB
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 12:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1962067C
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 12:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA0MYF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:24:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53253 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgA0MYF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jan 2020 07:24:05 -0500
Received: from ip5f5bd665.dynamic.kabel-deutschland.de ([95.91.214.101] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iw3Qj-0006cW-Ss; Mon, 27 Jan 2020 12:23:50 +0000
Date:   Mon, 27 Jan 2020 13:23:48 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     madhuparnabhowmik10@gmail.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com,
        paulmck@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] sched.h: Annotate sighand_struct with __rcu
Message-ID: <20200127122348.wzxwuwvhl5uk2lh5@wittgenstein>
References: <20200124045908.26389-1-madhuparnabhowmik10@gmail.com>
 <20200127092951.GA1116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127092951.GA1116@redhat.com>
User-Agent: NeoMutt/20180716
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 27, 2020 at 10:29:52AM +0100, Oleg Nesterov wrote:
> On 01/24, madhuparnabhowmik10@gmail.com wrote:
> >
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -918,7 +918,7 @@ struct task_struct {
> >  
> >  	/* Signal handlers: */
> >  	struct signal_struct		*signal;
> > -	struct sighand_struct		*sighand;
> > +	struct sighand_struct __rcu		*sighand;
> >  	sigset_t			blocked;
> >  	sigset_t			real_blocked;
> >  	/* Restored if set_restore_sigmask() was used: */
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index bcd46f547db3..9ad8dea93dbb 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1383,7 +1383,7 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
> >  		 * must see ->sighand == NULL.
> >  		 */
> >  		spin_lock_irqsave(&sighand->siglock, *flags);
> > -		if (likely(sighand == tsk->sighand))
> > +		if (likely(sighand == rcu_access_pointer(tsk->sighand)))
> >  			break;
> >  		spin_unlock_irqrestore(&sighand->siglock, *flags);
> >  	}
> 
> ACK,

Applied.

Thanks Paul and Oleg!
Christian
