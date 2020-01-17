Return-Path: <SRS0=lUfD=3G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C075CC33CB6
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4532082F
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 18:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JtGkifbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgAQS5g (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:57:36 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35277 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgAQS5f (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Jan 2020 13:57:35 -0500
Received: by mail-pj1-f67.google.com with SMTP id s7so3722883pjc.0
        for <rcu@vger.kernel.org>; Fri, 17 Jan 2020 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NmnH67VgTZEvzEjdO/17KatJ4dcLva0dY0MIR3KbJzY=;
        b=JtGkifbOudZxB6+NSfM0AGObm0KIY7W8IaNzTuht4E/IZJXfpKii3CLy03r4QMKet6
         C4mxcrbLB7uXp/yk3JOchupFxBpvAJ9w+GUSCqrc06TCyJR/QOu+7mRqUvMlKc9nE4E8
         Zdqa4AQhWJ5dAkRqv4qUJPgBz9HEgvjMTx8SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NmnH67VgTZEvzEjdO/17KatJ4dcLva0dY0MIR3KbJzY=;
        b=djt2WJiaU6yRx6eX21KdodO59ygl22FIwmbZ4rxcEFHVyo2j3+5VJKOy4SE/znOkoF
         kw8vd3vXv42BpKLX33mdat8Z9qTLjQcjtpeXoI1Dlr+E2oC/xNzZkS2vhAONuEr3DLlL
         gYzVbBBju/o7qwYNDzhlRrcTx3bFQaMngAqfvUCXh7bj7G8fNWHR295a9Mgzx2gpA3cy
         pKmLXE2z/YJGUR7Uq9S2hnzPvts/i/eEjTHZGjplSKoUN97eDQlQPVCqmvwAnWlOcg/i
         Bh4BPom01e/ApiQ3N8Bl2CgLRHYVrUFZfOG95/fxhdogDF8mwgZloWJxQYeyF0Jd7yi8
         DKEw==
X-Gm-Message-State: APjAAAVELGDtcm7uB9vtMkfeuUrtXIv+32uhDi5ySJkY2JT5vC9130cU
        +77pxSPjV4z/9cNnuuTE6DvTgQ==
X-Google-Smtp-Source: APXvYqyf32SnzSu8+Npr3PLDeXL/7Skhne7JHQaG1eoOMWlpqDaNGkTg/9+ZaKDFi8+YOWLiCwHnFA==
X-Received: by 2002:a17:90a:3643:: with SMTP id s61mr7463444pjb.44.1579287454804;
        Fri, 17 Jan 2020 10:57:34 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k23sm28289298pgg.7.2020.01.17.10.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 10:57:33 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:57:32 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200117185732.GH246464@google.com>
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200113190315.GA12543@paulmck-ThinkPad-P72>
 <20200114164937.GA50403@google.com>
 <20200115131446.GA18417@pc636>
 <20200115225350.GA246464@google.com>
 <20200117175217.GA23622@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117175217.GA23622@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 17, 2020 at 06:52:17PM +0100, Uladzislau Rezki wrote:
> > > > > But rcuperf uses a single block size, which turns into kfree_bulk() using
> > > > > a single slab, which results in good locality of reference.  So I have to
> > > > 
> > > > You meant a "single cache" category when you say "single slab"? Just to
> > > > mention, the number of slabs (in a single cache) when a large number of
> > > > objects are allocated is more than 1 (not single). With current rcuperf, I
> > > > see 100s of slabs (each slab being one page) in the kmalloc-32 cache. Each
> > > > slab contains around 128 objects of type kfree_rcu (24 byte object aligned to
> > > > 32-byte slab object).
> > > > 
> > > I think that is about using different slab caches to break locality. It
> > > makes sense, IMHO, because usually the system make use of different slabs,
> > > because of different object sizes. From the other hand i guess there are
> > > test cases when only one slab gets used.
> > 
> > I was wondering about "locality". A cache can be split into many slabs. Only
> > the data on a page is local (contiguous). If there are a large number of
> > objects, then it goes to a new slab (on the same cache). At least on the
> > kmalloc slabs, there is only 1 slab per page. So for example, if on
> > kmalloc-32 slab, there are more than 128 objects, then it goes to a different
> > slab / page. So how is there still locality?
> > 
> Hmm.. On a high level:
> 
> one slab cache manages a specific object size, i.e. the slab memory consists of
> contiguous pages(when increased probably not) of memory(4096 bytes or so) divided
> into equal object size. For example when kmalloc() gets called, the appropriate
> cache size(slab that serves only specific size) is selected and an object assigned
> from it is returned.
> 
> But that is theory and i have not deeply analyzed how the SLAB works internally,
> so i can be wrong :)
> 
> You mentioned 128 objects per one slab in the kmalloc-32 slab-cache. But all of
> them follows each other, i mean it is sequential and is like regular array. In

Yes, for these 128 objects it is sequential. But the next 128 could be on
some other page is what I was saying  And we are allocating 10s of 1000s of
objects in this test.  (I believe pages are sequential only per slab and not
for a different slab within same cache).

> that sense freeing can be beneficial because when an access is done to any object
> whole CPU cache-line is fetched(if it was not before), usually it is 64K.

You mean size of the whole L1 cache right? cachelines are in the order of bytes.

> That is what i meant "locality". In order to "break it" i meant to allocate from
> different slabs to see how kfree_slub() behaves in that sense, what is more real
> scenario and workload, i think.

Ok, agreed.
(BTW I do agree your patch is beneficial, just wanted to get the slab
discussion right).

thanks,

 - Joel

