Return-Path: <SRS0=lUfD=3G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9F1C33CB3
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 17:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EF62072B
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 17:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keopsm+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgAQRw2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:52:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34176 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQRw2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Jan 2020 12:52:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so27356805ljg.1;
        Fri, 17 Jan 2020 09:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7SLBslMTron5CoDazO5Pc97XqvZGpRwv9uincOn+XEQ=;
        b=keopsm+jdLEPkcWO5PTzlEOVhbk9veT9Rbt+9bPC3zBed3/sJ88AkA0RKI5G1GDBKZ
         5RFGHS2lhaDDecRVFEES3H87S4wT8RdcBQ3l5NMpg0LKoam4w8YyiFPABs9myOLHmbk1
         u7dfgC1EEwsfgfPFHYWUoaVsVK+tA3HeAeokBWn/wbW1KS2jOCXIh5NiGxMTIQbtcnJ3
         AUa3MnvzeB3I7JhZfzEYMjBqQS6K0k2BVqU/5FrI0/JQQzx1d4EHk8zrPg7yhwjaAZEv
         vhKoyKOliO837dOt1afb2xzP9qJcuMM7chjwVfxwCcFQi7BFHbElmVVpzEszXWU9HQO9
         iXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7SLBslMTron5CoDazO5Pc97XqvZGpRwv9uincOn+XEQ=;
        b=kXaHxL/pDxThyOveJlEtaH9PB8q5PLOV2ZjpZZeGkT7h74KxwOqri/mRrDMsZzEZR4
         xrll5GHbWn6uTqYABehAogB+CAnxa1faLLAxKDzP/k4Ij2YfYolfIneaJewmV+ozIXLe
         oZD+Edh+q9gcKQ8LJM1w4kReeiOv8KdvT6UhcpOM/JhhXOPpzOjF+uZilb02o55ojpWt
         GsoPE7I04227ZuPo0gX2WM0AVWGTepLE35LBN9eR7yEe8L2SVcspThJ/n5iFCmObG9iy
         YDtIdMERL7mU9rdGWLnwUcduLq5amFHWb/qgEAAs7enqVvstQWpNnw7yS6VIo2eXpyUJ
         HMMw==
X-Gm-Message-State: APjAAAU08eVJICkv2zqGZZXTj11BYnVNNVBZ0TmpUtZ6CFE/qrr+xUw5
        lSEtCtkdhc4umEjD5ajURuI=
X-Google-Smtp-Source: APXvYqx/xY6mBjX4TqtkNzjok6XvYIF9TLL3cZHvjR5MzG0L93+KKIOJZPZWTAyjF0rWONLxNzqmRw==
X-Received: by 2002:a2e:3608:: with SMTP id d8mr6363971lja.152.1579283545812;
        Fri, 17 Jan 2020 09:52:25 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id t29sm12429175lfg.84.2020.01.17.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 09:52:25 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 17 Jan 2020 18:52:17 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200117175217.GA23622@pc636>
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200113190315.GA12543@paulmck-ThinkPad-P72>
 <20200114164937.GA50403@google.com>
 <20200115131446.GA18417@pc636>
 <20200115225350.GA246464@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115225350.GA246464@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > > But rcuperf uses a single block size, which turns into kfree_bulk() using
> > > > a single slab, which results in good locality of reference.  So I have to
> > > 
> > > You meant a "single cache" category when you say "single slab"? Just to
> > > mention, the number of slabs (in a single cache) when a large number of
> > > objects are allocated is more than 1 (not single). With current rcuperf, I
> > > see 100s of slabs (each slab being one page) in the kmalloc-32 cache. Each
> > > slab contains around 128 objects of type kfree_rcu (24 byte object aligned to
> > > 32-byte slab object).
> > > 
> > I think that is about using different slab caches to break locality. It
> > makes sense, IMHO, because usually the system make use of different slabs,
> > because of different object sizes. From the other hand i guess there are
> > test cases when only one slab gets used.
> 
> I was wondering about "locality". A cache can be split into many slabs. Only
> the data on a page is local (contiguous). If there are a large number of
> objects, then it goes to a new slab (on the same cache). At least on the
> kmalloc slabs, there is only 1 slab per page. So for example, if on
> kmalloc-32 slab, there are more than 128 objects, then it goes to a different
> slab / page. So how is there still locality?
> 
Hmm.. On a high level:

one slab cache manages a specific object size, i.e. the slab memory consists of
contiguous pages(when increased probably not) of memory(4096 bytes or so) divided
into equal object size. For example when kmalloc() gets called, the appropriate
cache size(slab that serves only specific size) is selected and an object assigned
from it is returned.

But that is theory and i have not deeply analyzed how the SLAB works internally,
so i can be wrong :)

You mentioned 128 objects per one slab in the kmalloc-32 slab-cache. But all of
them follows each other, i mean it is sequential and is like regular array. In
that sense freeing can be beneficial because when an access is done to any object
whole CPU cache-line is fetched(if it was not before), usually it is 64K.

That is what i meant "locality". In order to "break it" i meant to allocate from
different slabs to see how kfree_slub() behaves in that sense, what is more real
scenario and workload, i think.

--
Vlad Rezki
