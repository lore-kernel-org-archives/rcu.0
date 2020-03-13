Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F026C10DCE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 13:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4CC20724
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584107642;
	bh=lg26QZCnHEwmLTPKuvDTykkgAgWVkc7+gtSR75FBMhk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hNdak5/s1Nsh9L6OWshPdtjlXVrNOvx4CJldS6oLos7e+yBL3O0N6rfD3U4tHtuAZ
	 A0D9TEaXY/tMd7WQLHjeXLZY98uaYnkkmlfgdfZAp06VOWWS2/W+asT81PbKerKQ1G
	 fXskWa4GxEOIntyWHT/AVhQ4pC3VxFVm0kAs9stg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCMNyB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgCMNyB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 09:54:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2B1206B7;
        Fri, 13 Mar 2020 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584107640;
        bh=lg26QZCnHEwmLTPKuvDTykkgAgWVkc7+gtSR75FBMhk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hSq412lEtjL9FZ+bJBpl+E9roHeVAc2Es6SOC4HmV6oN+odMPV57BOFBK67I3xj5m
         FdcHFt5fU9wfve3mmZ1mnsi2o+7kvH8JAY9hT1ckHHvsBtKLqx6DaB1D1jLfXvJIIA
         J9MpHM7rze2ds8ClibTTIz3V3iwvsueOKi8wQjaM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B34633522719; Fri, 13 Mar 2020 06:54:00 -0700 (PDT)
Date:   Fri, 13 Mar 2020 06:54:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200313135400.GQ3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
 <20200312191009.GA27429@pc636>
 <20200313050659.GA22938@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313050659.GA22938@SDF.ORG>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 13, 2020 at 05:06:59AM +0000, George Spelvin wrote:
> I'd just like to mention that the is_vmalloc_addr() test depends only on 
> the virtual address, so can be done when the memory is queued, before the 
> grace period.  That is, you could have kfree_rcu(), vfree_rcu(), and a 
> kvfree_rcu() function which decides between them.
> 
> One advantage of that would be that you could put the vfree() sanity
> checks into vfree_rcu(), so errors would have a useful backtrace,
> and just do the __vunmap when the grace period expires.
> 
> Or you could build a mixed queue and do the is_vmalloc_addr() test at
> the end of the grace period.  That was my original idea, because it
> avoids the need for a separate queue.  (In the _rcu_bulk_data structure,
> you can do a quicksort-style partitioning on is_vmalloc_addr(), so
> the kfree_bulk() pointers are all contiguous.)
> 
> Just an implementation option.

I would guess that sorting them before the grace period might improve
cache locality and thus performance.  So it does seem like an excellent
thing to try, at the very least as an experiment.

							Thanx, Paul
