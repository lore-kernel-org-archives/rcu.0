Return-Path: <SRS0=Gqt/=DB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BC6C4727E
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 15:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94862344C
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 15:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXhYvPy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgIXPQd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Sep 2020 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgIXPQb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Sep 2020 11:16:31 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF13C0613CE;
        Thu, 24 Sep 2020 08:16:30 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id q8so4353872lfb.6;
        Thu, 24 Sep 2020 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vgIr3UnaQPyUPGT1YxgZ7u38f72zk1LPY4fqYV/vg8k=;
        b=iXhYvPy0LzzINWscEsEuBJcHyNnMX2Q16bBmhHorBDz03Q5SDV4E7eNcUShLpEy/HA
         vhLmMSvEojyifVv1TrPHcrueBEvatmn6Ije7kFLzZ2YcCMyu+1pUUJ/t8dXXPXCbN1WJ
         cDp8Ml8B1Qh0vdg6VB+NaATaAe9MM9LLwW9ttO5mdULIjjk8bxBjVTVX8TSNqp8+3eRq
         CTPJAS6yi1fwkiUNXWsG61mLH6LuR6lf2xBjZA/hxAfhPooqyF/19VVxZnypaWIyj+VL
         iVuctOkCFTShInFW8LM2JetY6GJ+kmX+bj/iA39jMNqZo6JHhaRchtpiwGgZ/Gl0eT3+
         eI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vgIr3UnaQPyUPGT1YxgZ7u38f72zk1LPY4fqYV/vg8k=;
        b=gxBglCQ2YwoZmnEjbG2xxR17W79yE/SLiX7xCPCngJ+r3LRbQEoYQjkO1wbSFl636L
         l0fN3LHpO0MvnIB0CKwIYoLxb/k6tZYmPcwxn58g+2MDgeDbCTetuHv+EkbpEDhwyXFv
         dl0UoChW5vITFOSyArUMJL03rZ7lwgEW6+DxwgsQH1cTbFp3YwPrRqAhl4K3spw++xfd
         bmflYz/if1Bw2r+gt32C9MZwDEJkw3KIIF9iZFBeN0rwBiTPEu3rXLFTgjOW3FzT1Djx
         faIGNwxrmRR1/W1GnCrFxxarOBVZmXd7rB4BUfeVjdFNHHlI7Y3KNjDatdOPpyG4RRpZ
         AzCg==
X-Gm-Message-State: AOAM531GQ86lO2Tc4HZJCb0SG62IC2UeVDYo1RTgosKI6aJiWBIq5ql1
        D6PYU0rR5xqaibF5OpfP7gs=
X-Google-Smtp-Source: ABdhPJzK2d/M+AZ9drrmmGdPQ2ZzuwPUEP3T7OwuWubTbWcL2qi9PC3R4p1P1pZ8awnBiEKz6kM71A==
X-Received: by 2002:a19:430c:: with SMTP id q12mr470114lfa.68.1600960588909;
        Thu, 24 Sep 2020 08:16:28 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 193sm2311575lfb.212.2020.09.24.08.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:16:27 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 24 Sep 2020 17:16:25 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200924151625.GA19013@pc636>
References: <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200924111632.GD2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924111632.GD2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 24, 2020 at 01:16:32PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 24, 2020 at 10:16:14AM +0200, Uladzislau Rezki wrote:
> > Other option is if we had unconditionally enabled PREEMPT_COUNT config.
> > It would be easy to identify a context type and invoke a page allocator
> > if a context is preemtale. But as of now preemptable() is "half" working.
> > Thomas uploaded patches to make it unconditional. But it can be blocked.
> 
> While I in principle support Thomas' patch, I think this is an abuse and
> still complete wrong.
> 
Good that you support it :)

>
> Not all preemptible() context can deal with GFP_KERNEL (GFP_NOFS
> existing should be a clue). !preemptible context cannot unconditionally
> deal with GFP_NOWAIT, consider using it while holding zone->lock.
> 
Not sure if i fully follow you here. What i tried to express, if we had
preemtable() fully working, including !PREEMPT, we can at least detect
the following:

if (!preemptable())
    by pass using any ATOMIC/NOWAIT flags because they do not work;

as an example you mentioned z->lock that is sleepable.

>
> The preemption context does not say antying much useful about the
> allocation context.
>
I am talking about taking a decision. 

--
Vlad Rezki
