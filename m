Return-Path: <SRS0=4RPF=5D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C528C1975A
	for <rcu@archiver.kernel.org>; Wed, 18 Mar 2020 01:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42ED20738
	for <rcu@archiver.kernel.org>; Wed, 18 Mar 2020 01:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584493785;
	bh=TF5F2L72wGR0nXt9ZlZ2Nd+WZZGsYXh1s4urbbJFQqc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=W4cOhPaXhA+612vbBdzOQx6DhW6maTh9dkzrva/46+te6toaOGWcw09kU8PpOx8xf
	 8P5Gqp6jL24Z0vYyAd8QAH35l0O3Y318U5ququg/5MSqypjYUwvFvBoIkMFDRY1Lof
	 QE1ERx1kaR0WS97CxxKFVskGS3Dd4Fvcu9mFMUzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgCRBJp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgCRBJp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Mar 2020 21:09:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F79206EC;
        Wed, 18 Mar 2020 01:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584493784;
        bh=TF5F2L72wGR0nXt9ZlZ2Nd+WZZGsYXh1s4urbbJFQqc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l0zFdQ3ePms6YEnraWfGhRyXGR1QPebf9mfK0dmI4bqli+GxePOjYaBfsA09LwE88
         15XGe6D/uIx1UwoblFdF4JuELcaH0DTtpuTG/YnvQBq2jBjJ7ekaGzot9bvRRODyN7
         4fbGkaZOrrqesJXl5v2h6U006EzeCkXBVCph7AKs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AA241352272E; Tue, 17 Mar 2020 18:09:44 -0700 (PDT)
Date:   Tue, 17 Mar 2020 18:09:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     joel@joelfernandes.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v2 rcu-dev 1/3] rcuperf: Add ability to increase object
 allocation size
Message-ID: <20200318010944.GQ3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200316163228.62068-1-joel@joelfernandes.org>
 <20200317210822.GM3199@paulmck-ThinkPad-P72>
 <20200317214502.GA29184@paulmck-ThinkPad-P72>
 <CAEXW_YQxKfcGf3UgEn_8hdWHdMx09RvD90z6zo=kk-iRinYjng@mail.gmail.com>
 <20200317224820.GP3199@paulmck-ThinkPad-P72>
 <A6C6D60E-9E01-40FC-8396-9F2FF2803E2E@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A6C6D60E-9E01-40FC-8396-9F2FF2803E2E@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 17, 2020 at 07:37:47PM -0400, joel@joelfernandes.org wrote:
> 
> 
> On March 17, 2020 6:48:20 PM EDT, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >On Tue, Mar 17, 2020 at 06:30:51PM -0400, Joel Fernandes wrote:
> >> On Tue, Mar 17, 2020 at 5:45 PM Paul E. McKenney <paulmck@kernel.org>
> >wrote:
> >> >
> >> > On Tue, Mar 17, 2020 at 02:08:22PM -0700, Paul E. McKenney wrote:
> >> > > On Mon, Mar 16, 2020 at 12:32:26PM -0400, Joel Fernandes (Google)
> >wrote:
> >> > > > This allows us to increase memory pressure dynamically using a
> >new
> >> > > > rcuperf boot command line parameter called 'rcumult'.
> >> > > >
> >> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> > >
> >> > > Applied for testing and review, thank you!
> >> >
> >> > But testing did not go far:
> >> >
> >> > kernel/rcu/tree.c: In function ‘kfree_rcu_shrink_count’:
> >> > kernel/rcu/tree.c:3120:16: warning: unused variable ‘flags’
> >[-Wunused-variable]
> >> >   unsigned long flags, count = 0;
> >> 
> >> I fixed the warning already but did not resend since it was just the
> >> one unused variable warning. The patches are otherwise good to apply.
> >> Sorry, and I can resend it soon if you are not reapplying right now.
> >
> >So remove "flags, " and all is well?
> 
> Yes, that's right. I dropped the lock but forgot to remove it.

Done, thank you!

							Thanx, Paul

> >If so, I can just as easily fix that as take a new series.  But next
> >time, please give a fella a warning.  ;-)
> 
> Will do, my bad. Thank you ;-)
> 
> - Joel
> 
> >
> >							Thanx, Paul
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
