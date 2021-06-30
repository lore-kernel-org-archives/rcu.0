Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A953CC11F65
	for <rcu@archiver.kernel.org>; Wed, 30 Jun 2021 15:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B9D61477
	for <rcu@archiver.kernel.org>; Wed, 30 Jun 2021 15:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbhF3Pev (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Jun 2021 11:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235466AbhF3Pev (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Jun 2021 11:34:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB2756147D;
        Wed, 30 Jun 2021 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625067141;
        bh=7YoH0aqkI9Swz2XIBJjaxPLyO+vJXStXg1KBfEzr2KY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rkCyQ++0NQFZWgtqIYCmZO/x8gQoAO7iqW9s2/qxp32XwEoBuwpsLW8LgaX76yopI
         hnnhmxP/7FGrRio3UVLuNXwrhT3iKr9b1Y0OIqxxqIY+0lQs+Ksu6992SuMsu9BlWd
         mvaa33/RxE1uyDTMhBMcmMq7LSUy26BrGmvUT5r9MWYWY4lyTklchGrldeSMpxDYE5
         WjxzwT2rgqZm00EraNOd0rzq1/dT/G0F9siqYHd1iN/Vp830uSyTgwa5+rrvwlU1Ic
         t646eMwXd8l6p8s6xIJjlgTkv6D1H4suvfSJGtwHeUg1IJO16r1GmxJErCnvRbR5gy
         fPJSD0tbk5ofg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF2435C0267; Wed, 30 Jun 2021 08:32:21 -0700 (PDT)
Date:   Wed, 30 Jun 2021 08:32:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     eb@emlix.com, frederic@kernel.org, jbi.octave@gmail.com,
        maninder1.s@samsung.com, qiang.zhang@windriver.com,
        urezki@gmail.com, yury.norov@gmail.com, zhouzhouyi@gmail.com,
        mark.rutland@arm.com, elver@google.com, bjorn.topel@intel.com,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, kasan-dev@googlegroups.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU, LKMM, and KCSAN commits for v5.14
Message-ID: <20210630153221.GW4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210609232926.GA1715440@paulmck-ThinkPad-P17-Gen-1>
 <YNx0CaT2ZTyuNYCK@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNx0CaT2ZTyuNYCK@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 30, 2021 at 03:39:21PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > Hello, Ingo!
> > 
> > This pull request contains changes for RCU, KCSAN, and LKMM.  You can
> > pull the entire group using branch for-mingo.  Or, if you prefer, you
> > can pull them separately, using for-mingo-rcu to pull the RCU changes,
> > for-mingo-kcsan to pull the KCSAN changes, and for-mingo-lkmm to pull
> > the LKMM changes.
> > 
> > The changes are as follows:
> > 
> > 1.	RCU changes (for-mingo-rcu):
> > 
> > 	a.	Bitmap support for "all" as alias for all bits, and with
> > 		modifiers allowed, courtesy of Yury Norov.  This change
> > 		means that "rcu_nocbs=all:1/2" would offload all the
> > 		even-numbered CPUs regardless of the number of CPUs on
> > 		the system.
> > 		https://lore.kernel.org/lkml/20210511224115.GA2892092@paulmck-ThinkPad-P17-Gen-1
> > 
> > 	b.	Documentation updates.
> > 		https://lore.kernel.org/lkml/20210511224402.GA2892361@paulmck-ThinkPad-P17-Gen-1
> > 
> > 	c.	Miscellaneous fixes.
> > 		https://lore.kernel.org/lkml/20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1
> > 
> > 	d.	kvfree_rcu updates, courtesy of Uladzislau Rezki and Zhang Qiang.
> > 		https://lore.kernel.org/lkml/20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1
> > 
> > 	e.	mm_dump_obj() updates, courtesy of Maninder Singh, acked
> > 		by Vlastimil Babka.
> > 		https://lore.kernel.org/lkml/20210511225744.GA2893615@paulmck-ThinkPad-P17-Gen-1
> > 
> > 	f.	RCU callback offloading updates, courtesy of Frederic
> > 		Weisbecker and Ingo Molnar.  ;-)
> > 		https://lore.kernel.org/lkml/20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1
> > 
> > 	g.	SRCU updates, courtesy of Frederic Weisbecker.
> > 		https://lore.kernel.org/lkml/20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1
> > 
> > 	h.	Tasks-RCU updates.
> > 		https://lore.kernel.org/lkml/20210511230924.GA2894768@paulmck-ThinkPad-P17-Gen-1
> > 
> > 	i.	Torture-test updates.
> > 		https://lore.kernel.org/lkml/20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1
> 
> Pulled into tip:core/rcu.
> 
> > 2.	Kernel concurrency sanitizer (KCSAN) updates from Marco Elver
> > 	and Mark Rutland (for-mingo-kcsan).
> > 	https://lore.kernel.org/lkml/20210511232324.GA2896130@paulmck-ThinkPad-P17-Gen-1
> 
> Pulled into tip:locking/urgent.
> 
> > 3.	Linux-kernel memory model (LKMM) updates courtesy of Bj�rn T�pel
> > 	(for-mingo-lkmm).
> > 	https://lore.kernel.org/lkml/20210305102823.415900-1-bjorn.topel@gmail.com
> 
> Pulled into tip:locking/urgent.
> 
> Thanks Paul, and sorry about the late response! Will get these to Linus 
> ASAP if you don't beat me at it.

I wouldn't be sending it off until Friday morning, Pacific Time, so I am
as usual happy for you to send it.  ;-)

							Thanx, Paul
