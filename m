Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73EAC43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 21:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AA420772
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 21:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsfl8VP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbgDAVQU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:16:20 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:33837 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAVQU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 17:16:20 -0400
Received: by mail-lj1-f174.google.com with SMTP id p10so1052713ljn.1;
        Wed, 01 Apr 2020 14:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oLH4pSOBX6QVvD8MiZ0+hKQryAABD8RWpMsCn+k+a+A=;
        b=Wsfl8VP6OCfioBKCN/DG/jeJzGYLrWvvRXUsKRIdJkzf8G8bYRUOHtseSSBFscP63u
         PARsF4isZFdssUTqihcKgdneffxrCh68+OFCNWC1qRIXfhwQxeMgCP5Dvv0nE2vjWhUm
         mq0ltJoRfzAnG61WS2Rgutw9AN4aUZwlBxSyuETeSZeenPc7JSH0y3edtbm7uR9YR+LU
         nfsvfaU9fwt17EuJcRz6Iw4A3OQECvNP0nCx9+2iVtOEG4l7xEtyVGLsjWXSPZ2FgcRC
         AkJeWzE9GTWCwn0PwWLyqBouFxqPoKM/quy0PqBMnF+YmiRSO8MiMJCy0cciRJFnhkcL
         GL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oLH4pSOBX6QVvD8MiZ0+hKQryAABD8RWpMsCn+k+a+A=;
        b=hEmQwknFT/OQAgwRPDxGpKH2OhfvSk2sMzctjnYQxOY21rBAwt1l9pURXwnuaQVp7P
         oDwKCRcOO0/E5Y598WuySF033bsoydV5+QBMk0pIYYfXpUZCUAyhLFRdtqFZpRw4u44J
         hXBz926p/kOtagZDMcHwWpXHslRIcI5AXCrN7Bolw27X4bcaJQwfE85r7uUpe/cQEPAr
         L17SmyQ2bJfrXtfgeYPwJiHlt0yiz2o0X89jFppoe6y5gxC+VpQD5rXelAi8npsN3siL
         TtK62ll5zYvNP4UNAAMkqeTeqNClMa+RVPTJFQ6GhkuZ2t1V98J+HRYcaPNRq8jnqLry
         y9hw==
X-Gm-Message-State: AGi0PuYRj9qERn/niKaE9KuWaFY6uUtrmVntUynlIM55IScdmq53qi/l
        pjISCa6KH1Uxq3g1kMy/RL8=
X-Google-Smtp-Source: APiQypI9mZh+jYSqH0gPhUUcAipYxcrUmx+kc7hVVGj3DUdmmHElMizLpHm3rSWuQP1Ov+/Emi4lwQ==
X-Received: by 2002:a05:651c:22e:: with SMTP id z14mr128259ljn.64.1585775775578;
        Wed, 01 Apr 2020 14:16:15 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id v22sm1885434ljc.79.2020.04.01.14.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 14:16:14 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Apr 2020 23:16:07 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, urezki@gmail.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: What should we be doing to stress-test kfree_rcu()?
Message-ID: <20200401211607.GA7531@pc636>
References: <20200401184415.GA7619@paulmck-ThinkPad-P72>
 <20200401205012.GC206273@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401205012.GC206273@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 01, 2020 at 04:50:12PM -0400, Joel Fernandes wrote:
> On Wed, Apr 01, 2020 at 11:44:15AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > What should we be doing to stress-test kfree_rcu(), including its ability
> > to cope with OOM conditions?  Yes, rcuperf runs are nice, but they are not
> > currently doing much more than testing base functionality, performance,
> > and scalability.
> 
> I already stress kfree_rcu() with rcuperf right now to a point of OOM and
> make sure it does not OOM. The way I do this is set my VM to low memory (like
> 512MB) and then flood kfree_rcu()s. After the shrinker changes, I don't see
> OOM with my current rcuperf settings.
> 
> Not saying that my testing is sufficient, just saying this is what I do. It
> would be good to get a real workload to trigger lot of kfree_rcu() activity
> as well especially on low memory systems. Any ideas on that?
> 
> One idea could be to trigger memory pressure from unrelated allocations (such
> as userspace memory hogs), and see how it perform with memory-pressure. For
> one, the shrinker should trigger in such situations to force the queue into
> waiting for a GP in such situations instead of batching too much.
> 
> We are also missing vmalloc() tests. I remember Vlad had some clever vmalloc
> tests around for his great vmalloc rewrites :). Vlad, any thoughts on getting
> to stress kvfree_rcu()?
> 
Actually i updated(localy for my tests) the lib/test_vmalloc.c module with extra
test cases to stress kvfree_rcu() stuff. I think i should add them :)

--
Vlad Rezki
