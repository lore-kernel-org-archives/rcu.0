Return-Path: <SRS0=gdpO=5Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4AAC43331
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 16:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA3420784
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 16:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuzgJoiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgCaQBc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:01:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43271 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbgCaQBc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Mar 2020 12:01:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id g27so22496105ljn.10;
        Tue, 31 Mar 2020 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mGooQZ7gU++yXifRkSQ0rrosFEFQwGRzPMzAN0ReXSA=;
        b=JuzgJoiICOoWyYDgv9xDCo19s/29aTdLWUMdbpE9vFXBE8sCWezyA/Kh/82satTNaP
         snD5PJEaiJQTG4qlxsv64rLGj6onIu4QQmPD/UQw6Coh9/BiYOFO37Ig9f32VyFVVo86
         BJAP4YAkCIvpKafg+5D1XXwqHkSfG+IU6A5p5Q0j13NesZgmTTF4t9qXGRv/029sYX7X
         ddxbfXl7pg6Hyg+j+Bdi9VJHNKnmkV9SIR5iGaTXclqu2vkRSkdsNZHPZKXs9rP4cfHp
         enySnpBZq6skVrVLUQkRVZ7cAYBBD+yyPQ+6yKWNcxRhW9ih7yrZpa1qID3q3zJEcBXV
         UyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mGooQZ7gU++yXifRkSQ0rrosFEFQwGRzPMzAN0ReXSA=;
        b=sOa6IcpbDTFiBL4FRSYRkJxnzZvmQ+bToZi1Dgs8P0mlnAzOlegNVCpwzDU8iwTKds
         h8m7pzOIUPysywj/6yIAEocaEEdpscZK86IDHEr5seeM/ZK+G1Q0vQh8fLxAeYS3dMjN
         H9tOXKgN2ZHD6QFNyGpeytzmDpR/31BG74pprE+z2RUktC99hWr9va33hGjz/y/TDd0y
         BOajRpyHLzKYGxeTdCRPrN4x0RIvygdneRzP1ms+JLIDR6AKUct1k+b4OGVRd4RoLWfj
         O5Z10/CQ6z+PqaPYlYLAlTahR0W4JX1S/NeRVg7Bq3F3keDPhNdu18ITwAaLVYfPA7Bj
         /uoQ==
X-Gm-Message-State: AGi0PuZEiS6N9YXNUfnqNNk69D9JVZMS0USfcH0oZo4JKQF22GIOIHBY
        5L3hnOMKOcM4B+ERipn93vc=
X-Google-Smtp-Source: APiQypKLO2RyYiUQHHYhRYN0WRU3Oxg70spLOsu0uEsIuPmigPF+jS+ukh9C8TvcUz3SfyXVw4h/3g==
X-Received: by 2002:a2e:85c1:: with SMTP id h1mr4594762ljj.240.1585670490088;
        Tue, 31 Mar 2020 09:01:30 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 28sm10032664lfp.8.2020.03.31.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:01:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 31 Mar 2020 18:01:19 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org, willy@infradead.org,
        peterz@infradead.org, neilb@suse.com, vbabka@suse.cz,
        mgorman@suse.de, Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331160119.GA27614@pc636>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331140433.GA26498@pc636>
 <20200331150911.GC236678@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331150911.GC236678@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> 
> Yes, I mean __GFP_MEMALLOC. Sorry, the patch was just to show the idea and
> marked as RFC.
> 
> Good point on the atomic aspect of this path, you are right we cannot sleep.
> I believe the GFP_NOWAIT I mentioned in my last reply will take care of that?
> 
I think there should be GFP_ATOMIC used, because it has more chance to
return memory then GFP_NOWAIT. I see that Michal has same view on it.

> > As for removing __GFP_NOWARN. Actually it is expectable that an
> > allocation can fail, if so we follow last emergency case. You
> > can see the trace but what would you do with that information?
> 
> Yes, the benefit of the trace/warning is that the user can switch to a
> non-headless API and avoid the synchronize_rcu(), that would help them get
> faster kfree_rcu() performance instead of having silent slowdowns.
> 
Agree. What about just adding WARN_ON_ONCE()? I am just thinking if it
could be harmful or not.

>
> It also tells us whether the headless API is worth it in the long run, I
> think it is worth it because we will likely never hit the synchronize_rcu()
> failsafe. But if we hit it a lot, at least it wont happen silently.
> 
Agree.

> Paul was concerned about following scenario with hitting synchronize_rcu():
> 1. Consider a system under memory pressure.
> 2. Consider some other subsystem X depending on another system Y which uses
>    kfree_rcu(). If Y doesn't complete the operation in time, X accumulates
>    more memory.
> 3. Since kfree_rcu() on Y hits synchronize_rcu() a lot, it slows it down.
>    This causes X to further allocate memory, further causing a chain
>    reaction.
> Paul, please correct me if I'm wrong.
> 
I see your point and agree that in theory it can happen. So, we should
make it more tight when it comes to rcu_head attachment logic.

--
Vlad Rezki
