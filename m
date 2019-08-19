Return-Path: <SRS0=jzWG=WP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1E5C3A5A0
	for <rcu@archiver.kernel.org>; Mon, 19 Aug 2019 12:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF4C20851
	for <rcu@archiver.kernel.org>; Mon, 19 Aug 2019 12:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566218076;
	bh=qUZRUg6XXT0f5v+SOKFhFDtU4L4gazRavjbpOJIOR0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HX4sunWUtQ7TIbIge7sRfP8f7Y5G3hby6asQXhffc2flWsUc5+t7dD51vl/bM/RGR
	 dDhLlj8vqYf15D2+N3HD9o34t7FwGtdsF+JMgoGkDobwAvvWbA6JFFtxCjO8tgEklM
	 oJZ/vR8PDFZqdNc4CAgfgPiQQRbhDG7XvC6kBSq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfHSMef (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:32916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfHSMef (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Aug 2019 08:34:35 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E08320843;
        Mon, 19 Aug 2019 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566218075;
        bh=qUZRUg6XXT0f5v+SOKFhFDtU4L4gazRavjbpOJIOR0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBZ8qqe1kIXDaKDYQ4qvUxEOWRp6+jTytuFjbjBrYSFxAUwueXUJP+ChZBCScu7Dw
         /dnaL+fa88CawqqGukP3zKs22zQCrtVVPrwDyMoUtkqsGCMKOs+XxK4AcK1bsmhEmp
         AYBGDVQoLO6eTPV6bgqZH9rJl0TzxkGdjkPC7E7Y=
Date:   Mon, 19 Aug 2019 14:34:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190819123432.GB27088@lenoir>
References: <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
 <20190815171714.GA1023@linux.ibm.com>
 <20190815200432.GB23194@google.com>
 <20190815203107.GL28441@linux.ibm.com>
 <20190815212216.GA224191@google.com>
 <20190815214542.GM28441@linux.ibm.com>
 <20190816000201.GC225926@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816000201.GC225926@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 15, 2019 at 08:02:01PM -0400, Joel Fernandes wrote:
> On Thu, Aug 15, 2019 at 02:45:42PM -0700, Paul E. McKenney wrote:
> > As I understand it, tick_dep_mask forces the tick on globally,
> > ts->tick_dep_mask forces it on for a specific CPU (which RCU uses when it
> > needs a quiescent state from that CPU), current->tick_dep_mask forces
> > it on for a specific task (which RCU uses for callback invocation
> > and certain rcutorture kthreads), and I don't pretend to understand
> > current->signal->tick_dep_mask (the comment says something about POSIX
> > CPU timers).
> 
> Right. I am pretty new to all of these so I could have something incorrect in
> a hurry. But thanks for the explanation of your understanding of these.
> 
> Yes this commit talks about timers as well for the signal->tick_dep_mask:
> d027d45d8a17 ("nohz: New tick dependency mask")

FWIW, the signal->tick_dep_mask is a thread group wide tick dependency. I'm
not proud of that requirement but we need to keep it for posix CPU timers
that can elapse a timer on all threads of a same process and the tick is
the cheapest way to account for that.

