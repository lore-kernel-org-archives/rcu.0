Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DCEC10F26
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1886D20776
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 12:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctg3aX71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbgDAM0B (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:26:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35409 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732253AbgDAM0B (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 08:26:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id k21so25563174ljh.2;
        Wed, 01 Apr 2020 05:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=piX7MZ/AAi4ncX0sPDXAqjMsG1O4fj7Yh16uYtERXCY=;
        b=ctg3aX71wlaxZ+E0dbXZnFhoIYpLbM8wvmUkUKAwEsSgCskn6batI4na7JrJUCGa1f
         11fyES5yxs+XTvJHSgIbe6TgJApeBhmBgklGt8io20lKwgK+d1ktngJn93dHO3dJFtM9
         2YIsDVhV2irv0eNTrPAcHs42mDuCEibhyOcTJWqqcyaY9dOBgkzv4au3IBt1gJnwEW6M
         Yi3IBT9Oqs1unEhmlklzl0tjt5aYgKVkDmGrtJRtcFeluSafhg0VHY5VElbYd/R2WqgI
         aVAp3ysYIGRd0tNAcWnv5EVHD3ysKWpD9xhrJ5k9QYf9mw/dy9NB3vpFJ1F2Hs6xBmGT
         DV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=piX7MZ/AAi4ncX0sPDXAqjMsG1O4fj7Yh16uYtERXCY=;
        b=E4DCsJoWFwNqnQnQJhthOs2JqTo0KT9KZD/3GTDJL60G0LnIVCJl+hp/tVWqkDEEMn
         KoQbzBuRjAmsvRn+AKjlPPU71seDmCcVGPMlQNX9wLTtO90ml27TW9zc0QiBzlCrD/bk
         U5i2GLyAeRLm+ju6EQJnplVbp2C1tKlSx/7VGBAJm4A8dGsvkw98o4QV7MGpPMupVHOM
         B3GyQrpAcTBxEnPHbj/EKBc8HG+kN3g4Xaj4n9+OOEfaMxinc6l82kua6aiIAbd2e6tE
         UrYZ51no112qYhG8Wc5g1fZoz70dvqmJvExZTR1Q8UimwbxwCtj1KWWXlMlMmmQfml4Y
         YVSQ==
X-Gm-Message-State: AGi0PuZqIfFHeJ+/fppjVyJpQLkbrUcdzKGJtJ/w5R4Nc9m2RXLHB1UL
        e3K3xQo/SGwQl+MxEwuF3+s=
X-Google-Smtp-Source: APiQypIAt1ziuKbf/MWDBpYSc/1HahFHFfVmzmDClV5NFlU/krWJydVA3u7N+Uttb7cHbZDT3vFvxA==
X-Received: by 2002:a2e:a40b:: with SMTP id p11mr6488526ljn.173.1585743958538;
        Wed, 01 Apr 2020 05:25:58 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id k3sm1149610lji.43.2020.04.01.05.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 05:25:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Apr 2020 14:25:50 +0200
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
Message-ID: <20200401122550.GA32593@pc636>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331140433.GA26498@pc636>
 <20200331150911.GC236678@google.com>
 <20200331160119.GA27614@pc636>
 <20200331183000.GD236678@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331183000.GD236678@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > I think there should be GFP_ATOMIC used, because it has more chance to
> > return memory then GFP_NOWAIT. I see that Michal has same view on it.
> 
> I don't think so because GFP_ATOMIC implies GFP_NOWAIT. I am Ok with keeping
> the GFP_ATOMIC as it is btw. Paul mentioned he prefers this. I agree with
> that as well.
> 
GFP_ATOMIC can access to reserved memory whereas GFP_NOWAIT is not
eligible to do so. So there is difference between them :)

> > > 
> > > Yes, the benefit of the trace/warning is that the user can switch to a
> > > non-headless API and avoid the synchronize_rcu(), that would help them get
> > > faster kfree_rcu() performance instead of having silent slowdowns.
> > > 
> > Agree. What about just adding WARN_ON_ONCE()? I am just thinking if it
> > could be harmful or not.
> 
> You mean WARN_ON_ONCE() before the synchronize_rcu() right? We could do that.
> Paul mentioned to me he prefers if this new warning can be turned off with a
> boot parameter since some future user may prefer no warning. I also agree.
> 
Yes, we can add it before doing synchronize_rcu(). WARN_ON_ONCE() will
emit only once the warning. I think that would be enough to pay an
attention.

>
> If we add this then we can keep your __GFP_NOWARN flag with no additional GFP
> flag changes.
>
We can also add __GFP_RETRY_MAYFAIL to GFP_ATOMIC to make it more tight.
Basically your patch can be modified just adding that.

> > > It also tells us whether the headless API is worth it in the long run, I
> > > think it is worth it because we will likely never hit the synchronize_rcu()
> > > failsafe. But if we hit it a lot, at least it wont happen silently.
> > > 
> > Agree.
> > 
> > > Paul was concerned about following scenario with hitting synchronize_rcu():
> > > 1. Consider a system under memory pressure.
> > > 2. Consider some other subsystem X depending on another system Y which uses
> > >    kfree_rcu(). If Y doesn't complete the operation in time, X accumulates
> > >    more memory.
> > > 3. Since kfree_rcu() on Y hits synchronize_rcu() a lot, it slows it down.
> > >    This causes X to further allocate memory, further causing a chain
> > >    reaction.
> > > Paul, please correct me if I'm wrong.
> > > 
> > I see your point and agree that in theory it can happen. So, we should
> > make it more tight when it comes to rcu_head attachment logic.
> 
> Right. Per discussion with Paul, we discussed that it is better if we
> pre-allocate N number of array blocks per-CPU and use it for the cache.
> Default for N being 1 and tunable with a boot parameter. I agree with this.
> 
As discussed before, we can make use of memory pool API for such
purpose. But i am not sure if it should be one pool per CPU or
one pool per NR_CPUS, that would contain NR_CPUS * N pre-allocated
blocks.

> In current code, we have 1 cache page per CPU, but this is allocated only on
> the first kvfree_rcu() request. So we could change this behavior as well to
> make it pre-allocated.
> 
> Does this all sound good to you?
> 
I think that makes sense :)

--
Vlad Rezki
