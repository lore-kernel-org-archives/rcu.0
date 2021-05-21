Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E7AC433B4
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 06:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E10B611AB
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 06:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhEUGpO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 May 2021 02:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhEUGpI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 May 2021 02:45:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B55C061244
        for <rcu@vger.kernel.org>; Thu, 20 May 2021 23:42:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d78so13340325pfd.10
        for <rcu@vger.kernel.org>; Thu, 20 May 2021 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hl/qohgB2l3RB64t8f38Kc+WBgXz2CrEXkw4MtzNOz0=;
        b=hFlidlnBXquOFTvAU6cPyjWsXFebuppc7HfVBMYLmz4i/bFYW7fwXpNC8qzwP+IYjW
         eEQbXPAPZNG81f0zk9U10WQZ5EuigjxQCbxAdYGFmZ05wgTKm/KAFR+dn4plRitI0k1a
         UWImRtgIfBxQ81tUKr820gFKKYHJ5aFGGxPik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hl/qohgB2l3RB64t8f38Kc+WBgXz2CrEXkw4MtzNOz0=;
        b=nQACUwQBP70i3WdIDPBecThR3Q958MzzMA2UEyVi3+8e2T6qekwAed4C3bFO1ozMkb
         mMf0Zq2XYMQUF3ct1TndqsGj5fGvZ6epkpZx0lGvCrCRuu10E+997uYt/bUhqn57Qu7Z
         fp6vtlyzoPYC3zypn9mcquVsWO/WcSHPoWEg+Ta9D9qovA43YO5FXIean/ztvryHQNd5
         2hJvp8vgJhK/18MZrFNDAiHIvrBPkNgr2tzX230Z3txFJ40WJkc2Q+azlAAeslUBdKL8
         Zxsl9jp3fozIrZ7aPyi5zhHz+bx7N1QCyBbs78mnWEg/IenqhRnDs7rbUB7cl3mIagOg
         t4rA==
X-Gm-Message-State: AOAM5324pjJfA/qQhS8JVoysr2LA3JLbmm7PhwqLJOFwmL2/D445K6l2
        JgvzE3RuVBPbxGw+y5mvXh1bXw==
X-Google-Smtp-Source: ABdhPJzhaHY99PwQpKfDa1wNRy8NEmYunelNDqsOlYBX4rgShiWjjNeJ08Jmd6doyIuodpzFUWLu0g==
X-Received: by 2002:aa7:88d6:0:b029:2e3:b74b:2a5b with SMTP id k22-20020aa788d60000b02902e3b74b2a5bmr5563724pff.4.1621579356878;
        Thu, 20 May 2021 23:42:36 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:245d:3890:fa95:996e])
        by smtp.gmail.com with ESMTPSA id a20sm3582207pfc.186.2021.05.20.23.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 23:42:36 -0700 (PDT)
Date:   Fri, 21 May 2021 15:42:31 +0900
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
Message-ID: <YKdWV2lznaxUKBM5@google.com>
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
 <YKX/H0EwRRLM+cAa@google.com>
 <20210520145318.GJ4441@paulmck-ThinkPad-P17-Gen-1>
 <YKbhg30Q6YlerCoz@google.com>
 <20210521001443.GR4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521001443.GR4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On (21/05/20 17:14), Paul E. McKenney wrote:
> > On a side note.
> > 
> > I wish we didn't have to put kvm_check_and_clear_guest_paused() all
> > over the place.
> > 
> > We do load jiffies at the start of check_cpu_stall(). So, in theory,
> > we can just use that captured jiffies (which can become obsolete but
> > so will grace period timestamps) value and never read current system
> > jiffies because they can jump way forward. IOW
> > 
> > 	jn = j + 3 * rcu_jiffies_till_stall_check() + 3;
> > 
> > instead of
> > 
> > 	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> > 
> > Then we probably can remove kvm_check_and_clear_guest_paused().
> > 
> > But that "don't load current jiffies" is rather fragile.
> > 
> > kvm_check_and_clear_guest_paused() is not pretty, but at least it's
> > explicit.
> 
> If this works for you, I am very much in favor!

Oh, no. Sorry for the noise. This is racy and won't work.
