Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBB8C54FC9
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 03:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5672145D
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 03:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587438931;
	bh=Dv18RkM/i/aNmqHhDlxgNPltdMz92rPWl42vH2eEQjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qOT5h0DWzhz2e2WeyGgGi+Jc9QfHgrs7YclkUCSIspT3KsahXGFMUTtCE+7GvV+ws
	 V004uAibo/H7mWLG+5oqWFkB+J/ltk/qA8k5Qdoetcx7N/pet9e1m2payR+c+nwEyN
	 s6AZMRMo/Kl2FCbrHm6v1aaaz3ga2Mc3b628gpRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDUDPa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDUDPa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Apr 2020 23:15:30 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D0A2078C;
        Tue, 21 Apr 2020 03:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587438928;
        bh=Dv18RkM/i/aNmqHhDlxgNPltdMz92rPWl42vH2eEQjg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aUsrVfvDLG9F2d9reZ0pddGudkYrEt1bkskJ86vx0WNg7NjV8Fdo7DrSvjr0hk/ET
         uFSwiA+q7ZwyGROzOHZTF77Ne9ndJIoQ4up9rwVaSQEWa383jx+e5LMCSK+7Axnxuk
         SrdSeKdUo8v0c4Uqal4IfVxKE/nG/VbaPcGmMQYc=
Date:   Mon, 20 Apr 2020 20:15:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 5/6] rcu: rename kfree_call_rcu()/__kfree_rcu()
Message-Id: <20200420201527.679247f6fa76cba4331f3cd3@linux-foundation.org>
In-Reply-To: <20200316190144.GB10577@pc636>
References: <20200315181840.6966-1-urezki@gmail.com>
        <20200315181840.6966-6-urezki@gmail.com>
        <20200316152541.GD190951@google.com>
        <20200316190144.GB10577@pc636>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 16 Mar 2020 20:01:44 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:

> On Mon, Mar 16, 2020 at 11:25:41AM -0400, Joel Fernandes wrote:
> > On Sun, Mar 15, 2020 at 07:18:39PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Rename kfree_call_rcu() to the kvfree_call_rcu().
> > > The reason is, it is capable of freeing vmalloc()
> > > memory now.
> > > 
> > > Do the same with __kfree_rcu() macro, it becomes
> > > __kvfree_rcu(), the reason is the same as pointed
> > > above.
> > 
> > Vlad, this patch does not apply to my branch that I shared with you. Sorry if
> > I was not clear earlier, could we work on the same branch to avoid conflicts?
> > 
> It was clear to me. Basically i knew that you would be able to apply it
> because of slim changes. I based my work on latest Paul's branch simply
> because that my current setup was based on that, it would take more time
> to switch.
> 
> Next changes i will base on your branch.
> 
> > I based the kfree_rcu shrinker patches on an 'rcu/kfree' branch in my git
> > tree: https://github.com/joelagnel/linux-kernel/tree/rcu/kfree
> > 
> > For now I manually applied 5/6. All others applied cleanly.
> > 
> > Updated the tree as I continue to review your patches.
> >

I'm not sure what's happening here - these patches aren't yet in
linux-next.

A couple of thoughts:

- Please cc linux-mm@kvack.org on this patchset and anything else
  which impacts MM.

- It's a bit strange to create new infrastructure which has but a
  single call site.  Please tell us much more about "there was also
  request/interest so there will be new comers" to set minds at ease. 

  Who/where are these possible new callsites and when can we expect to
  see that code?

