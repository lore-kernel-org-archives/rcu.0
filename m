Return-Path: <SRS0=lUfD=3G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177F7C33C9E
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 21:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA292083E
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579297042;
	bh=TiUl3vxXPrNJYv+C72Doz3QU6XZr+ECnyQ786ta6B3I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xlTKWVE8PhycKjddVwg30kKOgCo5mvoBnQ1fVZWIUsj0zQj5E9+Lx7/o/tOHvraCI
	 AgqEZQXo6rZ1bKnrUeM4FmUHzm7FxqOBh8Qx/h6mtnPPHGNE7rtdRLQ5+lnBUieleF
	 4gz7DnNg+z6mASvjmYY0yLD3junGztSMupWre+tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgAQVhW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:37:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQVhW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Jan 2020 16:37:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE15E2082F;
        Fri, 17 Jan 2020 21:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579297041;
        bh=TiUl3vxXPrNJYv+C72Doz3QU6XZr+ECnyQ786ta6B3I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=w5Lx6yN8dKagG9+c5LzhGGokKJw3jF60UexVamEmOSX0jurdofNjO/fIg3toe9RF+
         TQneVsmnUQ7RQWkSnqt0TB9pKaUhVGCMlJ3cb+avgCZoDC1nlXShtZ6XTuA/+3IwHO
         cW38C2rFeBmuyzzS8KTeSlZ/dcayIi7nCoZkGMgk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8BE0635228BF; Fri, 17 Jan 2020 13:37:21 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:37:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200117213721.GN2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200113190315.GA12543@paulmck-ThinkPad-P72>
 <20200114164937.GA50403@google.com>
 <20200115131446.GA18417@pc636>
 <20200115225350.GA246464@google.com>
 <20200117175217.GA23622@pc636>
 <20200117185732.GH246464@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117185732.GH246464@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 17, 2020 at 01:57:32PM -0500, Joel Fernandes wrote:
> On Fri, Jan 17, 2020 at 06:52:17PM +0100, Uladzislau Rezki wrote:
> > > > > > But rcuperf uses a single block size, which turns into kfree_bulk() using
> > > > > > a single slab, which results in good locality of reference.  So I have to
> > > > > 
> > > > > You meant a "single cache" category when you say "single slab"? Just to
> > > > > mention, the number of slabs (in a single cache) when a large number of
> > > > > objects are allocated is more than 1 (not single). With current rcuperf, I
> > > > > see 100s of slabs (each slab being one page) in the kmalloc-32 cache. Each
> > > > > slab contains around 128 objects of type kfree_rcu (24 byte object aligned to
> > > > > 32-byte slab object).
> > > > > 
> > > > I think that is about using different slab caches to break locality. It
> > > > makes sense, IMHO, because usually the system make use of different slabs,
> > > > because of different object sizes. From the other hand i guess there are
> > > > test cases when only one slab gets used.
> > > 
> > > I was wondering about "locality". A cache can be split into many slabs. Only
> > > the data on a page is local (contiguous). If there are a large number of
> > > objects, then it goes to a new slab (on the same cache). At least on the
> > > kmalloc slabs, there is only 1 slab per page. So for example, if on
> > > kmalloc-32 slab, there are more than 128 objects, then it goes to a different
> > > slab / page. So how is there still locality?
> > > 
> > Hmm.. On a high level:
> > 
> > one slab cache manages a specific object size, i.e. the slab memory consists of
> > contiguous pages(when increased probably not) of memory(4096 bytes or so) divided
> > into equal object size. For example when kmalloc() gets called, the appropriate
> > cache size(slab that serves only specific size) is selected and an object assigned
> > from it is returned.
> > 
> > But that is theory and i have not deeply analyzed how the SLAB works internally,
> > so i can be wrong :)
> > 
> > You mentioned 128 objects per one slab in the kmalloc-32 slab-cache. But all of
> > them follows each other, i mean it is sequential and is like regular array. In
> 
> Yes, for these 128 objects it is sequential. But the next 128 could be on
> some other page is what I was saying  And we are allocating 10s of 1000s of
> objects in this test.  (I believe pages are sequential only per slab and not
> for a different slab within same cache).
> 
> > that sense freeing can be beneficial because when an access is done to any object
> > whole CPU cache-line is fetched(if it was not before), usually it is 64K.
> 
> You mean size of the whole L1 cache right? cachelines are in the order of bytes.
> 
> > That is what i meant "locality". In order to "break it" i meant to allocate from
> > different slabs to see how kfree_slub() behaves in that sense, what is more real
> > scenario and workload, i think.
> 
> Ok, agreed.
> (BTW I do agree your patch is beneficial, just wanted to get the slab
> discussion right).

Thank you both!

Then I should be looking for an updated version of the patch with an upgraded
commit log?  Or is there more investigation/testing/review in process?

							Thanx, Paul
