Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4C8C433F5
	for <rcu@archiver.kernel.org>; Fri, 22 Oct 2021 13:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8203F610EA
	for <rcu@archiver.kernel.org>; Fri, 22 Oct 2021 13:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJVNUU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Oct 2021 09:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhJVNUT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Oct 2021 09:20:19 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAF8C061764
        for <rcu@vger.kernel.org>; Fri, 22 Oct 2021 06:18:02 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t4so4967442oie.5
        for <rcu@vger.kernel.org>; Fri, 22 Oct 2021 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forshee.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aM8dySK9vu9vyTupXxbpsPOCx1mnlRJ6fYM+TsOXTQw=;
        b=T2X/b5xCsTsyA4ILUiYLbM0B1KNN+EexGx19Guczk+8VyGR8MUm81no1kClgQmVr9b
         n7cR10if+ynCc4Dlpkabgl2ryop2yFSpEff7qJVEJIN6yhFP2VpwaNrQPBrbMLb12v2M
         MJ+xQgRG/HkGJqFt6Tecmqk/DV3fMdj1q8pd9wbNVESyPux5/z/J35ljFVWu2KjIuEo7
         ii9R2RXJKZ0IQWooo/egEIwNECILpdxa9b8AWk+CLFmgCL9bO61sAa3sYL4NQhfE6+om
         Fpk/O2pntcGMe1K/73YeCq9lrIN03/wF1oR3l7zaCstHgxRMNHuakdUeCBaYpLPHewL+
         Ikrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aM8dySK9vu9vyTupXxbpsPOCx1mnlRJ6fYM+TsOXTQw=;
        b=kvCk/NkVQkT2t2DGieYLoEnGD5cQwaH8+bToQsWXccT3Z+RCKxItCbKp9/yJ54px8b
         v+YhQ2TTwTTidtSh5Mbiv+tHJry7O1w6cr1jYmHHwR7t9ZWbQ34OjsCxbo5ytQx00aAL
         /XyNaMLwTITkOlWCcLkH8n2F8fOQtz31pUYbBWSA71rHEILdmjWz0DwIe4klUSIN7C4R
         xPjPO0a+l2zCdSbGlBSoAOeaPTUud997KZgFE8flGIG73yOBoypXawDa8yc0BuHc3Ezz
         r9ZwJ0+DDOXmYEygkUC3a5bfl5j3tk6inTjGZbhhqmg3tAEw1XSKj6Y7qUWUerL+x3pw
         p16A==
X-Gm-Message-State: AOAM532VWkv/vpCHjCYBmHxKCRCiXxbWR44wxSlVkdOauZNwXav747i/
        IAlcYvKIUHqgOLi4qr4ZiamUgA==
X-Google-Smtp-Source: ABdhPJwrSTJuoSc5Ir+3FfIw6oEY0dpcJ0vezB1wDS556c16FMIsFGvRdACAdibd0Q39k4YXUowi9w==
X-Received: by 2002:aca:c288:: with SMTP id s130mr9840517oif.138.1634908681468;
        Fri, 22 Oct 2021 06:18:01 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:12a9:d5f6:9bd1:6937])
        by smtp.gmail.com with ESMTPSA id s5sm1964419ois.55.2021.10.22.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:18:00 -0700 (PDT)
Date:   Fri, 22 Oct 2021 08:17:59 -0500
From:   Seth Forshee <seth@forshee.me>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org
Subject: Re: Improving RCU wait in mini_qdisc_pair_swap()
Message-ID: <YXK6B8bCQGWRypef@ubuntu-x1>
References: <YXCIrNiLY5kMmcSI@ubuntu-x1>
 <20211020224430.GO880162@paulmck-ThinkPad-P17-Gen-1>
 <YXF1+qMXukbnf3gr@ubuntu-x1>
 <20211021175537.GU880162@paulmck-ThinkPad-P17-Gen-1>
 <YXHYuYnm1nrUTkuW@ubuntu-x1>
 <20211021222435.GW880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021222435.GW880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 21, 2021 at 03:24:35PM -0700, Paul E. McKenney wrote:
> > > > > So you can let the heavy real-time workloads
> > > > > have slowish Qdisc switching and IPI the IPI-insensitive workloads:
> > > > > 
> > > > > 	oldstate = start_poll_synchronize_rcu();
> > > > > 
> > > > > 	// do something.
> > > > > 
> > > > > 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > > > 		cond_synchronize_rcu(oldstate);
> > > > > 	else if (!poll_state_synchronize_rcu(oldstate))
> > > > > 		synchronize_rcu_expedited();
> > > > 
> > > > I was concerned about the system-wide impact synchronize_rcu_expedited()
> > > > has, but this at least avoids doing it if it's unnecessary. If it's bad
> > > > form to leave mini_Qdisc.rcu_state initialized to 0, this option is
> > > > preferable from my perspective.
> > > 
> > > This might well be the best approach if multiple swaps are at all common.
> > > 
> > > But if needed, we really could do both:  Make initial swaps really fast,
> > > and improve the performance of later swaps.
> > 
> > Using this the time for mini_qdisc_pair_swap() to complete was similar
> > to my earlier patch with mini_Qdisc.rcu_state initialized to 0. So this
> > seems acceptible for my purposes.
> 
> Not sure which approach "this" refers to.  For the moment, I am assuming
> the last code fragment shown above.

Yes, that is correct. Apologies that I wasn't clear.

> > > > > Yet another approach is this:
> > > > > 
> > > > > 	oldstate = start_poll_synchronize_rcu();
> > > > > 
> > > > > 	// do something.
> > > > > 
> > > > > 	while (!poll_state_synchronize_rcu(oldstate))
> > > > > 		schedule_timeout_idle(1);
> > > > > 
> > > > > The advantage of this one is that you get credit for partial progress
> > > > > through grace periods, but it won't be anywhere near as fast as
> > > > > synchronize_rcu_expedited().
> > > > 
> > > > If we need to initialize mini_Qdisc.rcu_state up front this approach
> > > > probably won't improve things much for my problem.
> > > 
> > > It all depends on how long between swaps.  ;-)
> > 
> > This approach helps, but I still see about 50% of the
> > mini_qdisc_pair_swap() calls taking tens of milliseconds. This is
> > similar to what I saw using cond_synchronize_rcu() with rcu_state
> > initialized from get_state_synchronize_rcu().
> 
> OK, which means that the swaps are too closely spaced to get much
> benefit about 50% of the time.

Yes, or in my case it's the time between mini_qdisc_pair_init() and the
first swap, which is why initializing rcu_state to 0 helped before.

> > Wouldn't this also behave very poorly in the wrapping case you mentioned
> > above?
> 
> I confess, I have no idea what case is the "wrapping case".

This question was based on a misunderstanding on my part, you can ignore
it.

> But any implementation that needs to wait for a full normal
> (non-expedited) grace period will suffer at least 50% of the time
> when running your workload.  And of the above code fragments, only the
> synchronize_rcu_expedited() variants avoid waiting for a full normal
> grace period.
> 
> > In the end, I'm happy to move forward using synchronize_rcu_expedited().
> > I'm going to test a bit more, and I should have a patch out sometime
> > tomorrow.
> 
> Works for me!  At least given the CONFIG_PREEMPT_RT check.

Yes, I included that check.

Thanks,
Seth
