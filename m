Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12841C433E6
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 10:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25C864E27
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 10:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhBVKVu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Feb 2021 05:21:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhBVKVt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Feb 2021 05:21:49 -0500
Date:   Mon, 22 Feb 2021 11:21:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613989266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awhpzrnKVfjijEHXiKgK8U7szqwcwqjNV5JLWoQZgaM=;
        b=ZcxJOIv9+kU9xE/WPjtFNKWfM4sWh5aE/J1EFZVDaBO5QUmTF1d1jNAFFF3Xy9a8t+vnO9
        M5rEUfb80W2H1bhFffelKsuoGlELJ5jTWcGDLeUs1fglLsIcEskEi8kVbGLbkxQEF0O+ui
        bCjYzKbX1fJi/nXHEdVgRXxinAcoCJ4jn8Toy0P005OnSxqb4fmuu1wkiyfOfxGTL96gRt
        7Yfjg1gUFD6ZTCep9FUvNC2H7+fbTdzHa45LA2yT3cjYHgOdnphJirhw5spJqAiDjNyG8v
        27gCBBJ9hHP85Cbz5/jU55Bq2KDaO+1MKVbsZ8BdSsQecHQwL+jtV1aUXSJTmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613989266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awhpzrnKVfjijEHXiKgK8U7szqwcwqjNV5JLWoQZgaM=;
        b=xYQcmyRSTGPoqatxQCI1obo4FQeUqzuKXnz6OkHyKneOrCIsM4+DCmPChwg3C6a5MXphuS
        pKzIb6ed9Y85/vBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210222102104.v3pr7t57hmpwijpi@linutronix.de>
References: <20210218151554.GQ2743@paulmck-ThinkPad-P72>
 <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
 <20210219181811.GY2743@paulmck-ThinkPad-P72>
 <20210219183336.GA23049@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210219183336.GA23049@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-02-19 10:33:36 [-0800], Paul E. McKenney wrote:
> For definiteness, here is the first part of the change, posted earlier.
> The commit log needs to be updated.  I will post the change that keeps
> the tick going as a reply to this email.
=E2=80=A6
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 9d71046..ba78e63 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -209,7 +209,7 @@ static inline void invoke_softirq(void)
>  	if (ksoftirqd_running(local_softirq_pending()))
>  		return;
> =20
> -	if (!force_irqthreads) {
> +	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
>  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
>  		/*
>  		 * We can safely execute softirq on the current stack if
> @@ -358,8 +358,8 @@ asmlinkage __visible void __softirq_entry __do_softir=
q(void)
> =20
>  	pending =3D local_softirq_pending();
>  	if (pending) {
> -		if (time_before(jiffies, end) && !need_resched() &&
> -		    --max_restart)
> +		if (!__this_cpu_read(ksoftirqd) ||
> +		    (time_before(jiffies, end) && !need_resched() && --max_restart))
>  			goto restart;

This is hunk shouldn't be needed. The reason for it is probably that the
following wakeup_softirqd() would avoid further invoke_softirq()
performing the actual softirq work. It would leave early due to
ksoftirqd_running(). Unless I'm wrong, any raise_softirq() invocation
outside of an interrupt would do the same.=20

I would like PeterZ / tglx to comment on this one. Basically I'm not
sure if it is okay to expect softirqs beeing served and waited on that
early in the boot.

>  		wakeup_softirqd();

Sebastian
