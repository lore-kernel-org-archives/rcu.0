Return-Path: <SRS0=vGyR=6I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7DDC54FD0
	for <rcu@archiver.kernel.org>; Fri, 24 Apr 2020 12:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B73820767
	for <rcu@archiver.kernel.org>; Fri, 24 Apr 2020 12:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvvc1Cpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgDXM24 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgDXM2y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 24 Apr 2020 08:28:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A62BC09B045;
        Fri, 24 Apr 2020 05:28:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u10so7526505lfo.8;
        Fri, 24 Apr 2020 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k60UfD2VvBeqBR1jDBzYaJ+PcNnTDpEV245LnyiomDc=;
        b=Fvvc1CpvO2kTUW3CN4WXkCvbalXgjoKl8RN1Zg0SM0fKe39PWZs6HdM05NtgxbI0qK
         odQmc/Fhc3vUJv1pVcMIx96Io2J7GF+mx0evj2sbJDE6BIFp676xLh3eDGaRL0Vixvp+
         bPjw3i18QpY4WTdIqEo/EsNCQxMHA78KIPsawcAU6Asl5pqrdMVI+LRqZkmKaGSnwKM/
         EP3wZiIZ5KfvMzyOggdeYADddHL7WbpwtFJ7qK9LooUSm1EQxLby6BWgsNC/Ui+w/a1X
         OZSEre0HE6S637vg0ju0ZfyJxRghFxEjHgVQURiWw3zRg4zmr0glquK7UIuKsNCztjQP
         n3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k60UfD2VvBeqBR1jDBzYaJ+PcNnTDpEV245LnyiomDc=;
        b=CEjA8EURxP/UHhfqH3k6t6zm584fPQAfbkka1+7k9p9Waz4S+jB14wIeFNFca0iH/5
         XWIJxYg8/Uah6Tbzc7Y4Bw7YGbBhvtQl3sK/2lM3X7x5QUI25uws1T4cDMDZOysm1+ns
         2+jGRkJUvH6b93AAp2QhmB9+0YaloQSBSurNwVj5lmXwhcRbFySYDGcWcDA30l1kSO73
         tYTY+pvrZ3Rhs97aOyOm5p1w4sH/8SCzbwop+0ugP95Ln6o8IcxJsc5kQiOIQCdXi3N/
         CjyrtSJBl08ouQ+lBcALH7elr+saNjj9jD8Cmv8GBEp0m1gvmwySJFPDP7KH71IHObM7
         gRUA==
X-Gm-Message-State: AGi0PuYchwyn8lk7WfCtoI+qqZjuTNLAAr3DiKDAUn872inMFB/8dHKR
        7gOpAftUQosTBWhogU8zO+U=
X-Google-Smtp-Source: APiQypL+5Ph8LgmCGcZsihaI0P2D/qLm24X5ZCz7Lj4PdtcDPWF2S10Om0rJtJRItzJNqj6cDOAN+w==
X-Received: by 2002:a19:700b:: with SMTP id h11mr6207726lfc.89.1587731332534;
        Fri, 24 Apr 2020 05:28:52 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id f26sm4270043lfc.84.2020.04.24.05.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 05:28:51 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 24 Apr 2020 14:28:35 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200424122835.GA4686@pc636>
References: <20200416131745.GA90777@google.com>
 <20200416180100.GT17661@paulmck-ThinkPad-P72>
 <20200422145752.GB362484@cmpxchg.org>
 <20200422153503.GQ17661@paulmck-ThinkPad-P72>
 <20200423174831.GB389168@cmpxchg.org>
 <20200423180249.GT17661@paulmck-ThinkPad-P72>
 <20200423182750.GA32451@pc636>
 <20200423192115.GV17661@paulmck-ThinkPad-P72>
 <20200423195955.GA476@pc636>
 <CAEXW_YSt=yLDS4Fj7atqB_OYiKAvt2472eTKcytEkzVABUMPkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSt=yLDS4Fj7atqB_OYiKAvt2472eTKcytEkzVABUMPkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> 
> I think Johannes said that waking up kswapd is Ok. OTOH, I did not see
> the drawback in waking up kswapd to do background reclaim since it
> does not happen synchronously right? I think Johannes said we can do
> better than just waking kswapd by also doing light direct reclaim
> using __GFP_NORETRY but let me know if I missed something.
> 
Then i misunderstood that point. So, seems it is settled now. We just
use GFP_NOWAIT | __GFP_RECLAIM | __GFP_NORETRY | __GFP_NOWARN for headless
case, i.e. when we can sleep. It will do direct reclaim(slow path), but
light one because of __GFP_NORETRY.

Does it sound good?

> > For single argument we inline freeing into current context after
> > synchronize_rcu() because it follows might_sleep() annotation.
> 
> Yes.
> 
> Also, with the additional caching being planned, we could avoid the
> chances of hitting the synchronize_rcu inlining.
> 
Or minimize it.

There is also one question i would like to clarify. That is dynamic head
attaching that requires small allocations. Do we drop it?

Thanks!

--
Vlad Rezki
