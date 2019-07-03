Return-Path: <SRS0=tj9r=VA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B4CC0650E
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 16:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366142189E
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 16:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YaxxTNGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGCQnr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:43:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41692 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCQnr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Jul 2019 12:43:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so2254135lfa.8
        for <rcu@vger.kernel.org>; Wed, 03 Jul 2019 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zk5cvPtpY3sXld050A8WUhd1Qa+Cgs4aquGcnNep7sg=;
        b=YaxxTNGVOVa+0oDmisyVwa1aaOb6kNYQhpHbYy0xmKHaw08uPmnINoJXNv6wZKT0Ne
         jyAIKzUcxU/lCSSgm5AFfpxjXFV+VdBXBu/oqEfHOHnZzb36fFnGfoqo/mIxaiSzc5uE
         SMHdoYfrZvL9fsKCuZF0s7/aG+T/DRVj97v0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zk5cvPtpY3sXld050A8WUhd1Qa+Cgs4aquGcnNep7sg=;
        b=pJ/MorA5nRZUUnq2nP0N/9zDbgQI3ZcNyIMsdHA82To7X+ic/V0hiRr+4Q43AWuk1x
         7Jxr67bwzgiwtkG/+Irr6Vi08f7NVu6t7nG9ZHBPcztmPiw+ycOt7kFLb6qvYA9/a0as
         vUnJINDv0Hpr9HACVqMIuw8yM1+2OjQ7/1OrSqdxRtKmgZIafDqADPrjEDL/sXIAaZpn
         fKk/8dcfeAIjfx3NZFLPvl9lTioEPLfrqIO7/Psw6/6BOTPKBVmdjRj/WxiKL+s0mTHw
         oWgcrdSsFMYMGNhw0bOVBXDQ0ApwhFPzjhpNsDGuyqsHtGSu94lgKkoGDUc/60uTrFCH
         m3RA==
X-Gm-Message-State: APjAAAUWjWkD5ojCg9BJNkj6uZcYo9br5Wd1Ysc1vXJyEaurlbizxjBf
        2ETYLtqyUYx/sMYmXbJKOBJXxff23lQDUWkDIXjMCKJeW5U=
X-Google-Smtp-Source: APXvYqxk5SVnAHOWIsZeLFEZGPpT473p5rVj+fnFp3wWkJ1fSmkV52b8ogGHQ/EaEwgY4TRmyJy94rxxh93wLygL9xk=
X-Received: by 2002:a19:6602:: with SMTP id a2mr17960529lfc.25.1562172225759;
 Wed, 03 Jul 2019 09:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YTzPJptrLqx1zzouVSYpssE0JExDYLr+HRnPQco+9Tk2g@mail.gmail.com>
 <20190703113036.04f6169d@gandalf.local.home> <20190703164134.GA125833@google.com>
In-Reply-To: <20190703164134.GA125833@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 3 Jul 2019 12:43:34 -0400
Message-ID: <CAEXW_YQg3D21qnMz4ba8d2Y3BwkP4Bhg+BNDOG+DZ9hCo1R3Fw@mail.gmail.com>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 3, 2019 at 12:41 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Jul 03, 2019 at 11:30:36AM -0400, Steven Rostedt wrote:
> > On Wed, 3 Jul 2019 11:25:20 -0400
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> >
> > > I am sorry if this is not a realistic real-life problem, but more a
> > > "doctor it hurts if I do this" problem as Steven once said ;-)
> > >
> > > I'll keep poking ;-)
> >
> > Hi Joel,
> >
> > Can you also share the tests you are performing as well as any
> > module/code changes you made so that we can duplicate the results?
>
> Sure thing. Below is the diff that I applied to Paul's /dev branch. But I
> believe Linus's tree should have same results.
>
> After applying the diff below, I run it like this:
> tools/testing/selftests/rcutorture/bin/kvm.sh --bootargs rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000 rcuperf.holdout=5 rcuperf.pd_resched=0 --duration 1 --torture rcuperf
>

Sorry the quotes are missing, the command is:
tools/testing/selftests/rcutorture/bin/kvm.sh --bootargs
"rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000 rcuperf.holdout=5
rcuperf.pd_resched=0" --duration 1 --torture rcuperf
