Return-Path: <SRS0=jzWG=WP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4483FC3A589
	for <rcu@archiver.kernel.org>; Mon, 19 Aug 2019 01:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BEA21773
	for <rcu@archiver.kernel.org>; Mon, 19 Aug 2019 01:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mVjn39ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfHSBql (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:46:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38137 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSBql (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Aug 2019 21:46:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id e11so193066pga.5
        for <rcu@vger.kernel.org>; Sun, 18 Aug 2019 18:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fRg5dLJXfM7c0Nx3rGr24qWxNFmZaWTN5vR7g/IUnjo=;
        b=mVjn39riII4Axaiqh1tXNtZcN5MjMHr+vEXOMQxMZRmSTQ+AENuYg61oQ1byFW00/M
         0qLlDF6Gv7LnU0Svfc/O/PEJ6IiF0xkdD2SZG6CrAc+vthcIgszSThVPrqcYJC7fgNOh
         fTWQmHZBPQxCBBStC8sHbcqinqE4IDQRuUyjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fRg5dLJXfM7c0Nx3rGr24qWxNFmZaWTN5vR7g/IUnjo=;
        b=hVfPF7NDvea2Zx90AnOzvJg7t50NCsrta//G9WEYrIR4qgmvy+ynp5rLINgkOsTUF9
         dQUtDXmOdbTxXkgSFxAFvxnRMWLy0cxig2kIpEzIbIzbHTHXHeDjPHILgQ0+6rOZEZQN
         UmeCc5KIO/hPxBz58/VCiUwRv5flsgoDKzdDSi8kUdDM0CkrjN6spjMkfbdIZX8ru4qk
         Xa30eYvMa/T2VoMhzAm2Lmb/pi7G0EOG5vuCQYNqlX9nfg5IGVKDj3KVIFEchUVAncyQ
         fOnvyW2DPfxTeUUZqFdsNyYYknuuuy6kV7visW7AW6/5OHa2fKoXveebcejMCcFyItkQ
         C8TA==
X-Gm-Message-State: APjAAAU5npi/lMqCYf4UWLIhfN7i8EELIR7uxLw3Ga0RpLu2qiaXDwwz
        zFx+b4GTjZgtP84TMiWO7jj1ag5czuE=
X-Google-Smtp-Source: APXvYqy/PPEEjjm6mSqqcAM43/vP4iTzNkyo989UlWQwHs/3mDqfFk/enBKbQApQlN24QH/Re4+ztA==
X-Received: by 2002:a17:90a:a78b:: with SMTP id f11mr18791597pjq.16.1566179200964;
        Sun, 18 Aug 2019 18:46:40 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id u69sm13279610pgu.77.2019.08.18.18.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 18:46:40 -0700 (PDT)
Date:   Sun, 18 Aug 2019 21:46:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190819014623.GC160903@google.com>
References: <20190818214948.GA134430@google.com>
 <20190818221210.GP28441@linux.ibm.com>
 <20190818223230.GA143857@google.com>
 <20190818223511.GB143857@google.com>
 <20190818233135.GQ28441@linux.ibm.com>
 <20190818233839.GA160903@google.com>
 <20190819012153.GR28441@linux.ibm.com>
 <20190819014143.GB160903@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819014143.GB160903@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 18, 2019 at 09:41:43PM -0400, Joel Fernandes wrote:
> On Sun, Aug 18, 2019 at 06:21:53PM -0700, Paul E. McKenney wrote:
[snip]
> > > > Also, your commit log's point #2 is "in_irq() implies in_interrupt()
> > > > which implies raising softirq will not do any wake ups."  This mention
> > > > of softirq seems a bit odd, given that we are going to wake up a rcuc
> > > > kthread.  Of course, this did nothing to quell my suspicions.  ;-)
> > > 
> > > Yes, I should delete this #2 from the changelog since it is not very relevant
> > > (I feel now). My point with #2 was that even if were to raise a softirq
> > > (which we are not), a scheduler wakeup of ksoftirqd is impossible in this
> > > path anyway since in_irq() implies in_interrupt().
> > 
> > Please!  Could you also add a first-principles explanation of why
> > the added condition is immune from scheduler deadlocks?
> 
> Sure I can add an example in the change log, however I was thinking of this
> example which you mentioned:
> https://lore.kernel.org/lkml/20190627173831.GW26519@linux.ibm.com/
> 
> 	previous_reader()
> 	{
> 		rcu_read_lock();
> 		do_something(); /* Preemption happened here. */
> 		local_irq_disable(); /* Cannot be the scheduler! */
> 		do_something_else();
> 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> 		do_some_other_thing();
> 		local_irq_enable();
> 	}
> 
> 	current_reader() /* QS from previous_reader() is still deferred. */
> 	{
> 		local_irq_disable();  /* Might be the scheduler. */
> 		do_whatever();
> 		rcu_read_lock();
> 		do_whatever_else();
> 		rcu_read_unlock();  /* Must still defer reporting QS. */
> 		do_whatever_comes_to_mind();
> 		local_irq_enable();
> 	}
> 
> One modification of the example could be, previous_reader() could also do:
> 	previous_reader()
> 	{
> 		rcu_read_lock();
> 		do_something_that_takes_really_long(); /* causes need_qs in
> 							  the unlock_special_union to be set */
> 		local_irq_disable(); /* Cannot be the scheduler! */
> 		do_something_else();
> 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> 		do_some_other_thing();
> 		local_irq_enable();
> 	}

The point you were making in that thread being, current_reader() ->
rcu_read_unlock() -> rcu_read_unlock_special() would not do any wakeups
because previous_reader() sets the deferred_qs bit.

Anyway, I will add all of this into the changelog.

thanks,

 - Joel

