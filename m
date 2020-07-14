Return-Path: <SRS0=gxlL=AZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08523C433E0
	for <rcu@archiver.kernel.org>; Tue, 14 Jul 2020 20:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35582065D
	for <rcu@archiver.kernel.org>; Tue, 14 Jul 2020 20:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594760007;
	bh=9rrhLCU6+pm8mW+cFjHhYnxq6+Zbitoa5KpfBufwyWk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=rX9djGzbZlPyL0vdcx8WMgGI9c8bPBvk8X1QdT+EzRuoK1WeSdnhu3QNd9tF35sY8
	 tHoxiq/dNps0lCwPvaRWFBAQfdg0tl9Vt5kA/THxpF+ttJN/GH3TCHibaQV+qDNq1j
	 IyaFK7rxbMP9Ein3/16QyR8KfhGTfBfb6JY8nqXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGNUx1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGNUx1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Jul 2020 16:53:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1EEF20658;
        Tue, 14 Jul 2020 20:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594760006;
        bh=9rrhLCU6+pm8mW+cFjHhYnxq6+Zbitoa5KpfBufwyWk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DS6zwyel2JYxJFVR5779AnfaHyLEliGu46hDklCExGnbTZ5AhwTMb6+djX8XDniJW
         7UhuqNtpyOvZK/9nOCDK0TGSITeGn9OGYkgzIDm116fRNvuBkNXZ1gg7Z5b3wNQw96
         lm0HokpZ/mPBGs3ThraiKc9sJ8IZVR4Lrq0NxYWQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8FEDF3523102; Tue, 14 Jul 2020 13:53:26 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:53:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, arnd@arndb.de, elver@google.com, ethp@qq.com,
        frederic@kernel.org, jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, peter.enderborg@sony.com,
        rdunlap@infradead.org, richard.weiyang@linux.alibaba.com,
        urezki@gmail.com, zou_wei@huawei.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200714205326.GY9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200714172701.GA31369@paulmck-ThinkPad-P72>
 <20200714181426.hhguqzrcqdubyvae@linutronix.de>
 <20200714182732.GU9247@paulmck-ThinkPad-P72>
 <20200714190253.ylqjif7frqs2rq7x@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714190253.ylqjif7frqs2rq7x@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 14, 2020 at 09:02:53PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-07-14 11:27:32 [-0700], Paul E. McKenney wrote:
> > I believe that Ulad and Joel are working on an update.
> 
> I expressed multiple times that I am unhappy with the raw_spinlock_t
> which both want to keep. It is important to be future proof but at the
> same time I am not sure if they know how many in-hardirq kmalloc() or
> kfree() invocation we have as of today in PREEMPT_RT.
> I also had a patch in my series to keep the lock/unlock path symmetrical
> and it I think that I the only one that is missing it.

Are you good with giving Ulad a few days to produce his patch?

We do have at least a week or two before the merge window opens,
after all.

						Thanx, Paul
