Return-Path: <SRS0=B8+c=75=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B586C433DF
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 22:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720C4207D3
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 22:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592346574;
	bh=xOxaPlAhhV/FVlj46uMOV1dOdCqFFKiCQlNraLlV0ZA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=kF8tCq3iYcB58SFE65XKl4zqNau3ai6KRjUmXqw8oaiLl/tFNaYj6cXMk7/foyBlB
	 BHzLHmycm2d/NtCMqzL+DpdJNrc4MoXlCRQh3dMtgOQr2NXsjRaBQyzCBbGZlQ9kqw
	 iiawL86GlzBlV4a8NDwkbD4GCUj6SsYHJ6ZhE+xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFPW3e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgFPW3e (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 18:29:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE4120786;
        Tue, 16 Jun 2020 22:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592346573;
        bh=xOxaPlAhhV/FVlj46uMOV1dOdCqFFKiCQlNraLlV0ZA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0R6cwmMo1NTPuY4mNOokjMWAP3kyw16u+vRGAVkLatN2AEpDkA7rTa0aEunYk6v0d
         uQ6ZovjBqClMoN8v0n8nIyoSurwg85GwF5gR8DuOq9FL4Y2TWLiVMxl7NXQSj/jOG+
         AcVHqE7RUzuHKJg8YWgV3qS7c/g/HwISrfu8ujDo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 33A9E3522657; Tue, 16 Jun 2020 15:29:33 -0700 (PDT)
Date:   Tue, 16 Jun 2020 15:29:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
Subject: Re: Question about list_sort() RCU version.
Message-ID: <20200616222933.GH2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <BYAPR04MB4965874567CDA672B704ABCC869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200616174756.53309ed0@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616174756.53309ed0@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 16, 2020 at 05:47:56PM -0400, Steven Rostedt wrote:
> On Tue, 16 Jun 2020 20:17:56 +0000
> Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:
> 
> > Hi RCU maintainers and experts,
> > 
> > I'm working on a linux kernel upstream project which is in the tree. 
> > With the POC I can already see that significant performance improvement 
> > with RCU in the fast path which are replacing rw semaphore, but not 
> > having list_sort() rcu variant is blocking the developement and getting 
> > code upstream.
> > 
> > I was not able to find the such helper implemented for the RCU flavor of 
> > list.
> > 
> > Can someone provide information about :-
> > 
> > 1. Is there any plan to have list_sort_rcu() ? if so when can we expect
> >     that ? (Also how can I help ?)
> 
> I'm pretty sure there isn't any plan.
> 
> > 
> > 2. In case there is no plan what are design considerations if someone
> >     wants to implement the code and submit it upstream ?
> >     (Also how can I help here ?
> > 
> 
> Good luck! For RCU to work, you basically need two states where both
> are "valid" for a time. You have an initial state, and then you have
> the state you want to get to. In the transition period, readers will
> see one of either those states, until the last reader is finished with
> the initial state, all new readers will only see the second state after
> a quiescent point in time.
> 
> To sort a list, you will need to modify it in such a case that the list
> is valid for all readers. This requires moving a list item. The problem
> is, this will require two modifications, where the list will not be
> valid in between. How would you move an item where the list is valid
> for ever change? Say you want to move the last element up. To do so,
> you need to remove the pointer to that element, make another element
> point to it, and in the mean time you need to update that last
> element's pointer as well. You can't do all that at once, and doing any
> of those without the other two will make the list invalid.
> 
> One answer is to make a copy of the entire list, sort it, and then make
> it the new list. That's the only way I can see this work.

If you want things sorted, why not a search tree?  Or, depending on the
purpose of the sorting, a hash table?

It actually is kind-of sort-of possible to do an in-place sort of a
linked list in the presence of readers, but the simpler ways of doing
this are not at all pretty.  Or efficient while the sort is in progress.

o	Find the largest element in the yet-to-be-sorted portion of
	the list.  Pull that largest element to the front of the list
	as follows:

	o	Set its ->next pointer to reference the first
		element of the list.  (Yes, the list is now
		looped, and readers looking for later elements
		will follow that loop.  Readers must do loop
		detection, and restart their traversal after
		momentarily exiting their read-side critical
		sections.)

	o	Set the header pointer to reference the element
		being moved.  The list is still looped.

	o	Wait for a grace period.  This is why looping
		readers must momentarily exit their read-side
		critical sections.

	o	Make the moved item's predecessor point to the
		moved item's successor.

o	Repeat until the list is sorted.

Another approach is similar to Steven's suggestion, but uses a
separate set of pointers to do the sorting, then switches the
readers to the sorted set.  This allows better sorting algorithms
to be used.

But why not just insert each element into its proper place in the list
to start with?  If the list is too long for this to be efficient, you
most likely should be using some other data structure.

						Thanx, Paul
