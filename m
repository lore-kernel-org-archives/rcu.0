Return-Path: <SRS0=fEXk=3O=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE2FC35242
	for <rcu@archiver.kernel.org>; Sat, 25 Jan 2020 01:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C762075D
	for <rcu@archiver.kernel.org>; Sat, 25 Jan 2020 01:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXJqv9wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbgAYBou (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:44:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42248 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387542AbgAYBou (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 24 Jan 2020 20:44:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so4287464wro.9;
        Fri, 24 Jan 2020 17:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=YClYexq+U3tIz5ISpWhnb2Lm7QGjVoZX5YmTNUyCVtU=;
        b=YXJqv9wxQBkENUOockt5+aawuWFcE0wjQdXFzS0iKKyqjk03J4QSI8OnPoMx8Ukto0
         gmXP6S/ts2Rz9hzGwBNZbxQhx+0hFVnn79pwD30zGfclegT30v0jTVQOVyNeoebJI3E7
         t/EaitjgD4Qr7m70Pd11HNAV21HhZSglJ9l68bt40JbMBlqQPBc9KN4slcvhvTyCFn+D
         AFBHdoSNZ+2bphDW6JBEcgJK21mQc9SrU4LyDpXf4/jsX9DEt3qyDKPLfOeeRkPRISJY
         vAyhTKPPqzgB5iBW9XGRTmPZYPQWnItzu0LO1P1UatayU2QnEssQZcO44ovwXy0oLyVL
         y3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=YClYexq+U3tIz5ISpWhnb2Lm7QGjVoZX5YmTNUyCVtU=;
        b=tz5bKgdx8KVLpNFzyolFo6wozB7UPhKywm4+ZsRil4CPznVWA6G2bzyuLrnW+LYCpG
         LCG8DnEa7c6ZENZIsMaLpy/y6HtAdQYSnirMB5s0+ad7A3j4rYsHOV23+8Xr6hYG3Gdy
         xUCm+CKbyMjv+dYqCoxTFG0Q0pMK8kX7j36mIkFJKAELlXa6fYjBqnaTKKijXp6Uh0xc
         DeUtkI59yfqrOa6wxwio+V8zR3/zR41iPx0EJ23eMJuSStou2Xi87uKlu3Cf13drQP9j
         h37CsZSVDiD5z1ZqHA4MnL2eiWxg1GPN0wyvEMPp6U1L6E0AXyFzFPVLIlIiff4Plm0S
         Tv8w==
X-Gm-Message-State: APjAAAWlQyPo93siD2JlGBxGbYh5jCOyCwR5jab2MEOVah/S1PqDgKJ3
        1c64p9El6BWLc+/FDaQ7GQ==
X-Google-Smtp-Source: APXvYqy92Jrg/NagayiSDkKqSxRYjyJJsZlQyqhvw4LUT8Cgid/6A+PrQi0vOrjXtcJOxujf+ZbD0g==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr8006042wrm.210.1579916687640;
        Fri, 24 Jan 2020 17:44:47 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-87.as43234.net. [92.15.174.87])
        by smtp.gmail.com with ESMTPSA id y20sm8534407wmi.25.2020.01.24.17.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 17:44:47 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Sat, 25 Jan 2020 01:44:39 +0000 (GMT)
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     Jules Irenge <jbi.octave@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 0/5] Lock warning clean up
In-Reply-To: <20200122012630.GE2935@paulmck-ThinkPad-P72>
Message-ID: <alpine.LFD.2.21.2001250140570.9357@ninjahub.org>
References: <20200120223515.51287-1-jbi.octave@gmail.com> <20200122012630.GE2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


Thanks I am currently an intern with Outreachy program. I am happy to 
receive any comment or recommendation so as I can improve.
Best Regards,
Jules

On Tue, 21 Jan 2020, Paul E. McKenney wrote:

> On Mon, Jan 20, 2020 at 10:35:15PM +0000, Jules Irenge wrote:
> > This patch series adds missing annotations to functions that register warnings of context imbalance when built with Sparse tool.
> > The adds fix these warnings and give insight on what the functions are actually doing.
> > In the core kernel,
> > 
> > 1. IRQ and RCU subsystems: exactly patch 1 and 3,  __releases() annotations were added as these functions exit the critical section
> > 2. RCU subsystem again, patch 2 and 4, __acquire() annotations were added as the functions allow entry to the critical section.
> > 3. TIME subsystem, patch 5 where lock is held at entry and exit of the function, an __must_hold() annotation was added.
> 
> Queued for review and testing, thank you!
> 
> I edited the commit logs, so please check to make sure that I did not
> mess something up.
> 
> 							Thanx, Paul
> 
> > Jules Irenge (5):
> >   irq: Add  missing annotation for __irq_put_desc_unlock()
> >   rcu: Add missing annotation for exit_tasks_rcu_start()
> >   rcu: Add missing annotation for exit_tasks_rcu_finish()
> >   rcu: Add missing annotation for rcu_nocb_bypass_lock()
> >   time: Add missing annotation for __run_timer()
> > 
> >  kernel/irq/irqdesc.c     | 1 +
> >  kernel/rcu/tree_plugin.h | 1 +
> >  kernel/rcu/update.c      | 4 ++--
> >  kernel/time/hrtimer.c    | 2 +-
> >  4 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > -- 
> > 2.24.1
> > 
> 
