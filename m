Return-Path: <SRS0=M2zx=DY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED80C43467
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 06:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980C020720
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 06:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Zan+t+O/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436592AbgJQGCl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Oct 2020 02:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436492AbgJQGBi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:38 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4A5C0613AB
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2020 18:27:56 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q9so6190195iow.6
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2020 18:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1mC7Qdj24SnH/7EzRXDQ5V+/TOC1w0x5xtB4YoqPuqI=;
        b=Zan+t+O/PRm8iyQ4VqXg5RtvDGjL8nVnpIL4uSZoJcDXx7nxZjG1WX9ize9n/18Bp/
         U+Fi0AWUZ40fl7iSgajSgORUhvjF3M6PUp6aMXpDGv4M4n8LhNh1w+mLRvWn0+mH9+LK
         TBSM4Nx15zFeqWgw0EwnEjCeCoM6f/0yW9V14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1mC7Qdj24SnH/7EzRXDQ5V+/TOC1w0x5xtB4YoqPuqI=;
        b=CtZuaL2IkndJKwyqiYZwqXTlf4/VgSPFdqMzWeEjzufwM6pc8F8gVNlMXHxWUL1aCv
         cTZajYTgLL9iewZRHEHLM2Z8CA2POdlrQLgaABrSRiAkCFCNPahguwo3Qd1mC2Zys4QH
         5TF79pfufCyUtb3OXsfm/OwaQvRvViSTrJYg0SXGeB/ohOyxwL2xSWeFAUvWge6xkNbu
         0BxMR95hCbGcOfJsh8Tiq15cFBdz3hWl5usV8fhdsfrMZFJGOUOVG9e8dd3wjc6CZC27
         bo8ZAJU4x0kuQQ1A603Ch9CnN3Di2EW3oCPqWR7MYrMbftdrnEfmfGvSZYqYFNMyfW/l
         2CLg==
X-Gm-Message-State: AOAM531sz0TU6G9So6HAcKZv7tyXvxcnaXXbMN0OFWkfAW6/4OK8usod
        0vFk3/nf+Yghl1G54SvaHShcxw==
X-Google-Smtp-Source: ABdhPJyVAo5QMjBsmFUA3c8nZJQhPB+fEDhhw22eiSGQabGYlV1qftSBpnBAMzHBVFsii3iYQxdOdg==
X-Received: by 2002:a6b:5c06:: with SMTP id z6mr4516686ioh.49.1602898075611;
        Fri, 16 Oct 2020 18:27:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g17sm3491311ilq.15.2020.10.16.18.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 18:27:54 -0700 (PDT)
Date:   Fri, 16 Oct 2020 21:27:53 -0400
From:   joel@joelfernandes.org
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com, stern@rowland.harvard.edu
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain
 smp_mb()
Message-ID: <20201017012753.GB4015033@google.com>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org>
 <20201015133511.GB127222@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015133511.GB127222@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Adding Alan as well as its memory barrier discussion ;-)

On Thu, Oct 15, 2020 at 03:35:11PM +0200, Frederic Weisbecker wrote:
> On Wed, Oct 14, 2020 at 08:23:01PM -0400, Joel Fernandes (Google) wrote:
> > Memory barriers are needed when updating the full length of the
> > segcblist, however it is not fully clearly why one is needed before and
> > after. This patch therefore adds additional comments to the function
> > header to explain it.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/rcu_segcblist.c | 38 ++++++++++++++++++++++++++++++++++----
> >  1 file changed, 34 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 271d5d9d7f60..25ffd07f9951 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -147,17 +147,47 @@ static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
> >   * field to disagree with the actual number of callbacks on the structure.
> >   * This increase is fully ordered with respect to the callers accesses
> >   * both before and after.
> > + *
> > + * About memory barriers:
> > + * There is a situation where rcu_barrier() locklessly samples the full
> > + * length of the segmented cblist before deciding what to do. That can
> > + * race with another path that calls this function. rcu_barrier() should
> > + * not wrongly assume there are no callbacks, so any transitions from 1->0
> > + * and 0->1 have to be carefully ordered with respect to list modifications.
> > + *
> > + * Memory barrier is needed before adding to length, for the case where
> > + * v is negative which does not happen in current code, but used
> > + * to happen. Keep the memory barrier for robustness reasons.
> 
> Heh, I seem to recongnize someone's decision's style ;-)

Actually, the last paragraph I added is bogus. Indeed this memory barrier is
not just for robustness reasons. It is needed because rcu_do_batch() adjusts
the length of the list (possibly to 0) _after_ executing the callbacks, so
that's a negative number:
        rcu_segcblist_add_len(&rdp->cblist, -count);

> >     When/If the
> > + * length transitions from 1 -> 0, the write to 0 has to be ordered *after*
> > + * the memory accesses of the CBs that were dequeued and the segcblist
> > + * modifications:
> > + * P0 (what P1 sees)	P1
> > + * set len = 0
> > + *                      rcu_barrier sees len as 0
> > + * dequeue from list
> > + *                      rcu_barrier does nothing.
> 
> It's a bit difficult to read that way. So that would be:
> 
> 
>       rcu_do_batch()                rcu_barrier()
>       --                            --
>       dequeue                       l = READ(len)
>       smp_mb()                      if (!l)
>       WRITE(len, 0)                     check next CPU...
> 
> But I'm a bit confused against what it pairs in rcu_barrier().

I believe it pairs with an implied memory barrier via control dependency.

The following litmus test would confirm it:

C rcubarrier+ctrldep

(*
 * Result: Never
 *
 * This litmus test shows that rcu_barrier (P1) prematurely
 * returning by reading len 0 can cause issues if P0 does
 * NOT have a smb_mb() before WRITE_ONCE().
 *
 * mod_data == 2 means garbage which the callback should never see.
 *)

{ int len = 1; }

P0(int *len, int *mod_data)
{
        int r0;

        // accessed by say RCU callback in rcu_do_batch();
        r0 = READ_ONCE(*mod_data);
        smp_mb(); // Remove this and the "exists" will become true.
        WRITE_ONCE(*len, 0);
}

P1(int *len, int *mod_data)
{
        int r0;

        r0 = READ_ONCE(*len);

        // rcu_barrier will return early if len is 0
        if (r0 == 0)
                WRITE_ONCE(*mod_data, 2);
}

// Is it possible?
exists (0:r0=2 /\ 1:r0=0)

> > + *
> > + * Memory barrier is needed after adding to length for the case
> > + * where length transitions from 0 -> 1. This is because rcu_barrier()
> > + * should never miss an update to the length. So the update to length
> > + * has to be seen *before* any modifications to the segmented list. Otherwise a
> > + * race can happen.
> > + * P0 (what P1 sees)	P1
> > + * queue to list
> > + *                      rcu_barrier sees len as 0
> > + * set len = 1.
> > + *                      rcu_barrier does nothing.
> 
> So that would be:
> 
>       call_rcu()                    rcu_barrier()
>       --                            --
>       WRITE(len, len + 1)           l = READ(len)
>       smp_mb()                      if (!l)
>       queue                            check next CPU...
> 
> 
> But I still don't see against what it pairs in rcu_barrier.

Actually, for the second case maybe a similar reasoning can be applied
(control dependency) but I'm unable to come up with a litmus test.
In fact, now I'm wondering how is it possible that call_rcu() races with
rcu_barrier(). The module should ensure that no more call_rcu() should happen
before rcu_barrier() is called.

confused,

 - Joel

