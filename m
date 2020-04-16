Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23EEC2BB85
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01B9214AF
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdDFzriB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636564AbgDPQBn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636511AbgDPQBk (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 12:01:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D669C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 09:01:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so8427583ljd.3
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZKKD8xuSYziYlz3ec/1tQRvvTmwps39q0IogmB718B8=;
        b=bdDFzriBf9FhPJcBVJ6tpG9ClRLyN4gEDObULOqg6vs5YFdMkm5XddqfUaIGODwRkV
         6DVbG94pHWIiE2nTA/raMXJtz+EAFo3EhXF1hoDG9iqz6Z/USNE+/+r9KkdR0rtfw7h/
         u7ZY0mr6bz3kjLZZki6YihN1L8+7sLeDTXJKyIcttbQL3BGnMU52U/+VzspOW2yJ2L6+
         dNweLcwq/DAyhB4v3y2RtU8WMfFh6ZAj1TvQ+/dce2yr0ohj+T3c3L9QYDfhMCvm2WbI
         f9zcs29jP0y26pL8oBmCyUhk3G0BaSRyqmyoTXykLE7EFMjdExR3MJBUjVmrXxAQiEQq
         PHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZKKD8xuSYziYlz3ec/1tQRvvTmwps39q0IogmB718B8=;
        b=kX/SVXjppeLyDucIAqA1zQPlvoRHHQZAPkzbKLPkNnvqfGX/qaRnGpdRZXLPrYKFDX
         5QZwLfsKHEZjOwmlqbivxVwWwmoZ4GHAgvM8rbSzB9sxDw1nL+AAS3y7UZpTIodbgPDF
         V+5ypOwIZkUzrgjcAlMkERAty0UKb7lgHvaAVmzsK64K7EDlLgbO7rlR7PqhNX5LKotW
         0coKgLLmnlGmM8r0ElDwKgBV2iqas3gbc34cygt6FhWMKrliHUr/skEMjjBnmuqY0jzr
         xZkmY0Zb/RH6mQfwY2pyfj+i2X13vi0KPlsWQsGyP2ABdf5UZpIA4A5egM692XW9dQgi
         39Zw==
X-Gm-Message-State: AGi0PuYXj6V+zSGLLXizVXmHZip6gXQr5MZvrFtOJzwpLaI+yDv7Ftmi
        QgU6kJvMgIrNmlpGQ0+hR5M=
X-Google-Smtp-Source: APiQypJBM4WCWZSY7lRteTzfJ0kbw8DH1oG9kiXu3ONdKruEp+bDbsk1iuk17nEGySkIEkYb181cng==
X-Received: by 2002:a05:651c:208:: with SMTP id y8mr6577536ljn.280.1587052898541;
        Thu, 16 Apr 2020 09:01:38 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 14sm15296346lfz.8.2020.04.16.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:01:37 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Apr 2020 18:01:29 +0200
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
Message-ID: <20200416160129.GA8337@pc636>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416150038.GA7772@pc636>
 <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
 <20200416153844.GA8191@pc636>
 <20200416154647.ceotefna34pdxpfi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416154647.ceotefna34pdxpfi@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On 2020-04-16 17:38:44 [+0200], Uladzislau Rezki wrote:
> > > What is the worst thing that can happen if a CPU migration happens
> > > between raw_cpu_ptr() and spin_lock_irqsave() ?
> > > 
> > You will just introduce higher rate of lock contention what we would
> > like to get rid of. 
> 
> The possibility of the migration is minimal. So it is not _always_
> happening.
> 
Agree, it is minimal. But if possible the possibility should be 0 :)

> >                     Could you please explain what is broken when you
> > do like:
> > 
> > <snip>
> > local_irq_save(flags);
> > krcp = this_cpu_ptr(&krc);
> > spin_lock(&krcp->lock);
> > <snip>
> 
> As written in my previous email to Joel (who somehow fell of the Cc
> list in this part of the thread):
> |local_irq_save() + spin_lock() is the problem, see
> |    https://www.kernel.org/doc/html/latest/locking/locktypes.html#spinlock-t-and-rwlock-t
> 
You mean that in CONFIG_PREEMPT_RT:

<snip>
 local_irq_save(flags);
 krcp = this_cpu_ptr(&krc);
 spin_lock(&krcp->lock);
<snip>

it will not be preempted, what does not follow PREEMPT_RT policy. Is that correct?

--
Vlad Rezki
