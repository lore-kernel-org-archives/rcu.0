Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC77C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 19:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F3820721
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 19:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GObmazAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgEDThq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 15:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726334AbgEDThq (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 15:37:46 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B33CC061A0E
        for <rcu@vger.kernel.org>; Mon,  4 May 2020 12:37:46 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k6so13654796iob.3
        for <rcu@vger.kernel.org>; Mon, 04 May 2020 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdWMO0GZMNFscZNybGWQG3ITswtupKPg+QTxQVbhP58=;
        b=GObmazAbydGljs6lUpNTgX82Yj9VICjxvJsXCRjiEN/IiUC4gN8U8xjGFwFx9O7ill
         ZFs+VP0q2tO0znb2WC0f2LJP3cMcp+e1Muf7XNyClzKjOuvajCxdLCIVo5W1RvjY4uOd
         sLQwXUEOzKPvuukgNeSceNmqwReuSA9lOcGCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdWMO0GZMNFscZNybGWQG3ITswtupKPg+QTxQVbhP58=;
        b=Q4uvhG6Y65ryREatXChHJccD09HxP7BTiUOg33uGl1GnThAI+4MW+7+RPh1m2knZiK
         PZ9Sm5iWi3nYTYrSzE8RUMDXtNEevPvSTJEDDV1QNZaNTMmrxNNUCpoyjnk7X8HGxtRF
         5xGqIyziiYR88PLvTSzKY7xj0EnnamL3wRAWn0vWPA4vSMVaxVD0gIIhK9sCzAC3dC3k
         AJO0xJmarYltC6NmpNNykgJ2Vo3i1dCC1nc87zF8R89y3aI2t/83IN/DUzdzKn1CGgDK
         AtsDAvQzgIeotLF28bGSCxD5L/TBVqLCNY7WgeUfMV6b/sdKS6I851d7rgjk3LHqypd3
         xHCQ==
X-Gm-Message-State: AGi0Puau4AzGOGKCnVv++5W3J5Zt9FsmrQB6qhuk8+wePvoZ6objw8Q6
        1Yt2kljFpoVviGGNfVBx5gGuViQmYOZSoDtK/7qHXw==
X-Google-Smtp-Source: APiQypLQSD4iaEpIO5FjQ3ZmMTHwJnzzJlOFWYJXTb12bjeP6SAD28w06feWRZUOQRwbhUf9KFyI72uv/kTlXn/A57o=
X-Received: by 2002:a6b:bc85:: with SMTP id m127mr3389827iof.89.1588621065701;
 Mon, 04 May 2020 12:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200428205903.61704-1-urezki@gmail.com> <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72> <20200504124323.GA17577@pc636>
 <20200504152437.GK2869@paulmck-ThinkPad-P72> <20200504174822.GA20446@pc636>
 <20200504180805.GA172409@google.com> <20200504190138.GU2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200504190138.GU2869@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 4 May 2020 15:37:33 -0400
Message-ID: <CAEXW_YQmrfbaDocsc7bLULRR1yUv4=MMMEw3b0s1mXM8sEVVzQ@mail.gmail.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Mon, May 4, 2020 at 3:01 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, May 04, 2020 at 02:08:05PM -0400, Joel Fernandes wrote:
> > On Mon, May 04, 2020 at 07:48:22PM +0200, Uladzislau Rezki wrote:
> > > On Mon, May 04, 2020 at 08:24:37AM -0700, Paul E. McKenney wrote:
> > [..]
> > > > > > Presumably the list can also be accessed without holding this lock,
> > > > > > because otherwise we shouldn't need llist...
> > > > > >
> > > > > Hm... We increase the number of elements in cache, therefore it is not
> > > > > lockless. From the other hand i used llist_head to maintain the cache
> > > > > because it is single linked list, we do not need "*prev" link. Also
> > > > > we do not need to init the list.
> > > > >
> > > > > But i can change it to list_head. Please let me know if i need :)
> > > >
> > > > Hmmm...  Maybe it is time for a non-atomic singly linked list?  In the RCU
> > > > callback processing, the operations were open-coded, but they have been
> > > > pushed into include/linux/rcu_segcblist.h and kernel/rcu/rcu_segcblist.*.
> > > >
> > > > Maybe some non-atomic/protected/whatever macros in the llist.h file?
> > > > Or maybe just open-code the singly linked list?  (Probably not the
> > > > best choice, though.)  Add comments stating that the atomic properties
> > > > of the llist functions aren't neded?  Something else?
> > > >
> > > In order to keep it simple i can replace llist_head by the list_head?
> >
> > Just to clarify for me, what is the disadvantage of using llist here?
>
> Are there some llist APIs that are not set up for concurrency?  I am
> not seeing any.

llist deletion racing with another llist deletion will need locking.
So strictly speaking, some locking is possible with llist usage?

The locklessness as I understand comes when adding and deleting at the
same time. For that no lock is needed. But in the current patch, it
locks anyway to avoid the lost-update of the size of the list.

> The overhead isn't that much of a concern, given that these are not on the
> hotpath, but people reading the code and seeing the cmpxchg operations
> might be forgiven for believing that there is some concurrency involved
> somewhere.
>
> Or am I confused and there are now single-threaded add/delete operations
> for llist?

I do see some examples of llist usage with locking in the kernel code.
One case is: do_init_module() calling llist_add to add to the
init_free_list under module_mutex.

> > Since we don't care about traversing backwards, isn't it better to use llist
> > for this usecase?
> >
> > I think Vlad is using locking as we're also tracking the size of the llist to
> > know when to free pages. This tracking could suffer from the lost-update
> > problem without any locking, 2 lockless llist_add happened simulatenously.
> >
> > Also if list_head is used, it will take more space and still use locking.
>
> Indeed, it would be best to use a non-concurrent singly linked list.

Ok cool :-)

Is it safe to say something like the following is ruled out? ;-) :-D
#define kfree_rcu_list_add llist_add

Thanks,

 - Joel
