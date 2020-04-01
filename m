Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C13C43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 20:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E5920658
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 20:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qARTqRBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbgDAUuP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:50:15 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:43453 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbgDAUuO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 16:50:14 -0400
Received: by mail-qt1-f179.google.com with SMTP id a5so1386355qtw.10
        for <rcu@vger.kernel.org>; Wed, 01 Apr 2020 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChzHASHm/TaTfFYQF8dFqluK5hccbTbRDahFmV/GYAg=;
        b=qARTqRBehTmAwNC2T13cmie795aSz9hOx+Z+GpD1GXwTWnXyRaHIGFvPnnMp19QkJw
         hwFtyHpCx8LiBOZlOPi5WFcbxDYY/C7GU+nTFtAbvbVyJN2nJMl8T8gvy56c0JtbaUq5
         HiuZwbUrjOvZoPvkhXmftgH+T+rEbfCI8l1G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChzHASHm/TaTfFYQF8dFqluK5hccbTbRDahFmV/GYAg=;
        b=KZNIN6EwTJ5BCKGldeUSeU9rmNSYXEfrIuBanjOGj6MnGsJng47z6++XqjS2HnRN5P
         uno+pKwzb9VssWu8tXXbdg7lOyetN8UVf4cbao7IcWlZF1BbZTReBHIyT0cZ1b3TI6d3
         gLi68JWaIvwc3ewUkVl+YhtRguAiHj/pVlVZhYjb4j9b5qU+EBovePGk6rjoLnXWkbLz
         DIWZycXbecaSVm2kZTY1B2Xzy5alHNDCz6Rz7y02d3uqCdu4iwbwUZ/lfgVM3B22uq12
         Sh43aTb2Ip9tQ9M3rLJ74I/2RmMuBkWz35+hqeh7YABbVnhTxo/KjJm0qvaG0CeRYcUS
         XW1g==
X-Gm-Message-State: ANhLgQ1TtUb1gH/TNoNmWUuYt7RWZTq/M9xgbvIgbdqH4jhoN+CU6/yY
        Daf98vhTbUKNaY9ODgEegYGQYQ==
X-Google-Smtp-Source: ADFU+vszhUVBo8rk6zQ/KP2nDIHemw/whCCufwEnjdP5HFQ3SxUOc40tK7hbpV8NdfvvfFfglUakww==
X-Received: by 2002:ac8:266c:: with SMTP id v41mr12580604qtv.174.1585774213440;
        Wed, 01 Apr 2020 13:50:13 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y41sm2234552qtc.72.2020.04.01.13.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 13:50:12 -0700 (PDT)
Date:   Wed, 1 Apr 2020 16:50:12 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     urezki@gmail.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: What should we be doing to stress-test kfree_rcu()?
Message-ID: <20200401205012.GC206273@google.com>
References: <20200401184415.GA7619@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401184415.GA7619@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 01, 2020 at 11:44:15AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> What should we be doing to stress-test kfree_rcu(), including its ability
> to cope with OOM conditions?  Yes, rcuperf runs are nice, but they are not
> currently doing much more than testing base functionality, performance,
> and scalability.

I already stress kfree_rcu() with rcuperf right now to a point of OOM and
make sure it does not OOM. The way I do this is set my VM to low memory (like
512MB) and then flood kfree_rcu()s. After the shrinker changes, I don't see
OOM with my current rcuperf settings.

Not saying that my testing is sufficient, just saying this is what I do. It
would be good to get a real workload to trigger lot of kfree_rcu() activity
as well especially on low memory systems. Any ideas on that?

One idea could be to trigger memory pressure from unrelated allocations (such
as userspace memory hogs), and see how it perform with memory-pressure. For
one, the shrinker should trigger in such situations to force the queue into
waiting for a GP in such situations instead of batching too much.

We are also missing vmalloc() tests. I remember Vlad had some clever vmalloc
tests around for his great vmalloc rewrites :). Vlad, any thoughts on getting
to stress kvfree_rcu()?

thanks,

 - Joel

