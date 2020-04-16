Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CF1C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23E72087E
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="F7hY3cFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgDPSxP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgDPSxO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 14:53:14 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9489C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 11:53:13 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id fb4so2579673qvb.7
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MXIzhYQ02z6U9ucfnP512Br4ugatco3qntcOc8zwd8g=;
        b=F7hY3cFi7HDrbRgmqhg4O1O4JGKysGC+5zQUua/qm74jV7fYWc/LZi0MXueVo+vJXf
         fyJ27e8FJQ6OYhgw/mAgVTQbGw/xBLsQnaGFiapiKwrDtvwefEQWmOE3sf5bRtcYEhgQ
         NjJCm+C/5cyC5NbSziJrEn/fGo0Ty3QOaF18w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXIzhYQ02z6U9ucfnP512Br4ugatco3qntcOc8zwd8g=;
        b=BmRm0Z1JUH4IzAeYWsoyyiZ84xIodtzoCcYTMaHPV29gm+i+CYA/lS+i1OfLENi69c
         Z5IooN/+3p/0bb01lf1IPAnPkvaKR9HAsx0gV3DvBR0EMcfGkfkWBfr/TfQa2K89VDAZ
         36/d6gmyOV0sx3Dgc3YDEevOIVc/2yC8bDTtna4QJTothjttnA9b7wazb0WWyr7WEWt0
         Khvqlqax0JpPoQObTM3Ey7/Fkr3hjHWdWS17l/tmB525CuAdrCRDoggBGOWbO1au5FBy
         +/RSx+izHJK/pKc643WoF9PEQVzXXTkiSRQndyAlE1al1WvnDZbIyKKI0Y0YU0AC+K6Z
         ywEg==
X-Gm-Message-State: AGi0PuY25yBr4zOJ6tPFrlGahg0W+DiwYsMCUoSzTAWTvv5J0AlhRJgW
        M7K88WTc63Lg7C6sebYEno7qQw==
X-Google-Smtp-Source: APiQypLtGfphTbknjCQ/mrRpAHUmvDy2ikgRJNM0cMBVQOgo+uqzu1mgvGfzIHDFsb3gGFyYBE12/Q==
X-Received: by 2002:ad4:5051:: with SMTP id m17mr11909993qvq.122.1587063193065;
        Thu, 16 Apr 2020 11:53:13 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o7sm3014586qkh.76.2020.04.16.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 11:53:12 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:53:12 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416185312.GC149999@google.com>
References: <20200416144254.GC90777@google.com>
 <20200416150038.GA7772@pc636>
 <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
 <20200416153844.GA8191@pc636>
 <20200416154647.ceotefna34pdxpfi@linutronix.de>
 <20200416160129.GA8337@pc636>
 <20200416161149.lkvkfwevanff36kb@linutronix.de>
 <20200416161819.GA8551@pc636>
 <20200416163302.3fsroillwk2om5dh@linutronix.de>
 <20200416144002.5ba92b4a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416144002.5ba92b4a@gandalf.local.home>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 02:40:02PM -0400, Steven Rostedt wrote:
> On Thu, 16 Apr 2020 18:33:02 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > > > > You mean that in CONFIG_PREEMPT_RT:
> > > > > 
> > > > > <snip>
> > > > >  local_irq_save(flags);
> > > > >  krcp = this_cpu_ptr(&krc);
> > > > >  spin_lock(&krcp->lock);
> > > > > <snip>
> > > > > 
> > > > > it will not be preempted, what does not follow PREEMPT_RT policy. Is that correct?  
> > > > 
> > > > No. local_irq_save() disables interrupts and spin_lock() acquires a
> > > > sleeping lock which may schedule() if contended. The documentation has
> > > > this piece:
> > > >  
> > > Ah. Got it. Then it is a problem, agree. Do you have something
> > > that would guarantee of being staying on the same CPU?
> > > migration_disable()?  
> > 
> > migrate_disable() would work.
> 
> I wonder if we should have a this_cpu_spin_lock_irqsave(), that would
> encapsulate the migrate_disable()?
> 
> static inline this_cpu_spin_lock_irqsave(struct spinlock __per_cpu *lock)
> {
> 	migrate_disable();
> 	spin_lock_irqsave(this_cpu_ptr(lock));
> 	migrate_enable();
> }

Here we want to grab the pointer of a per-CPU structure for the local CPU,
and then grab its lock at the same time without getting migrated, so at least
for this code the above API, it may not fit properly but perhaps for other
code it may.

thanks,

 - Joel

