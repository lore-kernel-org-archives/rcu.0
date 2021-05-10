Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE2C433B4
	for <rcu@archiver.kernel.org>; Mon, 10 May 2021 10:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5AC613AF
	for <rcu@archiver.kernel.org>; Mon, 10 May 2021 10:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEJKKL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 May 2021 06:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJKKK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 May 2021 06:10:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56357C061574;
        Mon, 10 May 2021 03:09:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m11so6067656lfg.3;
        Mon, 10 May 2021 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0LOLJf4NELTeN88Cp5IZblgLz2ynJBm7Lo6dCI4QmY=;
        b=U22GdFAp6GV5W1SWd17smnRmeJWW5Muf966MLaSSeBYQArR3gZnPoAztB9626gDLwV
         ZG13r/aaLGTi5MrZd4H6pywv9hYLFl1oryuTiOtBlZX5zbb5gDHoOm9wHd7F4alaFdVl
         oFBhSHOSM/Bn8fQMtUTNzEZ+DB7aJbOAqtjZpcGbXKWMyGv8OgVpFG62ge46DY/gJ4tl
         xRNCkrURBkI+KTmPKbdymDtLlWA+JmtVvuRNdz69c4Y2SQ5rXlG9pVNZugiIdwNyCYhL
         phW3laEqPn2VZMw8DeKEyhEOYocl1zse9a+S46XfnGwTlHJJMGJYyFk6tOzMM1caOhaZ
         TGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0LOLJf4NELTeN88Cp5IZblgLz2ynJBm7Lo6dCI4QmY=;
        b=j0gVuI6mgh2GAxTBIYyXpojU+jbbIjRpkI7mxz/qi/CUN151cbih0Q1dMPqlpZtpj7
         Rd9m6AD9lv3JNugCdw2kaeSrWx9WC4MydRC2Svyxe/bSYSOmVxADf3b49undQrmK4Tgv
         lmtiQU3UCH/5ogTs6ILufnlO+2qlz3SHsU6bXO/mgod2pnrbCzQZqqgOTh/x9sm6P+rA
         yIxOY+AuRebhEVIQsEwSk77ImjdVklHb9sNcV6KbvanLTFGa+R7XpBrD6I901ddcwntg
         J/opzHEQZTmcr26LDv9c9h2+YvND2nqRaZSbT0QCYMWaAV9gJ0NYzWA0+qt0qbU2+bKk
         qPjQ==
X-Gm-Message-State: AOAM533KWEhn0hDFpiiGKyYVNDhd9+3DFaNpwx199D4pTom8zLh/aI1P
        DbJOLpQC8DYDTrcpHd06HjQ=
X-Google-Smtp-Source: ABdhPJwCdLdAk3miHXGdXJjhG6QtXR/cGKt74SaASdNE8kmYh5ZO2kZs3po/siQCQo4AduyiziNZLg==
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr14025327lfe.51.1620641343900;
        Mon, 10 May 2021 03:09:03 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id x26sm3173576ljj.46.2021.05.10.03.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:09:03 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 10 May 2021 12:09:01 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 4/5] kvfree_rcu: Refactor kfree_rcu_monitor() function
Message-ID: <20210510100901.GA2019@pc638.lan>
References: <20210428134422.1894-1-urezki@gmail.com>
 <20210428134422.1894-4-urezki@gmail.com>
 <20210509165954.347dd3cd8e8815b9dce67cfb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509165954.347dd3cd8e8815b9dce67cfb@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 09, 2021 at 04:59:54PM -0700, Andrew Morton wrote:
> On Wed, 28 Apr 2021 15:44:21 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > Rearm the monitor work directly from its own function that
> > is kfree_rcu_monitor(). So this patch puts the invocation
> > timing control in one place.
> >
> > ...
> >
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3415,37 +3415,44 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> >  	return !repeat;
> >  }
> >  
> > -static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> > -					  unsigned long flags)
> > +/*
> > + * This function queues a new batch. If success or nothing to
> > + * drain it returns 1. Otherwise 0 is returned indicating that
> > + * a reclaim kthread has not processed a previous batch.
> > + */
> > +static inline int kfree_rcu_drain(struct kfree_rcu_cpu *krcp)
> >  {
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	raw_spin_lock_irqsave(&krcp->lock, flags);
> > +
> >  	// Attempt to start a new batch.
> > -	if (queue_kfree_rcu_work(krcp)) {
> > +	ret = queue_kfree_rcu_work(krcp);
> 
> This code has changed slightly in mainline.  Can you please redo,
> retest and resend?
> 
> > +	if (ret)
> >  		// Success! Our job is done here.
> >  		krcp->monitor_todo = false;
> > -		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > -		return;
> > -	}
> 
> It's conventional to retain the braces here, otherwise the code looks
> weird.  Unless you're a python programmer ;)
> 
> 
Hello, Anrew.

This refactoring is not up to date and is obsolete, instead we have done 
bigger rework of kfree_rcu_monitor(). It is located here:

https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu/+/2349a35d39e7af5eef9064cbd0e42309040551da%5E%21/#F0

--
Vlad Rezki
