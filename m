Return-Path: <SRS0=r/zf=DZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B316CC433DF
	for <rcu@archiver.kernel.org>; Sun, 18 Oct 2020 20:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9BC2226B
	for <rcu@archiver.kernel.org>; Sun, 18 Oct 2020 20:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JkkpEPD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgJRURK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgJRURK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Oct 2020 16:17:10 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F195C0613CE
        for <rcu@vger.kernel.org>; Sun, 18 Oct 2020 13:17:09 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b8so10540538ioh.11
        for <rcu@vger.kernel.org>; Sun, 18 Oct 2020 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgDhaY7fqK+FMnZC3CevUCCUqcuSuLmtjwQEAUjRcIk=;
        b=JkkpEPD2sKts0GtmZClZI9gb1Rw0shyqd/ZXgWY4aWRGtI5oc4wR/i9RXn+hZOxUwB
         C69dDdh7Z7ObwjuWCebEHpbMBQHXQKdNgtoaY8IaIyTtZSiH7wHtxt6W4dtWt/X/iC35
         06wkrMz8wgTTPzFXrxnEWXvZMEJchYr6RTa+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgDhaY7fqK+FMnZC3CevUCCUqcuSuLmtjwQEAUjRcIk=;
        b=AM+9u1qjRSF7vzQtEdDV3eaoEgvalj+70cOYWadNFAArbAPoSAc7As6Nz8bgJ6PHHW
         iMlC50XD665MOq1L1nPVXyOsJT6Yv20ZYOTARL0+HGhrWgRrWjw1JnHPRDxYqZLOy7d5
         3Izsu6KiJueUQtQhI805vL1tUOVqRpUmMtiMDyRWBcL6CwGrfV5t9PExwFWPedCF6EOB
         qFmsqLbnc32vfMNwEFACfS2rrYp9KWQNKLoLica0J3j62IUOaDylpMAf1e+Fmbln4K/L
         YnoapS2jp/fSNgRDYssqr6pLskhvpyLGh1mZdkQ+JCw26ZPYFjQfTjUEkCWVo6gnOaDN
         d2QA==
X-Gm-Message-State: AOAM533Ul3LtKCl20/qDNb0QBEZe33Qi3QqYuAxf7xJXvQc30H5Ynzsw
        SkwS52v6NWO5OaOrY0H6kxEnPvcUfFf77aZb/xXnIg==
X-Google-Smtp-Source: ABdhPJyIZ5xkld7dr1PxipmOsqVLdHv+ZRVpWzxlQ3NugJHHX+BXmIBfnPdshpg3MTxNJXhXT/vkIPGFv5aowNskOuM=
X-Received: by 2002:a02:ec3:: with SMTP id 186mr1543187jae.92.1603052228687;
 Sun, 18 Oct 2020 13:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org> <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com> <20201017143144.GA835860@rowland.harvard.edu>
In-Reply-To: <20201017143144.GA835860@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Oct 2020 13:16:57 -0700
Message-ID: <CAEXW_YSyshFLYMNia+TGfO11Pi_iojzke1+0SG7anGt2GNUXWg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain smp_mb()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Oct 17, 2020 at 7:31 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Oct 16, 2020 at 09:27:53PM -0400, joel@joelfernandes.org wrote:
> > Adding Alan as well as its memory barrier discussion ;-)
>
> I don't know the internals of how RCU works, so I'll just speak to the
> litmus test itself, ignoring issues of whether the litmus test is
> appropriate or expresses what you really want.
>
> > The following litmus test would confirm it:
> >
> > C rcubarrier+ctrldep
> >
> > (*
> >  * Result: Never
> >  *
> >  * This litmus test shows that rcu_barrier (P1) prematurely
> >  * returning by reading len 0 can cause issues if P0 does
> >  * NOT have a smb_mb() before WRITE_ONCE().
> >  *
> >  * mod_data == 2 means garbage which the callback should never see.
> >  *)
> >
> > { int len = 1; }
> >
> > P0(int *len, int *mod_data)
> > {
> >         int r0;
> >
> >         // accessed by say RCU callback in rcu_do_batch();
> >         r0 = READ_ONCE(*mod_data);
> >         smp_mb(); // Remove this and the "exists" will become true.
> >         WRITE_ONCE(*len, 0);
> > }
> >
> > P1(int *len, int *mod_data)
> > {
> >         int r0;
> >
> >         r0 = READ_ONCE(*len);
> >
> >         // rcu_barrier will return early if len is 0
> >         if (r0 == 0)
> >                 WRITE_ONCE(*mod_data, 2);
> > }
> >
> > // Is it possible?
> > exists (0:r0=2 /\ 1:r0=0)
>
> This result is indeed not possible.  And yes, some sort of memory
> barrier is needed in P0.  But it doesn't have to be smp_mb(); you could
> use a weaker barrier instead.  For example, you could replace the
> READ_ONCE in P0 with smp_load_acquire(), or you could replace the
> WRITE_ONCE with smp_store_release().  Either of those changes would
> suffice to prevent this outcome.

Right, that works as well. The main point I was trying to hit was the
control-dependency hardware ordering in P1 (due to rcu_barrier()
checking for a condition before doing whatever is after the
rcu_barrier()).

thanks,

 - Joel
