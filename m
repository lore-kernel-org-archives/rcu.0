Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D99C2BA14
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 18:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABF220784
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 18:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+d7Rorm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbgDASQj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:16:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41364 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgDASQi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 14:16:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id z23so496724lfh.8;
        Wed, 01 Apr 2020 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ohKhIvr0zaGkZNZ8iCKmPfOv0u8WbM7PXyOQtVWyFt8=;
        b=K+d7Rorms1Cni3yLww4dnDdrJOs14OO60FrW3zNhaJMt4znxIyzrsMPueYF6XwN29x
         uw01a0igiJEkp4Pqos6HPFTtFqeJc7Mt/ioE/Hx+si9FW41oZ4MsMclcGXAMd+he1DyU
         4Z6N4MWZoI64SqGI+BgU3YQ+XJxOc6wbqJQJ7X2bRJFJD4aMWPugN6dB1GfFVMWXV59V
         FDGHyJVKb4Nhe8nvWOOZfNb+3wylIfpCjNTWAMnuwuCnxBQPuyij8XzEqEOWaqnbQqOD
         X1azb/qNUAmS8rQAjCdXEYpBtO0M2Wtn1Lvpz0SnCUWA+8gZ85Xg/gdI0vu2RfFOti/s
         CyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ohKhIvr0zaGkZNZ8iCKmPfOv0u8WbM7PXyOQtVWyFt8=;
        b=lmzj1OZuXO+RiK5cEcwOyOfAnxfLuqBlwysPEqZ1vLofZfuieqs9FOLCT2pHqNHOrc
         qzMaoVvieMIGXS3cVlMWlCZe+5XyphLE2WLpH/0lojfaz2mmvT60/KVYaVeOl9/SxgU9
         jEF1ichBksqaqm3jAFS+W1UZoIlESeh9sZj3g6p19k8na5d/Qzr32s5eIMOJqIOTkkg2
         ZYBoNPScVkNbrEwaa1djfpDiOa9ct3Dec4OfkkyMp/kZR8ZApn2MzW8WfVE4VMuvyexK
         tYw7/KDtUrVv4NOvi4NfeNm8Bhvgka9LDfsffooui87YayzKAzh6yoR9yvOnAqajsmJS
         95Lw==
X-Gm-Message-State: AGi0PuYURct7AvRM6WsBjtor8OFP65a21zfBV9TMEHbG03MRhDQl6ajX
        O//Yip6i/7oqsOhfCnm95b4=
X-Google-Smtp-Source: APiQypLUT/Urx2WPTfjLpIiARF0DyHJ3Fb08TbT+Qv/xlBHs3Zk7A9+cT+CQ8O/7hciGtwRKiKAabA==
X-Received: by 2002:a19:4843:: with SMTP id v64mr15013886lfa.171.1585764996901;
        Wed, 01 Apr 2020 11:16:36 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id b28sm1854143ljp.90.2020.04.01.11.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 11:16:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Apr 2020 20:16:01 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401181601.GA4042@pc636>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331140433.GA26498@pc636>
 <20200331150911.GC236678@google.com>
 <20200331160119.GA27614@pc636>
 <20200331183000.GD236678@google.com>
 <20200401122550.GA32593@pc636>
 <20200401134745.GV19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401134745.GV19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > 
> > > Right. Per discussion with Paul, we discussed that it is better if we
> > > pre-allocate N number of array blocks per-CPU and use it for the cache.
> > > Default for N being 1 and tunable with a boot parameter. I agree with this.
> > > 
> > As discussed before, we can make use of memory pool API for such
> > purpose. But i am not sure if it should be one pool per CPU or
> > one pool per NR_CPUS, that would contain NR_CPUS * N pre-allocated
> > blocks.
> 
> There are advantages and disadvantages either way.  The advantage of the
> per-CPU pool is that you don't have to worry about something like lock
> contention causing even more pain during an OOM event.  One potential
> problem wtih the per-CPU pool can happen when callbacks are offloaded,
> in which case the CPUs needing the memory might never be getting it,
> because in the offloaded case (RCU_NOCB_CPU=y) the CPU posting callbacks
> might never be invoking them.
> 
> But from what I know now, systems built with CONFIG_RCU_NOCB_CPU=y
> either don't have heavy callback loads (HPC systems) or are carefully
> configured (real-time systems).  Plus large systems would probably end
> up needing something pretty close to a slab allocator to keep from dying
> from lock contention, and it is hard to justify that level of complexity
> at this point.
> 
> Or is there some way to mark a specific slab allocator instance as being
> able to keep some amount of memory no matter what the OOM conditions are?
> If not, the current per-CPU pre-allocated cache is a better choice in the
> near term.
> 
As for mempool API:

mempool_alloc() just tries to make regular allocation taking into
account passed gfp_t bitmask. If it fails due to memory pressure,
it uses reserved preallocated pool that consists of number of
desirable elements(preallocated when a pool is created).

mempoll_free() returns an element to to pool, if it detects that
current reserved elements are lower then minimum allowed elements,
it will add an element to reserved pool, i.e. refill it. Otherwise
just call kfree() or whatever we define as "element-freeing function."

>
> If not, the current per-CPU pre-allocated cache is a better choice in the
> near term.
>
OK. I see your point.

Thank you for your comments and view :)

--
Vlad Rezki
