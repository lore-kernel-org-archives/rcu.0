Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D67FC32771
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 04:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C15A24680
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 04:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579322099;
	bh=1f8uxNZhSSDL1r1f/Wi9AKPe0gOnTUHVrR1Z9nAXJd8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ozKb2TrcJ4TB4S8mcWakHmVXd2jnyGpGnjRjUChf4o6w8Tnkcz3yqFSFPjsD3QIXa
	 irAIPQxaLs2YxF2nFXFfmhBRKDEVZhctt2LklHcfbXZ4k/fthzIx337BqCQBIH3Ycm
	 fYre1ea+0LsnwYtJJqV2X0/42ff5rEDn61xa+UIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgAREe7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Jan 2020 23:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:32948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgAREe6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Jan 2020 23:34:58 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8138F2467F;
        Sat, 18 Jan 2020 04:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579322098;
        bh=1f8uxNZhSSDL1r1f/Wi9AKPe0gOnTUHVrR1Z9nAXJd8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rYNeNI3k4+V5dcprxU5e44OwKHQo7bnZ9t+rIuNjfnqgFTevVIqDXnHwFTtsVyjfr
         dcR13EJajQ/JCL8DiBReDsXK2wvPE4us4gW58o4zFE8qOyFgPLDUn+OFHxp1vSpcHI
         82sTyYPZbYTEbeOlAHFFnZzVjb7/0d3qf5tHPUps=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 487F13522A3F; Fri, 17 Jan 2020 20:34:58 -0800 (PST)
Date:   Fri, 17 Jan 2020 20:34:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200118043458.GT2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
 <20200118023434.GB244899@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118023434.GB244899@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 17, 2020 at 09:34:34PM -0500, Joel Fernandes wrote:
> On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
> [...] 
> > But rcutorture already has tests for RCU priority boosting.  Or are those
> > failing in some way?
> 
> Yes there are tests, but I thought of just a simple experiment to study this.
> Purely since it is existing RCU kernel code that I'd like to understand. And
> me/Daniel are also looking into possibly using run-time / trace-based
> verification some of these behaviors.

The functionality of rcu_state.cbovld should make that more entertaining.

But I would guess that the initial model would ignore memory footprint
and just model RCU priority boosting as kicking in a fixed time after
the beginning of the grace period.

Or do you guys have something else in mind?

							Thanx, Paul

PS.  Steve, yes, I do well remember our earlier discussions about readers
     inheriting priority from the highest-priority synchronize_rcu().  ;-)
