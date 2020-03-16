Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC8C0044D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 19:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE07520663
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 19:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYKFFbhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbgCPTD4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:03:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43721 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbgCPTD4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 15:03:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id r7so19958586ljp.10;
        Mon, 16 Mar 2020 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OZWbwX7u1vNB6am3krrLHb+DlLOw98xvwL/+mjyqxHg=;
        b=pYKFFbhZhRbaWTH1FjswDSkgTu0oUeK3jmuKuP2jJziIsAcHTZZuhmrHyIKzIOyoef
         R24h6m6UqzDUraTB8zUeXGkmvPzs+Xuotr9VD1afLpPpSPfvnUBV5DwZv6i6BJp5zl4D
         GT9DjVZQ8v12ONyW1WjgVQ3iWa5p9QlD3OJcC6DrQTKQQsbgpGKfa9m2eBlQZ/RZ+i4k
         KhixoJ8iBkl1mdobyvj0kjtHjs3NfdD7nJ7nqu86Ow3D0G10tdlX5V6WEAAlwpsqIzyU
         Q2CRTDN1qxXRPvEYu+5dBwzXy3cMi4sbhxg5ISv9jhuSxFg75f5U6lUegvb8d1adNtsC
         1IoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OZWbwX7u1vNB6am3krrLHb+DlLOw98xvwL/+mjyqxHg=;
        b=B/PncSmOsGU3K+bTrh0bj0HknUlknI1oqiOYwbbfT9v1/1W5u7po1jzw5Am8JC7XbI
         /oGyW/PmujsCp5Wc6LqNhM31CT+fnqWCUXtOfIErLAEkp/fMJaheBiKAh1CjPDWvXitF
         o8rCzlZ/zzWv5XofLXn7b4P4cqNwal6nunvhaDQGBTRhA0ZQLuUTiSGGvxkoHv3K9bcs
         UFZ7CUWriX4n+sHBXPDLPV5uf9cUV7dIrs/Dz/myPaqVfhAyII+QaUH6odDU/eWyeMvl
         AQS9YASHbdGsioIj3HQP3QKXcdSTelnh1Ds4qErWJXeep2X1BH6cU9bT9R3V12arPGUy
         y2Dw==
X-Gm-Message-State: ANhLgQ0zlK9T9NKhrGp90DhK9/aoPhgU2huzUc+1d5dKTSTHv94H8Omu
        HqktatQu3M7Ds9En/txskkc=
X-Google-Smtp-Source: ADFU+vtuYtn3DcslmydvspZPIiz0NVm1ULIH1GnWdEsoSyk2jylJyAQFzBB7ZbGyhoaHqW6hV0edsQ==
X-Received: by 2002:a2e:95c3:: with SMTP id y3mr438729ljh.149.1584385433028;
        Mon, 16 Mar 2020 12:03:53 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l11sm537057lfg.87.2020.03.16.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 12:03:52 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Mar 2020 20:03:45 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 2/6] rcu: introduce kvfree_rcu() interface
Message-ID: <20200316190345.GA10679@pc636>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-3-urezki@gmail.com>
 <20200316154539.GE190951@google.com>
 <20200316185519.GA10577@pc636>
 <CAEXW_YQGtgBpzuQqGMfWObxKr-MtK==caoLyw8TtU_79PX4JhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQGtgBpzuQqGMfWObxKr-MtK==caoLyw8TtU_79PX4JhQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 16, 2020 at 02:57:18PM -0400, Joel Fernandes wrote:
> On Mon, Mar 16, 2020 at 2:55 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Mon, Mar 16, 2020 at 11:45:39AM -0400, Joel Fernandes wrote:
> > > On Sun, Mar 15, 2020 at 07:18:36PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > kvfree_rcu() can deal with an allocated memory that is obtained
> > > > via kvmalloc(). It can return two types of allocated memory or
> > > > "pointers", one can belong to regular SLAB allocator and another
> > > > one can be vmalloc one. It depends on requested size and memory
> > > > pressure.
> > > >
> > > > Based on that, two streams are split, thus if a pointer belongs
> > > > to vmalloc allocator it is queued to the list, otherwise SLAB
> > > > one is queued into "bulk array" for further processing.
> > > >
> > > > The main reason of such splitting is:
> > > >     a) to distinguish kmalloc()/vmalloc() ptrs;
> > > >     b) there is no vmalloc_bulk() interface.
> > > >
> > > > As of now we have list_lru.c user that needs such interface,
> > > > also there will be new comers. Apart of that it is preparation
> > > > to have a head-less variant later.
> > > >
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  include/linux/rcupdate.h |  9 +++++++++
> > > >  kernel/rcu/tiny.c        |  3 ++-
> > > >  kernel/rcu/tree.c        | 17 ++++++++++++-----
> > > >  3 files changed, 23 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index 2be97a83f266..bb270221dbdc 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -845,6 +845,15 @@ do {                                                                   \
> > > >             __kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
> > > >  } while (0)
> > > >
> > > > +/**
> > > > + * kvfree_rcu() - kvfree an object after a grace period.
> > > > + * @ptr:   pointer to kvfree
> > > > + * @rhf:   the name of the struct rcu_head within the type of @ptr.
> > > > + *
> > > > + * Same as kfree_rcu(), just simple alias.
> > > > + */
> > > > +#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
> > > > +
> > > >  /*
> > > >   * Place this after a lock-acquisition primitive to guarantee that
> > > >   * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
> > > > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > > > index dd572ce7c747..4b99f7b88bee 100644
> > > > --- a/kernel/rcu/tiny.c
> > > > +++ b/kernel/rcu/tiny.c
> > > > @@ -23,6 +23,7 @@
> > > >  #include <linux/cpu.h>
> > > >  #include <linux/prefetch.h>
> > > >  #include <linux/slab.h>
> > > > +#include <linux/mm.h>
> > > >
> > > >  #include "rcu.h"
> > > >
> > > > @@ -86,7 +87,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
> > > >     rcu_lock_acquire(&rcu_callback_map);
> > > >     if (__is_kfree_rcu_offset(offset)) {
> > > >             trace_rcu_invoke_kfree_callback("", head, offset);
> > > > -           kfree((void *)head - offset);
> > > > +           kvfree((void *)head - offset);
> > > >             rcu_lock_release(&rcu_callback_map);
> > > >             return true;
> > > >     }
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 2f4c91a3713a..1c0a73616872 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2899,9 +2899,9 @@ static void kfree_rcu_work(struct work_struct *work)
> > > >     }
> > > >
> > > >     /*
> > > > -    * Emergency case only. It can happen under low memory
> > > > -    * condition when an allocation gets failed, so the "bulk"
> > > > -    * path can not be temporary maintained.
> > > > +    * vmalloc() pointers end up here also emergency case. It can
> > >
> > > Suggest rephrase for clarity:
> > >
> > > nit: We can end up here either with 1) vmalloc() pointers or 2) low on memory
> > > and could not allocate a bulk array.
> > >
> > Let's go with your suggestion. I see that you took patches to your tree.
> > Could you please update it on your own? Otherwise i can send out V2, so
> > please let me know.
> 
> I updated it, "patch -p1" resolved the issue. No need to resend unless
> something in my tree looks odd to you :)
> 
I knew that! Thanks :)

--
Vlad Rezki
