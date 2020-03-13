Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC32C10DCE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 18:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9E4206EB
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584123558;
	bh=IqWzHcbYam/gWTfD4JZwHVFsUirKuHtW1rxyMgC/2iE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YqCz24oIxxjg88CBRSJelz6t0ZCG+PKTvaFpkUDxlN9atYTjOt6wH4gVwKV/RGzMN
	 ruR7uH5uQLPH/i6uN8k1Ml+boWnwKqEuhYDL69PShRJLzqKUixeXWDg7DuSXzhl4Qt
	 JPBAd/44D1LXWe0xNXTbwCzVkv/VBUPkzgEZgdMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMSTS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgCMSTR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 14:19:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C45D206CD;
        Fri, 13 Mar 2020 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584123557;
        bh=IqWzHcbYam/gWTfD4JZwHVFsUirKuHtW1rxyMgC/2iE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BrN1LknH0CjG4iQzrFCW09i1qadOl8/4NOJ4nV8nFxVmu8Hbm3Rk7cUwVlsb11Q4B
         Kp+GrudJYosQTAuIHUFP4Pg0Waby0PU+sE1KbZW8udZxF1+JRHssazdrFZX7Me+6WS
         6iumWq3AzTbhF30fVc6jm4z8cqBgmFi51pA2HXMY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 42AFB352272E; Fri, 13 Mar 2020 11:19:17 -0700 (PDT)
Date:   Fri, 13 Mar 2020 11:19:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200313181917.GY3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
 <20200312191009.GA27429@pc636>
 <20200313050659.GA22938@SDF.ORG>
 <20200313135400.GQ3199@paulmck-ThinkPad-P72>
 <20200313165219.GA1384@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313165219.GA1384@SDF.ORG>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 13, 2020 at 04:52:19PM +0000, George Spelvin wrote:
> On Fri, Mar 13, 2020 at 06:54:00AM -0700, Paul E. McKenney wrote:
> > I would guess that sorting them before the grace period might improve
> > cache locality and thus performance.  So it does seem like an excellent
> > thing to try, at the very least as an experiment.
> 
> That doesn't seem at all obvious.  Processing them in separate batches
> would improve I-cache locality, but you could sort them after the
> grace period just as well as before.  Especially if you have arrays of 
> 500 pointers to work with.
> 
> Indeed, one thing that seems worth trying is sorting by address, which 
> would improve D-cache locality, since you have a significant chance for 
> consecutive frees to be in the same slab or otherwise reference the same 
> overhead data structures.
> 
> Sorting by (address - VMALLOC_START) automatically groups the vallocated 
> poiners together at the front, too.  Since there's no vfree_bulk, you can 
> iterate over them until you run out, then kfree_bulk the rest.
> 
> (This idea came from a memory that bulk file operations can be 
> made faster by sorting by inode number.)
> 
> P.S. if you want to fit one extra pointer in the array, an array index
> identifying the first unused slot is distinguishable from a pointer,
> so if the last slot is a pointer, the page is full.  If it's an index,
> the page is not full.

Another approach would be to terminate with a NULL pointer, or with the
end of the array, as the case may be.

							Thanx, Paul
