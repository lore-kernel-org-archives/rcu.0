Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D2EC388F7
	for <rcu@archiver.kernel.org>; Tue, 10 Nov 2020 20:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B9620781
	for <rcu@archiver.kernel.org>; Tue, 10 Nov 2020 20:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iD6NGpE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKJUde (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJUde (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Nov 2020 15:33:34 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE848C0613D3
        for <rcu@vger.kernel.org>; Tue, 10 Nov 2020 12:33:33 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id n132so11745127qke.1
        for <rcu@vger.kernel.org>; Tue, 10 Nov 2020 12:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FGyjU1VFt03gTjbteYJEMdl1u0ziLYUtvD1NXemfJhs=;
        b=iD6NGpE1mnBrvgAsnOHd2EJKsUjVra3puLElxMvH9dayS1Y4J7BdSu8POnN/3tqDx3
         TgHnN0b9/e1BZjEEPF6k89aK9eODBtg9FhzicC8MxgUwuuYE6jpsRMLLdzG7uOltOsdL
         1PhqdXX9Hkj8XMvsBrOwwoxUBOqdW8hTx7df4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FGyjU1VFt03gTjbteYJEMdl1u0ziLYUtvD1NXemfJhs=;
        b=O3bo3BIG7hHc1Z0ZZ97LtuL3ekMR2WjTZHyTmwiNQ13UwPKpfbQbgfv41xyNi3U9CT
         7H/+NxRG5agyP3vOUnC0Nu5WalN0vIS8lMh9yFDXP+ksUnK6fL5K5o7dGGO6OA+AxibE
         iJBe6c4mOlwSrFewyidlN8YCDuwFXpJsAUnusoAuWh+JW/XL/DqBtmBQopHZD0UIu6p9
         wiMbbbvLrNmpzgdWESPFpmQwfwxYs70WpfSPrn1V0tIX5GD2hYnbKMiUoE8jHOBF0Z/Z
         gZTpgNbh0SmUTgULx1UmjYfxVX/yTd6bILqlNCbd6mKMxTqLdrZdp9JUbDDNQRedSXb4
         VUXw==
X-Gm-Message-State: AOAM533uXfaPHVK+qPkjdy4az3avVyPsIGjtdqevoy3i6BlyHih8x6ON
        Ln9OVkWGGa1xOvWKOV7gbcehkQ==
X-Google-Smtp-Source: ABdhPJxa69TxULwtqWM4g1jhzML48igFEJTuMp1hchP6B5ueOhZOEsls5SPVIjL0X2Uw3UmSQ1ZAfw==
X-Received: by 2002:a37:86c4:: with SMTP id i187mr21508004qkd.371.1605040409776;
        Tue, 10 Nov 2020 12:33:29 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b4sm5591796qti.64.2020.11.10.12.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 12:33:29 -0800 (PST)
Date:   Tue, 10 Nov 2020 15:33:28 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 2/4] docs: Update RCU's hotplug requirements
 with a bit about design
Message-ID: <20201110203328.GA694269@google.com>
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-2-paulmck@kernel.org>
 <20201109122317.GM2594@hirez.programming.kicks-ass.net>
 <20201109162452.GK3249@paulmck-ThinkPad-P72>
 <20201109171433.GL2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109171433.GL2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 09, 2020 at 06:14:33PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2020 at 08:24:52AM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 09, 2020 at 01:23:17PM +0100, Peter Zijlstra wrote:
> > > On Thu, Nov 05, 2020 at 03:05:08PM -0800, paulmck@kernel.org wrote:
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > 
> > > > The rcu_barrier() section of the "Hotplug CPU" section discusses
> > > > deadlocks, however the description of deadlocks other than those involving
> > > > rcu_barrier() is rather incomplete.
> > > > 
> > > > This commit therefore continues the section by describing how RCU's
> > > > design handles CPU hotplug in a deadlock-free way.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  .../RCU/Design/Requirements/Requirements.rst       | 49 +++++++++++++++++-----
> > > >  1 file changed, 39 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > > > index 1ae79a1..98557fe 100644
> > > > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > > > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > > > @@ -1929,16 +1929,45 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
> > > >  to allow the various kernel subsystems (including RCU) to respond
> > > >  appropriately to a given CPU-hotplug operation. Most RCU operations may
> > > >  be invoked from CPU-hotplug notifiers, including even synchronous
> > > > -grace-period operations such as ``synchronize_rcu()`` and
> > > > -``synchronize_rcu_expedited()``.
> > > 
> > > I was under the impression that this rst crap now recognises func() and
> > > you no longer need to make the text unreadable with "``".
> > 
> > It was there to start with, but good point.  How about the commit
> > below?
> 
> Much appreciated, thanks!

Thanks for making the change, I built it and it looks good in my web browser
;-).

BTW, these APIs are obsolete due to consolidation. Paul could you remove them
from the document?:
 synchronize_rcu_bh(), synchronize_rcu_bh_expedited(), call_rcu_bh(),
 rcu_barrier_bh().

thanks!

-Joel

