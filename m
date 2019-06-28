Return-Path: <SRS0=V9T9=U3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5629CC4321A
	for <rcu@archiver.kernel.org>; Fri, 28 Jun 2019 23:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24993208CB
	for <rcu@archiver.kernel.org>; Fri, 28 Jun 2019 23:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="raHyMqze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfF1XMp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:12:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35641 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1XMo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 28 Jun 2019 19:12:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so3232926pgl.2
        for <rcu@vger.kernel.org>; Fri, 28 Jun 2019 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CpH/P5qpJBU807JBOnNWmYowkfB91BubJ9QNuL0+L5Y=;
        b=raHyMqze832w7AW5zkJ3nEt8ucR7TpvNzWDqFaSeNVwvcpCW7ADqi2e/cfVvAqlYoM
         RxC4s2ZraxA+W4cHWn8Ok/jIIdiIPS9UnD9USoGJ5m5UxgqxdZ1cywUQHXtEVfQ7BSMQ
         woCAhNqlYvSGBak3CyMSUwsLNvsszWvhyaLnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CpH/P5qpJBU807JBOnNWmYowkfB91BubJ9QNuL0+L5Y=;
        b=pzWYemiq9GFHys7lic32St+xQN45IzExjC8xF8YtyjgSLsxGg6E4pEjxPeFfgqJYni
         UeaBJqdeZoOvIm35So4O1kJQzj1eSF+5a5yhG5Fg3AG64V1c1lObL7pkMzqIqiuCxAZa
         zmfcuZ7cqV20V7uIOWctA202d/P1659ka8lnT3qDW1QOzW5QCyHHtONwqd2HEq+eu2MW
         iIoMsm2gUds+irEiGQmuD4I5J/y66s2z7BIcbBmfIeWXaEZVlBJ4GBUNOAgNjGm3ug0z
         voAmlcopReQd4JT+Fmm0c6OIGCdjC8d88/POLbqZils8C0lnq7sqZoLaKhWTbTGRJX2T
         SvaA==
X-Gm-Message-State: APjAAAXy0kfW5Hw3A0rlIOR8K2u28t4IBKzclmIRE7H//RgdmBzy+xfD
        1TiJr7fG12fxgloFFdmM/TnxCw==
X-Google-Smtp-Source: APXvYqxQn6tTDz50Pni+7JEfzyoABLvXiyQA3DVhbdFqJ2FFPvGIaLGU7pJNzoCm7Fe6/Fqksu7T/A==
X-Received: by 2002:a17:90a:1a0d:: with SMTP id 13mr15238953pjk.99.1561763563935;
        Fri, 28 Jun 2019 16:12:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j13sm3272068pfh.13.2019.06.28.16.12.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 16:12:42 -0700 (PDT)
Date:   Fri, 28 Jun 2019 19:12:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628231241.GA9243@google.com>
References: <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628135433.GE3402@hirez.programming.kicks-ass.net>
 <20190628153050.GU26519@linux.ibm.com>
 <20190628184026.fds6scgi2pnjnc5p@linutronix.de>
 <20190628185219.GA26519@linux.ibm.com>
 <20190628192407.GA89956@google.com>
 <20190628200423.GB26519@linux.ibm.com>
 <20190628214018.GB249127@google.com>
 <20190628222547.GE26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628222547.GE26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jun 28, 2019 at 03:25:47PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 28, 2019 at 05:40:18PM -0400, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On Fri, Jun 28, 2019 at 01:04:23PM -0700, Paul E. McKenney wrote:
> > [snip]
> > > > > > Commit
> > > > > > - 23634ebc1d946 ("rcu: Check for wakeup-safe conditions in
> > > > > >    rcu_read_unlock_special()") does not trigger the bug within 94
> > > > > >    attempts.
> > > > > > 
> > > > > > - 48d07c04b4cc1 ("rcu: Enable elimination of Tree-RCU softirq
> > > > > >   processing") needed 12 attempts to trigger the bug.
> > > > > 
> > > > > That matches my belief that 23634ebc1d946 ("rcu: Check for wakeup-safe
> > > > > conditions in rcu_read_unlock_special()") will at least greatly decrease
> > > > > the probability of this bug occurring.
> > > > 
> > > > I was just typing a reply that I can't reproduce it with:
> > > >   rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()
> > > > 
> > > > I am trying to revert enough of this patch to see what would break things,
> > > > however I think a better exercise might be to understand more what the patch
> > > > does why it fixes things in the first place ;-) It is probably the
> > > > deferred_qs thing.
> > > 
> > > The deferred_qs flag is part of it!  Looking forward to hearing what
> > > you come up with as being the critical piece of this commit.
> > 
> > The new deferred_qs flag indeed saves the machine from the dead-lock.
> > 
> > If we don't want the deferred_qs, then the below patch also fixes the issue.
> > However, I am more sure than not that it does not handle all cases (such as
> > what if we previously had an expedited grace period IPI in a previous reader
> > section and had to to defer processing. Then it seems a similar deadlock
> > would present. But anyway, the below patch does fix it for me! It is based on
> > your -rcu tree commit 23634ebc1d946f19eb112d4455c1d84948875e31 (rcu: Check
> > for wakeup-safe conditions in rcu_read_unlock_special()).
> 
> The point here being that you rely on .b.blocked rather than
> .b.deferred_qs.  Hmmm...  There are a number of places that check all
> the bits via the .s leg of the rcu_special union.  The .s check in
> rcu_preempt_need_deferred_qs() should be OK because it is conditioned
> on t->rcu_read_lock_nesting of zero or negative.
> Do rest of those also work out OK?
> 
> It would be nice to remove the flag, but doing so clearly needs careful
> review and testing.

Agreed. I am planning to do an audit of this code within the next couple of
weeks so I will be on the look out for any optimization opportunities related
to this. Will let you know if this can work. For now I like your patch better
because it is more conservative and doesn't cause any space overhead.

If you'd like, please free to included my Tested-by on it:

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

If you had a chance, could you also point to me any tests that show
performance improvement with the irqwork patch, on the expedited GP usecase?
I'd like to try it out as well. I guess rcuperf should have some?

thanks!

 - Joel
 
