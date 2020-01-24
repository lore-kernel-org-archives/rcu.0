Return-Path: <SRS0=Fsgb=3N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E15C2D0CE
	for <rcu@archiver.kernel.org>; Fri, 24 Jan 2020 04:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A8C2072C
	for <rcu@archiver.kernel.org>; Fri, 24 Jan 2020 04:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg5itA96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgAXE3G (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Jan 2020 23:29:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55805 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgAXE3G (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Jan 2020 23:29:06 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so459938pjz.5;
        Thu, 23 Jan 2020 20:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W5pF9JS7OfQogiQ+v1H3GtBwMtau9/tHuDv1Q9h5buA=;
        b=Sg5itA96fCucpWFLPztS45UrhdU//Yjb9e3vjuwavSuwIsEFNQVX2ZPToq0NWtjIIC
         HkRfgfgyS11flHWhXXEFQvCg6EbCVYgR2fPisPweEkJA8vBD155pupXWLhqDx3FaxlTO
         9ScXQuVU+BYXGdJENQyKT5QGGLQ+y6rDcOd1OzPbCpt6oEHAFBRn8VTl+mfUrqTLxiM/
         kc1c8wcYMrNIM+own+kkA6QzBGRgNf5ljnLWAUbvPjX2ui0tWZqMORkoORYY0Eyooxrt
         AbI4PxV5886ntusBBmpJyEsQy+HJaYyk9G8qHfEaqHXUUDnXmjGWc1gTQ0z5LW1uQniw
         khHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W5pF9JS7OfQogiQ+v1H3GtBwMtau9/tHuDv1Q9h5buA=;
        b=dRiwex23Va2pMGvGUUo+PLaOwyZ/FTzcwxa6p5E3FhqsP6yQxONeLdX+aBzH5qPsxY
         r0FByZGy6yKtjTN1I6QvspyGZkQ+bonu1LsToRsKmMzzvnyN+MFVmqA6qlc+DFCgVNzR
         kmqKsDKZlCqat/nNz4sOlWgTYudruk5jSGo1Nsdo84oSp07OfXDyAGQfD/yZiIupIJws
         nkzK2ncxIad+Lqm2jImHJ9bPd+tzOTie2CV9RciJbE+24ziL8GPajz09nNi5B38Mh9Z0
         6/DyUz9NHSNZihZ+kh0kQZuIvgUyasWed15v2F8ghDySNT5PeKEekyKpsrq5L9GL+uxE
         8zLA==
X-Gm-Message-State: APjAAAXAdtbij3LetUw7L+eRRUwULuH8XlnkHFUyjJAXRK8fuUYEZOzo
        XKD5J/aWoO+jNdHPaa1QYg==
X-Google-Smtp-Source: APXvYqz1nhFiSAUfCxrhC6VBjKlPGF/48fHdPP+Z2cbhtLQPGcYLYeWWuPogvT4DZKfQfmpTS2XuAg==
X-Received: by 2002:a17:90a:fa88:: with SMTP id cu8mr1112275pjb.141.1579840145559;
        Thu, 23 Jan 2020 20:29:05 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:1ee5:e37b:72:f3a9:f673:9aea])
        by smtp.gmail.com with ESMTPSA id iq22sm4558521pjb.9.2020.01.23.20.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 20:29:04 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Fri, 24 Jan 2020 09:58:52 +0530
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     madhuparnabhowmik10@gmail.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, oleg@redhat.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] sched.h: Annotate sighand_struct with __rcu
Message-ID: <20200124042852.GC23699@madhuparna-HP-Notebook>
References: <20200123145305.10652-1-madhuparnabhowmik10@gmail.com>
 <20200123164108.GQ2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123164108.GQ2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 23, 2020 at 08:41:08AM -0800, Paul E. McKenney wrote:
> On Thu, Jan 23, 2020 at 08:23:05PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > This patch fixes the following sparse errors by annotating the
> > sighand_struct with __rcu
> > 
> > kernel/fork.c:1511:9: error: incompatible types in comparison expression
> > kernel/exit.c:100:19: error: incompatible types in comparison expression
> > kernel/signal.c:1370:27: error: incompatible types in comparison expression
> > 
> > This fix introduces the following sparse error in signal.c due to
> > checking the sighand pointer without rcu primitives:
> > 
> > kernel/signal.c:1386:21: error: incompatible types in comparison expression
> > 
> > This new sparse error is also addressed in this patch.
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > ---
> >  include/linux/sched.h | 2 +-
> >  kernel/signal.c       | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index b511e178a89f..7a351360ad54 100644
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
> > index bcd46f547db3..1272def37462 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1383,7 +1383,8 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
> >  		 * must see ->sighand == NULL.
> >  		 */
> >  		spin_lock_irqsave(&sighand->siglock, *flags);
> > -		if (likely(sighand == tsk->sighand))
> > +		if (likely(sighand == rcu_dereference_protected(tsk->sighand,
> > +						lockdep_is_held(&sighand->siglock))))
> 
> Given that the return value is never dereferenced, you can use
> rcu_access_pointer(), which may be used outside of an RCU read-side
> critical section, and thus does not need the lockdep_is_held().  So this
> change would save a line of code and would be a bit easier on the eyes.
>
Okay got it! I will send the updated patch soon.

Thank you,
Madhuparna
> 							Thanx, Paul
> 
> >  			break;
> >  		spin_unlock_irqrestore(&sighand->siglock, *flags);
> >  	}
> > -- 
> > 2.17.1
> > 
