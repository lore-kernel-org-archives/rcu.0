Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3462C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6BD20771
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 16:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhnjE7i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgDPQSa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729188AbgDPQS3 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 12:18:29 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7392FC061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 09:18:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r7so8404930ljg.13
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+iYVRKV/3P4zMUCpdNdIeeL+DYcXfngPb0WdFa1g18g=;
        b=lhnjE7i0lBsMP/SekN+0fMKOaugrR86yzcd0RT+tKQMOdOhHFNbnLMHhvZn8Q7uOV8
         HT/7CTMzAz0hGUMNgGC02pmCAP2/Ar5L1CEFh9ezRqfLX+hSALseNr7T2Fn4WZZ7B9Zh
         4G/vET859pZOVgmTBsdDmpMFYKe7u4Cp9JydTRJRXKaJTujsDfyJUBdV0pfDDscecVlv
         BxT01QE24dRm151SlnU+o5NIsX/47NO+znGsDYy+72PjYZKbPEAjGYd9wbU18B4UreSK
         p/p+VN3Hw3iRg1LzOg4SeJTKeHH2gzNySD6+e/oCwtfx3pxVhqxxd48AbQwcmmbyLMg+
         53Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+iYVRKV/3P4zMUCpdNdIeeL+DYcXfngPb0WdFa1g18g=;
        b=ELgb/3tVRbcNqggP6COkTS4qvTGxO+dcUAafMTdvwsYWAamzcsh4D8wh9EBzVY14N+
         idjs+T7tigwpzTqZ+B6OZO30twSmFCoWCq17H9l60Y9G8A+O2Rhh/CILi/kf0j9dGerd
         pTzJXtqKtpIqw+0tqIbdur+IURug+k/Y7X+8SIk7OSS2o1MEsPfuhQ6fAr9oaTxORyTL
         V27wxixoAFY/9CmxPII5ouEOUX6cPGkc63UWVv74Jr4UdsguUpIrrYz04LsFoMU8AMN6
         MX6Lva2RO5KCHrtDTmMpjulCiMqa5Y2yExTwE3OZZZAWtHOGiXQlmRsCWG+s8TXhVLNz
         hYdQ==
X-Gm-Message-State: AGi0PuZuLXTmJr1HmKKS2CTFuq+6j6gM+DgTD+jLAcfYduslBR4McYh5
        FrGl3WBbu+rnOEfGDqhwSso=
X-Google-Smtp-Source: APiQypI6A+CEzunDg3IC1iFJSGyoBefJGbfHFyV5s7HTSLkWnniSBfTEyV1YwyYIQKgH5FmX8F7mbA==
X-Received: by 2002:a05:651c:208:: with SMTP id y8mr6618883ljn.280.1587053906962;
        Thu, 16 Apr 2020 09:18:26 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id e8sm1013662ljg.44.2020.04.16.09.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:18:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Apr 2020 18:18:19 +0200
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
Message-ID: <20200416161819.GA8551@pc636>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416150038.GA7772@pc636>
 <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
 <20200416153844.GA8191@pc636>
 <20200416154647.ceotefna34pdxpfi@linutronix.de>
 <20200416160129.GA8337@pc636>
 <20200416161149.lkvkfwevanff36kb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416161149.lkvkfwevanff36kb@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 06:11:49PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-16 18:01:29 [+0200], Uladzislau Rezki wrote:
> > > As written in my previous email to Joel (who somehow fell of the Cc
> > > list in this part of the thread):
> > > |local_irq_save() + spin_lock() is the problem, see
> > > |    https://www.kernel.org/doc/html/latest/locking/locktypes.html#spinlock-t-and-rwlock-t
> > > 
> > You mean that in CONFIG_PREEMPT_RT:
> > 
> > <snip>
> >  local_irq_save(flags);
> >  krcp = this_cpu_ptr(&krc);
> >  spin_lock(&krcp->lock);
> > <snip>
> > 
> > it will not be preempted, what does not follow PREEMPT_RT policy. Is that correct?
> 
> No. local_irq_save() disables interrupts and spin_lock() acquires a
> sleeping lock which may schedule() if contended. The documentation has
> this piece:
>
Ah. Got it. Then it is a problem, agree. Do you have something
that would guarantee of being staying on the same CPU?
migration_disable()?

Thanks!

--
Vlad Rezki
