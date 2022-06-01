Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB4CCA468
	for <rcu@archiver.kernel.org>; Wed,  1 Jun 2022 14:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354896AbiFAO2n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Jun 2022 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355363AbiFAO2S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Jun 2022 10:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB4443DE
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 07:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B51961362
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 14:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1048AC385A5;
        Wed,  1 Jun 2022 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654093497;
        bh=R1sZw1OFEmWqcpCSx7lYY+M8tNhN2TE2We5TA5Wf6k4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHSQSDD2KYZmo3BF5Xv1hhAe0FIVP8Rn9JpPXQRtIDO2fVRkTFLAxH3Q+Oq8V552V
         066teZ1lLQsHRnmkT1LeXhh8hGs9wY2rV4tZGvh/2igxb5nqmm3agsn1n7/O0THeWQ
         BVQKJPC5egMFwuegdf+ok2pAd0Oq1X6sjE0QyGAqFm4Ngj79lmrDFAiC+Xc4EudEGl
         stcRT+y1vkDXiYVCACmkoSnG2STSHFeSGzviers/MCqHuCS/Y3SKp2yp5BI1YqiAQ/
         Y8TwwhdXl/ALEJFTG0x8y00qTOQ5X05Hw1bCsWaiJxA4kxrIQEKTRznZK4LDEKxEVL
         qQKRAMJKlv08A==
Date:   Wed, 1 Jun 2022 16:24:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <20220601142454.GB1288128@lothringen>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org>
 <20220512235603.GU1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512235603.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 04:56:03PM -0700, Paul E. McKenney wrote:
> On Thu, May 12, 2022 at 03:04:29AM +0000, Joel Fernandes (Google) wrote:
> > +	preempt_enable();
> > +
> > +	if (debug_rcu_head_queue((void *)head)) {
> > +		// Probable double call_rcu(), just leak.
> > +		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > +				__func__, head);
> > +
> > +		// Mark as success and leave.
> > +		return;
> > +	}
> > +
> > +	// Queue to per-cpu llist
> > +	head->func = func;
> > +	llist_add(&head->llist_node, &rlp->head);
> 
> Suppose that there are a bunch of preemptions between the preempt_enable()
> above and this point, so that the current CPU's list has lots of
> callbacks, but zero ->count.  Can that cause a problem?
> 
> In the past, this sort of thing has been an issue for rcu_barrier()
> and friends.

Speaking of, shouldn't rcu_barrier() flush all the lazy queues? I
might have missed that somewhere in the patchset though.

Thanks.
