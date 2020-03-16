Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F6C18E5B
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 19:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E197B20738
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 19:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LTBTLIbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgCPTtD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:49:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42705 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732413AbgCPTtD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 15:49:03 -0400
Received: by mail-io1-f68.google.com with SMTP id q128so18474858iof.9
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAulLL/K9nl7WPQX58DEjYOvZnd3/fsaW830Kox+hjk=;
        b=LTBTLIbgQdtw5KrpvBsI8ssl8mR6+xIp6j4kLagVWfcZ7W/Ium4qmnbjkJ7HLCwkAP
         YRK/Ryq+Zv+gILtayfNug5Po9+k3hMv3NqCkS8o3ttEDKDEshUkBPCZW0T3opBls4cyH
         OPjVJcJUE+pPF7OqBKqq5d13FRhb7IyxAcFm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAulLL/K9nl7WPQX58DEjYOvZnd3/fsaW830Kox+hjk=;
        b=CJ1mY+dlzmF61HOLdUe3hthYqvCMtJGlponDA22gv9xwTdKmkSdbpTQiI3V8Bt0o5J
         ODPhvw3GQw0EeZCdkpgKxtu1cyKcJRH9L08tpoQp1Haw91mMMUCqBzMQ+T6eWgv3XLkh
         EWN4lZsS9GYGRdwh9Lr3TTomjKwedPs37tL1MMMJPaaqmhXrgpZQ1YpW5L4XRFPjnsRA
         WKqgDLf6PN/z3XCI8mMcoocdMfo0ssa/z/nKBGBGz7nAfOIo6vvpojiWfAo9f+LxK5Uc
         FGtWYoPhjT6EidBpeqcoAij6Q1LbGh1CXieOV0/U6V4HT/xeZoZynxGTQTfpML3PwGP+
         9CzQ==
X-Gm-Message-State: ANhLgQ3zubbCzEuz9LU0yn8buFHDUzvIcgCqjN7831nsMKVARYTw/xyE
        XZMxC9Wguis+h0+NlX/QBUBV/UaEKpwf533R/qlH4Xrc
X-Google-Smtp-Source: ADFU+vuayngz9YaJtaVGIly59Sgm+6ViqZD7So1sh0Hj3HHu4egzZJxefvbqYhkR8xrd7b7qq5Y8rCkfF3xd6t/PPiM=
X-Received: by 2002:a6b:610b:: with SMTP id v11mr715215iob.154.1584388140375;
 Mon, 16 Mar 2020 12:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200315181840.6966-1-urezki@gmail.com> <20200315181840.6966-3-urezki@gmail.com>
 <20200316154539.GE190951@google.com> <20200316185519.GA10577@pc636>
 <CAEXW_YQGtgBpzuQqGMfWObxKr-MtK==caoLyw8TtU_79PX4JhQ@mail.gmail.com> <20200316190345.GA10679@pc636>
In-Reply-To: <20200316190345.GA10679@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 16 Mar 2020 15:48:49 -0400
Message-ID: <CAEXW_YQA9-J0HTHegq4iDxfwOZT8Ew9ueAQTtK_xf9c6tA1Lyg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] rcu: introduce kvfree_rcu() interface
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 16, 2020 at 3:03 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Mon, Mar 16, 2020 at 02:57:18PM -0400, Joel Fernandes wrote:
> > On Mon, Mar 16, 2020 at 2:55 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > On Mon, Mar 16, 2020 at 11:45:39AM -0400, Joel Fernandes wrote:
> > > > On Sun, Mar 15, 2020 at 07:18:36PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > kvfree_rcu() can deal with an allocated memory that is obtained
> > > > > via kvmalloc(). It can return two types of allocated memory or
> > > > > "pointers", one can belong to regular SLAB allocator and another
> > > > > one can be vmalloc one. It depends on requested size and memory
> > > > > pressure.
> > > > >
> > > > > Based on that, two streams are split, thus if a pointer belongs
> > > > > to vmalloc allocator it is queued to the list, otherwise SLAB
> > > > > one is queued into "bulk array" for further processing.
> > > > >
> > > > > The main reason of such splitting is:
> > > > >     a) to distinguish kmalloc()/vmalloc() ptrs;
> > > > >     b) there is no vmalloc_bulk() interface.
> > > > >
> > > > > As of now we have list_lru.c user that needs such interface,
> > > > > also there will be new comers. Apart of that it is preparation
> > > > > to have a head-less variant later.
> > > > >
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > ---
> > > > >  include/linux/rcupdate.h |  9 +++++++++
> > > > >  kernel/rcu/tiny.c        |  3 ++-
> > > > >  kernel/rcu/tree.c        | 17 ++++++++++++-----
> > > > >  3 files changed, 23 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > > index 2be97a83f266..bb270221dbdc 100644
> > > > > --- a/include/linux/rcupdate.h
> > > > > +++ b/include/linux/rcupdate.h
> > > > > @@ -845,6 +845,15 @@ do {                                                                   \
> > > > >             __kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
> > > > >  } while (0)
> > > > >
> > > > > +/**
> > > > > + * kvfree_rcu() - kvfree an object after a grace period.
> > > > > + * @ptr:   pointer to kvfree
> > > > > + * @rhf:   the name of the struct rcu_head within the type of @ptr.
> > > > > + *
> > > > > + * Same as kfree_rcu(), just simple alias.
> > > > > + */
> > > > > +#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
> > > > > +
> > > > >  /*
> > > > >   * Place this after a lock-acquisition primitive to guarantee that
> > > > >   * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
> > > > > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > > > > index dd572ce7c747..4b99f7b88bee 100644
> > > > > --- a/kernel/rcu/tiny.c
> > > > > +++ b/kernel/rcu/tiny.c
> > > > > @@ -23,6 +23,7 @@
> > > > >  #include <linux/cpu.h>
> > > > >  #include <linux/prefetch.h>
> > > > >  #include <linux/slab.h>
> > > > > +#include <linux/mm.h>
> > > > >
> > > > >  #include "rcu.h"
> > > > >
> > > > > @@ -86,7 +87,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
> > > > >     rcu_lock_acquire(&rcu_callback_map);
> > > > >     if (__is_kfree_rcu_offset(offset)) {
> > > > >             trace_rcu_invoke_kfree_callback("", head, offset);
> > > > > -           kfree((void *)head - offset);
> > > > > +           kvfree((void *)head - offset);
> > > > >             rcu_lock_release(&rcu_callback_map);
> > > > >             return true;
> > > > >     }
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 2f4c91a3713a..1c0a73616872 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2899,9 +2899,9 @@ static void kfree_rcu_work(struct work_struct *work)
> > > > >     }
> > > > >
> > > > >     /*
> > > > > -    * Emergency case only. It can happen under low memory
> > > > > -    * condition when an allocation gets failed, so the "bulk"
> > > > > -    * path can not be temporary maintained.
> > > > > +    * vmalloc() pointers end up here also emergency case. It can
> > > >
> > > > Suggest rephrase for clarity:
> > > >
> > > > nit: We can end up here either with 1) vmalloc() pointers or 2) low on memory
> > > > and could not allocate a bulk array.
> > > >
> > > Let's go with your suggestion. I see that you took patches to your tree.
> > > Could you please update it on your own? Otherwise i can send out V2, so
> > > please let me know.
> >
> > I updated it, "patch -p1" resolved the issue. No need to resend unless
> > something in my tree looks odd to you :)
> >
> I knew that! Thanks :)

Thank you Vlad :)

 - Joel
