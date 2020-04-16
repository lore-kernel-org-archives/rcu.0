Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD544C2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 20:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A804C221F4
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 20:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gR4wB0C9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgDPUlR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727887AbgDPUlR (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 16:41:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39A8C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 13:41:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s63so108326qke.4
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qKp0IFlvT6wk/WxbeObtqZRVf5Dc9U7t1MCdcfHwesM=;
        b=gR4wB0C9Pme5X7bFrN01nRhsXwfDEq2yVvEC361yIsisQpOpAAU5Av22/Sc/7fU+IS
         yJT43BSM1X953P6YwDpA3bFWdDgtsaN9HdfUEMgWZwq4C7Zfslw5+tgqwyfwZhn3ZKb4
         rGWVpIDiD35UfzP0Lp0EQkL4IXep4B6O1nOOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qKp0IFlvT6wk/WxbeObtqZRVf5Dc9U7t1MCdcfHwesM=;
        b=tgumv9PTaKTv+MFtwRyhVF8zaQhiHXo0QC7Da+zlTMNPAvXGJKSKJ8YIsSIuaS+zJD
         kYiJjE5HH2CBokpyNHSm7r6x21dRcIcLIu6ZX2vS21JufzOSVwCSnbdJlHRUcpPPgXgK
         ZSrvMIpjnD7izc2AeBr5exjccyGLvlfayMlV7fHN9v4CRTggKjm5FmCVUYM9SpCbDKQJ
         ie9TsASNC0PbwNSORjc9plMgDWoZ1qIyNSc4QNDkDhNqWuFpSqigbWpQwaPBinWchg2Q
         PItmfKh0zJZ0qvkaT8ZcNgP10l/3BEDF7MGwEetKAIl7karLLHKIJjWbzN1HBlQ9iPt5
         U7YQ==
X-Gm-Message-State: AGi0PuZ90aGymzmlCxBOQHDxKXdslHGxwukm9YA1FmmyyHrqZnvEFTn5
        8h1ko4QA+cMBXifTomukwuE3kg==
X-Google-Smtp-Source: APiQypJjuN168GZ4uTtxz3N9icyKLE27oRVl9WI7AeI0BTjVDUfgAYUDUBl3StylfovLTQXG1n4yCQ==
X-Received: by 2002:a37:7143:: with SMTP id m64mr21666503qkc.215.1587069675975;
        Thu, 16 Apr 2020 13:41:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r9sm15261254qke.5.2020.04.16.13.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:41:15 -0700 (PDT)
Date:   Thu, 16 Apr 2020 16:41:15 -0400
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
Message-ID: <20200416204115.GB176663@google.com>
References: <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
 <20200416153844.GA8191@pc636>
 <20200416154647.ceotefna34pdxpfi@linutronix.de>
 <20200416160129.GA8337@pc636>
 <20200416161149.lkvkfwevanff36kb@linutronix.de>
 <20200416161819.GA8551@pc636>
 <20200416163302.3fsroillwk2om5dh@linutronix.de>
 <20200416144002.5ba92b4a@gandalf.local.home>
 <20200416185312.GC149999@google.com>
 <20200416152400.3b2c6f91@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416152400.3b2c6f91@gandalf.local.home>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 03:24:00PM -0400, Steven Rostedt wrote:
> On Thu, 16 Apr 2020 14:53:12 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > > static inline this_cpu_spin_lock_irqsave(struct spinlock __per_cpu *lock)
> > > {
> > > 	migrate_disable();
> > > 	spin_lock_irqsave(this_cpu_ptr(lock));
> > > 	migrate_enable();
> > > }  
> > 
> > Here we want to grab the pointer of a per-CPU structure for the local CPU,
> > and then grab its lock at the same time without getting migrated, so at least
> > for this code the above API, it may not fit properly but perhaps for other
> > code it may.
> 
> 	this_cpu_spin_lock_irqsave(&krc.lock);
> 	krcp = this_cpu_ptr(&krc);

Apologies, I forgot that its perfectly Ok to access per CPU oject's
elements this way without first grabbing the per CPU object's base pointer.
All that matters is the offset within the object is biased to whichever CPU's
per-cpu area.

It could be called this_cpu_raw_spin_lock_irqsave() if we don't want it to
grab rtmutex on -rt :-)

> Note, spin_lock() disables migration, even on PREEMPT_RT.

Makes sense.

thanks,

 - Joel


