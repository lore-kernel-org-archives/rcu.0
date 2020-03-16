Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3705FC0044D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 18:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB093206E2
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 18:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="S2q3zWjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbgCPS5a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:57:30 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44546 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbgCPS5a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 14:57:30 -0400
Received: by mail-il1-f193.google.com with SMTP id j69so17615860ila.11
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpWTaUSi6v0noh8eXI8lxQn+nN2Hg8Fm3JarhKjNCVQ=;
        b=S2q3zWjFSql68wKbxgm+z6Jm1ZtnKdmewCiM7m1MFbWPR+rsJMp34nOtUhRfH7qcrr
         SI+iAy8IAdsVDNBsL591WUGfMpxNVfcvb2ndcKnCIFqbe7hyvJp8SUlWO1558ansEw1w
         lyPP36N64p2FXv+ytKdFv04K7SdB4j8uBfkhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpWTaUSi6v0noh8eXI8lxQn+nN2Hg8Fm3JarhKjNCVQ=;
        b=hGW4KSSvyZnrkbWaulmXZ8l9oZWUFYEHuAax+ZiCqZWR7fy/tSbAEszY8djGQGhpvP
         7dDaxQAyIP1sTqHiba9FxegFGIl1Hg/D+bNQA8Lj+swTUk6AIfdHj9Hn+WgsbUzZ+mxq
         s1wcsWBAU4JrhiqcdUwKgSS8LCg4wcnTK54WoqGYhERDOR20pG09ES9EyY0d8J8BPtUX
         G9iJ6HKGO2gjDbLDfYb5SMgQ6aUDlEUklJUWgfH7u6yHYgvLuejfYQdBfQ2pa3XnG9UH
         dRtqMT0nmMDTet9ZBe/2IlOHd6UF+qkGvUohnGLvWTQAlF3uUwZvEddJGMHF4TCneEka
         +shQ==
X-Gm-Message-State: ANhLgQ0CXMPb5K2oSjSpbal8/XFfbVYy6zzSTvBxnRSRdrMlUxKnLs6/
        Sg7S9gIta+mHrTJaHEnw67OQCuk6Y6F4nRSpCpfFAg==
X-Google-Smtp-Source: ADFU+vsTMCdMbf/TW3u1G71bFbKTUZLeeWWRHJx+0Uwb7v9fs+ZLX8dI0FbujMMNMydD9Bp0yCAmReFZ5uMpaLSZHlQ=
X-Received: by 2002:a05:6e02:bc7:: with SMTP id c7mr1354868ilu.78.1584385049631;
 Mon, 16 Mar 2020 11:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200315181840.6966-1-urezki@gmail.com> <20200315181840.6966-3-urezki@gmail.com>
 <20200316154539.GE190951@google.com> <20200316185519.GA10577@pc636>
In-Reply-To: <20200316185519.GA10577@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 16 Mar 2020 14:57:18 -0400
Message-ID: <CAEXW_YQGtgBpzuQqGMfWObxKr-MtK==caoLyw8TtU_79PX4JhQ@mail.gmail.com>
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

On Mon, Mar 16, 2020 at 2:55 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Mon, Mar 16, 2020 at 11:45:39AM -0400, Joel Fernandes wrote:
> > On Sun, Mar 15, 2020 at 07:18:36PM +0100, Uladzislau Rezki (Sony) wrote:
> > > kvfree_rcu() can deal with an allocated memory that is obtained
> > > via kvmalloc(). It can return two types of allocated memory or
> > > "pointers", one can belong to regular SLAB allocator and another
> > > one can be vmalloc one. It depends on requested size and memory
> > > pressure.
> > >
> > > Based on that, two streams are split, thus if a pointer belongs
> > > to vmalloc allocator it is queued to the list, otherwise SLAB
> > > one is queued into "bulk array" for further processing.
> > >
> > > The main reason of such splitting is:
> > >     a) to distinguish kmalloc()/vmalloc() ptrs;
> > >     b) there is no vmalloc_bulk() interface.
> > >
> > > As of now we have list_lru.c user that needs such interface,
> > > also there will be new comers. Apart of that it is preparation
> > > to have a head-less variant later.
> > >
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  include/linux/rcupdate.h |  9 +++++++++
> > >  kernel/rcu/tiny.c        |  3 ++-
> > >  kernel/rcu/tree.c        | 17 ++++++++++++-----
> > >  3 files changed, 23 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 2be97a83f266..bb270221dbdc 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -845,6 +845,15 @@ do {                                                                   \
> > >             __kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
> > >  } while (0)
> > >
> > > +/**
> > > + * kvfree_rcu() - kvfree an object after a grace period.
> > > + * @ptr:   pointer to kvfree
> > > + * @rhf:   the name of the struct rcu_head within the type of @ptr.
> > > + *
> > > + * Same as kfree_rcu(), just simple alias.
> > > + */
> > > +#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
> > > +
> > >  /*
> > >   * Place this after a lock-acquisition primitive to guarantee that
> > >   * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
> > > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > > index dd572ce7c747..4b99f7b88bee 100644
> > > --- a/kernel/rcu/tiny.c
> > > +++ b/kernel/rcu/tiny.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/cpu.h>
> > >  #include <linux/prefetch.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/mm.h>
> > >
> > >  #include "rcu.h"
> > >
> > > @@ -86,7 +87,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
> > >     rcu_lock_acquire(&rcu_callback_map);
> > >     if (__is_kfree_rcu_offset(offset)) {
> > >             trace_rcu_invoke_kfree_callback("", head, offset);
> > > -           kfree((void *)head - offset);
> > > +           kvfree((void *)head - offset);
> > >             rcu_lock_release(&rcu_callback_map);
> > >             return true;
> > >     }
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 2f4c91a3713a..1c0a73616872 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2899,9 +2899,9 @@ static void kfree_rcu_work(struct work_struct *work)
> > >     }
> > >
> > >     /*
> > > -    * Emergency case only. It can happen under low memory
> > > -    * condition when an allocation gets failed, so the "bulk"
> > > -    * path can not be temporary maintained.
> > > +    * vmalloc() pointers end up here also emergency case. It can
> >
> > Suggest rephrase for clarity:
> >
> > nit: We can end up here either with 1) vmalloc() pointers or 2) low on memory
> > and could not allocate a bulk array.
> >
> Let's go with your suggestion. I see that you took patches to your tree.
> Could you please update it on your own? Otherwise i can send out V2, so
> please let me know.

I updated it, "patch -p1" resolved the issue. No need to resend unless
something in my tree looks odd to you :)

> Thanks for the comments!

Thanks!

- Joel
