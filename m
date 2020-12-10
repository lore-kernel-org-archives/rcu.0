Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC28C433FE
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 01:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37630239FD
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 01:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgLJBWk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:22:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgLJBWj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 20:22:39 -0500
Date:   Wed, 9 Dec 2020 17:21:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607563318;
        bh=kqGVG4pFJj1Qobh09mK0JLlxe0Tq6pSEYuPp6c0c5gs=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XfHkR0oDzhnvWG2In1vs2ZchwANtvuaosPQUjfkNLtndwjrBJoVvIoYPTZ50L/aLZ
         hpvmMDZiK54SFDtvM9tB9HI8LG8lE2+4EqLMWmru6crM2b25ttpxQpwQxVvLsUvK7w
         eVajQtT31P86DPpTlUWh1/cXA6UYyfq/7aQT4PDTt3XaewtqkRheF9YYtoEVN5lycG
         7lgUMxq+1Ya8+yCETAFgZXOZUvrnT6Yh9TQQgnyng0v4ag9PhhVhjqRXJoyK7POFOd
         H3R+pisKzU5brf4c0QUuPJuBcdwOJVjpEbbf2zrupcvZDidVEovCZTNh7X0pMoPMBE
         sSZhbiT6DzoFA==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/19] rcu/nocb: De-offload and re-offload support v4
Message-ID: <20201210012158.GO2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201113121334.166723-1-frederic@kernel.org>
 <20201208024131.GI3025@boqun-archlinux>
 <20201208125104.GB16597@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208125104.GB16597@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 08, 2020 at 01:51:04PM +0100, Frederic Weisbecker wrote:
> Hi Boqun Feng,
> 
> On Tue, Dec 08, 2020 at 10:41:31AM +0800, Boqun Feng wrote:
> > Hi Frederic,
> > 
> > On Fri, Nov 13, 2020 at 01:13:15PM +0100, Frederic Weisbecker wrote:
> > > This keeps growing up. Rest assured, most of it is debug code and sanity
> > > checks.
> > > 
> > > Boqun Feng found that holding rnp lock while updating the offloaded
> > > state of an rdp isn't needed, and he was right despite my initial
> > > reaction. The sites that read the offloaded state while holding the rnp
> > > lock are actually protected because they read it locally in a non
> > > preemptible context.
> > > 
> > > So I removed the rnp lock in "rcu/nocb: De-offloading CB". And just to
> > > make sure I'm not missing something, I added sanity checks that ensure
> > > we always read the offloaded state in a safe way (3 last patches).
> > > 
> > > Still passes TREE01 (but I had to fight!)
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > 	rcu/nocb-toggle-v4
> > > 
> > > HEAD: 579e15efa48fb6fc4ecf14961804051f385807fe
> > > 
> > 
> > This whole series look good to me, plus I've run a test, so far
> > everything seems working ;-) Here is my setup for the test:
> > 
> > I'm using a ARM64 guest (running on Hyper-V) to do the test, and the
> > guest has 8 VCPUs. The code I'm using is v5.10-rc6 + Hyper-V ARM64 guest
> > support [1] + your patchset (I actually did a merge from your
> > rcu/nocb-toggle-v5 branch, because IIUC some modification for rcutorture
> > is still in Paul's tree). I compiled with my normal configuration for
> > ARM64 Hyper-V guest plus TREE01, boot the kernel with:
> > 
> > 	ignore_loglevel rcutree.gp_preinit_delay=3 rcutree.gp_init_delay=3 rcutree.gp_cleanup_delay=3 rcu_nocbs=0-1,3-7	
> > 
> > and run rcutorture via:
> > 
> > 	modprobe rcutorture nocbs_nthreads=8 nocbs_toggle=1000 fwd_progress=0
> > 
> > I ran the rcutorture twice, one last for a week or so and one for a day
> > or two and I didn't observe any problem so far. The latest test summary
> > is:
> > 
> > 	[...] rcu-torture: rtc: 00000000f794686f ver: 2226396 tfle: 0 rta: 2226397 rtaf: 0 rtf: 2226385 rtmbe: 0 rtmbkf: 0/1390141 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 181415346 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 108102 nocb-toggles: 306964:306974 
> > 
> > Is there anything I'm missing for a useful test? Do you have other setup
> > (kernel cmdline or rcutorture parameters) that you want me to try?
> 
> Thanks a lot for reviewing and testing. You seem to have tested with the right
> options, I have nothing better to suggest. Plus I'm glad you tested on
> ARM64. x86 is the only target I have tested so far.

Boqun, would you be willing to give your Tested-by?

							Thanx, Paul
