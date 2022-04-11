Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FF8C433F5
	for <rcu@archiver.kernel.org>; Mon, 11 Apr 2022 14:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346868AbiDKOLC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Apr 2022 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346861AbiDKOLB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Apr 2022 10:11:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E631C329B8;
        Mon, 11 Apr 2022 07:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8585761259;
        Mon, 11 Apr 2022 14:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2E0C385A5;
        Mon, 11 Apr 2022 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649686127;
        bh=SJ4YeANA3X9NeGRCACiLeL5RF0SBq7ZEod7p7S6oEgw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NHDcacSw2ejC7GR7NcxKVYjrW5gmzrk+7KUXVjKEyBSnagI7zSwLn/gE6I7QRbRK8
         aEY+RqKQwnPkZ3Tcq1tfES01nz4FuM2w8IMwlVNHU/0mpqtBKmZknnAhVSFo5B24D4
         39WqKM8ZcCWMjrzEwRAp1nN/3maAUNZVE1MmEfkb+vr7H9P4hCoa5pdJCUtHgKdCOI
         P0Cr7Px72DAz/51JGRwI6miR4FuY4k89Em2AwDfPmBuZejLgjWNyhY7PsRyv3bMrkj
         nSzq41sapWapHvrDg+lRxWgPDDcdx9hHkhpHaHdW/c7ZwHJNEPt42PDUErmcjP+L9p
         x9vrnWcSfecew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7E0795C0144; Mon, 11 Apr 2022 07:08:46 -0700 (PDT)
Date:   Mon, 11 Apr 2022 07:08:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        frederic@kernel.org
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <20220411140846.GA84069@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220407210734.2548973-1-joel@joelfernandes.org>
 <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <YlCtJzlJDj1DBHQB@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlCtJzlJDj1DBHQB@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 08, 2022 at 11:46:15PM +0200, Uladzislau Rezki wrote:
> > 
> > Here is what I believe you are proposing:
> > 
> > 
> > 				---	rcu_nocbs	rcu_nocbs=???
> > 
> > CONFIG_RCU_NOCB_CPU_ALL=n	[1]	[2]		[3]
> > 
> > CONFIG_RCU_NOCB_CPU_ALL=y	[4]	[4]		[3]
> > 
> > 
> > [1]	No CPUs are offloaded at boot.	CPUs cannot be offloaded at
> > 	runtime.
> > 
> > [2]	No CPUs are offloaded at boot, but any CPU can be offloaded
> > 	(and later de-offloaded) at runtime.
> > 
> > [3]	The set of CPUs that are offloaded at boot are specified by the
> > 	mask, represented above with "???".  The CPUs that are offloaded
> > 	at boot can be de-offloaded and offloaded at runtime.  The CPUs
> > 	not offloaded at boot cannot be offloaded at runtime.
> > 
> > [4]	All CPUs are offloaded at boot, and any CPU can be de-offloaded
> > 	and offloaded at runtime.  This is the same behavior that
> > 	you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> > 	rcu_nocbs=0-N.
> > 
> > 
> > I am adding Frederic on CC, who will not be shy about correcting any
> > confusion I be suffering from have with respect to the current code.
> > 
> > Either way, if this is not what you had in mind, what are you suggesting
> > instead?
> > 
> > I believe that Steve Rostedt's review would carry weight for ChromeOS,
> > however, I am suffering a senior moment on the right person for Android.
> > 
> We(in Sony) mark all CPUs as offloaded ones because of power reasons. The
> energy aware scheduler has a better knowledge where to place an rcuop/x
> task to invoke callbacks. The decision is taken based on many reason and
> the most important is to drain less power as a result of task placement.
> For example, power table, if OPP becomes higher or not, CPU is idle, etc.
> 
> What Joel does in this patch sounds natural to me at least from the first
> glance. I mean converting the RCU_NOCB_CPU=y to make all CPUs to do offloading.

Just to be very clear, given appropriate acks/reviews, adding something
like CONFIG_RCU_NOCB_CPU_ALL to get default rcu_nocbs=0-N is fine.
However, Joel's original patch would not be good for the enterprise
distros, which rely on the current default.

							Thanx, Paul
