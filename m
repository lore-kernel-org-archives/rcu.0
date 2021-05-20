Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2135C433ED
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 05:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1F6610CC
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 05:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhETFwS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 May 2021 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhETFwR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 May 2021 01:52:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA1FC061574
        for <rcu@vger.kernel.org>; Wed, 19 May 2021 22:50:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a11so8377073plh.3
        for <rcu@vger.kernel.org>; Wed, 19 May 2021 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5j8UDwTOGX/Y+8tKiT9hVDcgkDZBbrwX9nQahsRpL+w=;
        b=CQYXIJEsLnEsHjq5fYQw+hBYhQQvNaIDKw4c0IpN+3o1C9G3b643NHwKG0H7f8vnHO
         cEAxSmHKaUZ0aPzorSm+Qd67aZ79QzF6tIIQIhHbrqNGGfmZySaOgzoAeXH/QmhaVvwf
         P5Z66/JRoRTX5eR8pNVg5PDT6MhKKseTc2vmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5j8UDwTOGX/Y+8tKiT9hVDcgkDZBbrwX9nQahsRpL+w=;
        b=UKQ9d65HdDP956RCcejGxqnjCqAlFylyBuZQqkNJFvr/qhS5zPjvtZlv9X7qW24dVW
         EvNM02cdje/Wa+cHRp85kEhEqU96NEcXVAM6OB0cPGcc9qRuyWbGYSc04YG8VNj3lU/G
         8m5wXrYIi6YwmxAJvAuuEdloVJ1io/1MeR/HvOYN3Jr3aI2hsjoWeeUDC8HpmKprZZ0E
         rLn57Ds3S1LawqoZ41FTjnCSKh7U6jwoTAzQGB1mLZjx5e/PVxG4wyp2FtZjMnqJGXAp
         foLYhFL9ay3GKfvN9wiHvHydrF4/pjXqs6PKjR4nAd3tRXwPEmXehdNeBG6+RHz7A+yZ
         tj7A==
X-Gm-Message-State: AOAM530fJ/N3Eg5eZ0Hi9261mIMFRou1B0n5I6K6HQnHUj4avMmZQSk4
        ATrTabb19RzJw1U+MJzAJk4QJA==
X-Google-Smtp-Source: ABdhPJxVLVnGYXgiGDwNIEKr8UyrWbgUqr/T81FZBGliRXJyMSYeTvKb5deEFZQQIQKcNgyoWauI+Q==
X-Received: by 2002:a17:90a:fed:: with SMTP id 100mr3077336pjz.89.1621489855077;
        Wed, 19 May 2021 22:50:55 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:48db:abf:343e:b4f7])
        by smtp.gmail.com with ESMTPSA id 63sm925774pfz.26.2021.05.19.22.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 22:50:54 -0700 (PDT)
Date:   Thu, 20 May 2021 14:50:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <YKX4ueNIabfd1DAD@google.com>
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On (21/05/18 16:15), Paul E. McKenney wrote:
> 
> In the shorter term...  PVCLOCK_GUEST_STOPPED is mostly for things like
> guest migration and debugger breakpoints, correct?

Our use case is a bit different. We suspend VM when user puts the host
system into sleep (which can happen multiple times a day).

> Either way, I am wondering if rcu_cpu_stall_reset() should take a lighter
> touch.  Right now, it effectively disables all stalls for the current grace
> period. Why not make it restart the stall timeout when the stoppage is detected?

Sounds good. I can cook a patch and run some tests.
Or do you want to send a patch?

> The strange thing is that unless something is updating the jiffies counter
> to make it look like the system was up during the stoppage time interval,
> there should be no reason to tell RCU anything.  Is the jiffies counter
> updated in this manner?  (Not seeing it right offhand, but I don't claim
> to be familiar with this code.)

VCPUs are not resumed all at once. It's up to the host to schedule VCPUs
for execution. So, for example, when we resume VCPU-3 and it discovers
this_cpu PVCLOCK_GUEST_STOPPED, other VCPUs, e.g. VCPU-0, can already be
resumed, up and running processing timer interrupts and adding ticks to
jiffies.

I can reproduce it.
While VCPU-2 has PVCLOCK_GUEST_STOPPED set (resuming) and is in
check_cpu_stall(), the VCPU-3 is executing:

	apic_timer_interrupt()
	 tick_irq_enter()
	  tick_do_update_jiffies64()
	   do_timer()
