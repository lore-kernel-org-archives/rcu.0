Return-Path: <SRS0=HY8l=A2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9089DC433E3
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 19:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D8820657
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 19:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJrZs7DM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGOTCz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGOTCw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jul 2020 15:02:52 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2E3C08C5CE;
        Wed, 15 Jul 2020 12:02:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so3813946ljn.8;
        Wed, 15 Jul 2020 12:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=24j8BD/rk1NCezefIEXui0kY0H9CcCq5N57TnMuH0Cs=;
        b=AJrZs7DMub0Mmpklzzn+wMRqarleeITlOdNdHKFOGnsjGhIvg4RadvozaRFCXFQaJf
         X77nBWccXJek+u3muNeIFHurc3tLJTbykuiahETAXS+gBNBxh/1qZIvzu0n/yLjWbTFd
         gTqke7t3gVWxGkDBg1n59jGgmPKYfm3waBnYTyT/+d9CybsSSF7jH1WAnT1VsYCrMq7+
         37ewHdUaA8AAUWwJxjG+kVaQCxiyDm1c6CeIxVRz02hYonygKPpWGfOZRVqYFdEp95Ct
         PF1kNoHJn7JwFn/IXryaMa9RbAlLyZNvqdqsuHP8Q/5m1GS5nDS19yKIXHt8E5N+4vgX
         GJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=24j8BD/rk1NCezefIEXui0kY0H9CcCq5N57TnMuH0Cs=;
        b=C3/NeDUJyUfUY86XotiYggGLKChXyDpi76Esn3K4JL+PuPwBptWYUtSZnd5amEIYC2
         mcHlIcLtveAgAaSCjVKG9aLSgzTSxiNfVVkwtezniRFV+CLSq0c7kVacPjIw06c8j7Mr
         HbSHY7HYugZ0pTnVTRDnl6L2M+K9K2D+vdM4vLq6vRuhwSLtWfp/bfM7jqQQkyDn3qgc
         onPtoKcv0hyd8bgQ0K/Us6U1awjrBRvC0rgGpf6UUTLsGoAZFEZHQ9mosbEEtAzKgu4E
         sVjeSNftZRtM3yxbTh9MydaP8JWOfxjmyz48obxXhx2/j8TDBWO2X+JQMqL/wSj3JCt/
         36sw==
X-Gm-Message-State: AOAM533rEdHqpmA2SYU7Jq9EuMB2L3Qv7KfDmMMHuam2npv/sgwpDHlQ
        PJNaAlZixjGitxyr3tLDl4mu3WilfHQ=
X-Google-Smtp-Source: ABdhPJyeS11MWJWIPMBKnsprqezqgfZ2gTNo4TwAAgBZVHDbSLb9SAwVA3YDJDjCwnF9BB4jYImGIA==
X-Received: by 2002:a2e:780b:: with SMTP id t11mr234821ljc.271.1594839770991;
        Wed, 15 Jul 2020 12:02:50 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id g24sm594774ljl.139.2020.07.15.12.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 12:02:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 15 Jul 2020 21:02:43 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200715190243.GA26735@pc636>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 15, 2020 at 08:56:28PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-15 20:35:37 [+0200], Uladzislau Rezki (Sony) wrote:
> > @@ -3306,6 +3307,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> >  			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >  				return false;
> >  
> > +			preempt_disable();
> > +			krc_this_cpu_unlock(*krcp, *flags);
> 
> Now you enter memory allocator with disabled preemption. This isn't any
> better but we don't have a warning for this yet.
>
Please elaborate why it is not allowed? Consider the code:

<snip>
    spin_lock();
    __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
    spin_unlock();
<snip>

Also, please note we do it for regular kernel.

>
> What happened to the part where I asked for a spinlock_t?
> 
What do you mean?

--
Vlad Rezki
