Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DA1C2BB85
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA7E22246
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 15:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMdTVcCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395391AbgDPPi5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395385AbgDPPiw (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 11:38:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B31C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 08:38:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so8342992ljd.3
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YFdxgWMwM2aOnbxFGUIdQZYeh6tELOUV4wkDg2OpmXY=;
        b=lMdTVcCxUtjsSNyWMDBBjHDi6f27HGS3AFZAd6KE4icixWKj+FQY/jGctJ+7v3qz5P
         GlzMQ7QuM777rsTXfOgGbd/ms6alAfytdf/2UrK8FAX6Ibgdp/8emg5E4oqOavpqTCK6
         10UyIXaxkwJXu8Y7iKizHYiJigC6pa1YyI846A+BnAZQeq1ZsiXNw92XMuNTcGExy59+
         xev/VNohXYFb7Kw+1vOE7ey97e2swAXNOKf7TAAuH7GD3JjYN95mW3idwni6ItdPUQtH
         lCSYmv+xZR6UUXRDmns6yPoNCkRo12U0Ou53ecaKuCPVSVSh/Jdc3saBCFbnksd98UGf
         uIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YFdxgWMwM2aOnbxFGUIdQZYeh6tELOUV4wkDg2OpmXY=;
        b=rep3wVtF9uayXL/9ylCyy+F+e7fK2EK7X7L59n9EXu//1CFZ4j4kTiFMogf7l/fSx3
         g1ZnmVs/+6HUnXKdkTjgywYCAlXYBUDhUbE9EIwObY65t4Fw5RwIvQggOBwH8LAIp4bT
         kI6ZRFiis9YFJvebxCgeti0EKukQOTcjcYS551SUx8WIOMU8WHbi58Rx9orTV/tWZIse
         lZVpXp8QQJAkpArhZ87cNb5U90JWY/l5UPiFllapGZrVVSZD+yCwvElOZdROj120i1UT
         yy1tvJVJ5lRFZw93wfeOFWaZIuXx0VgdE8XpKZUtLPh4kKrLc2Yd2B9MEErjUslkdLsm
         lMPg==
X-Gm-Message-State: AGi0PuYoG/vUHWCwTF03ZdxO/Lv9OqxhjJFyVtzOVTIzsa7ZlHqEpYjU
        ID/6f3P1/R9hdCYJTl4a9yk=
X-Google-Smtp-Source: APiQypKGgF2KFaiQO5MAjewSUPD7HONJmI9GHObtl7whJ+4Nnq8AuDwQvmvY/sXLeQ4oUf6SnJ+2EQ==
X-Received: by 2002:a2e:a549:: with SMTP id e9mr6870994ljn.28.1587051530787;
        Thu, 16 Apr 2020 08:38:50 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z23sm14061545ljz.52.2020.04.16.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:38:50 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Apr 2020 17:38:44 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416153844.GA8191@pc636>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416150038.GA7772@pc636>
 <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sebastian,

> On 2020-04-16 17:01:43 [+0200], Uladzislau Rezki wrote:
> > > > @@ -3139,10 +3136,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  	unsigned long flags;
> > > >  	struct kfree_rcu_cpu *krcp;
> > > >  
> > > > -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> > > > -	krcp = this_cpu_ptr(&krc);
> > > > -	if (krcp->initialized)
> > > > -		spin_lock(&krcp->lock);
> > > > +	krcp = raw_cpu_ptr(&krc);
> > > > +	spin_lock_irqsave(&krcp->lock, flags);
> > > 
> > It is not a good way to access to per-CPU variable. There is a race in
> > your code. So, we will rework it anyway soon. To guarantee that we stay
> > on the same CPU, first we disable IRQ's then we access per-CPU var and
> > take a spinlock.
> 
> What is the worst thing that can happen if a CPU migration happens
> between raw_cpu_ptr() and spin_lock_irqsave() ?
> 
You will just introduce higher rate of lock contention what we would
like to get rid of. Could you please explain what is broken when you
do like:

<snip>
local_irq_save(flags);
krcp = this_cpu_ptr(&krc);
spin_lock(&krcp->lock);
<snip>

Thanks!

--
Vlad Rezki
