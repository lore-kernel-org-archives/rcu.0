Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E732C4741F
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 14:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DA820786
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604586492;
	bh=1y9/jO23DapTFabMMdsgl4CPgQCNWq53awT+Acfr9gI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MW4HHCUpVeG1nz+SdDv/IzlKRrrKuvbQtc+pd8etm/rz66mR7LOpkh0p8ZOg6WoNh
	 VBc9JxE07i2INWCWCAtx/Zppkepe471BlrPZBlIDa5gLbxrwkta9Ae4dqDo1772DX9
	 0gD3NBkwaAHJWZnqF2lPbxZtgLpNM/18GcXQr1xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgKEO2L (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 09:28:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730754AbgKEO2L (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 09:28:11 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFB442078E;
        Thu,  5 Nov 2020 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604586490;
        bh=1y9/jO23DapTFabMMdsgl4CPgQCNWq53awT+Acfr9gI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MVIwt0UvFm2XY/wSuSq7AnhL71Wjx1Dv0fBPy//+sCBUozriDaU7cgHmWHPPZkGau
         J9oqWjanQMKwPNwnarExQ77/BZl/gFT0717GFKQ09jEgBQYdVTpCDxB3qlvPPU9awE
         GJi0XxdhDaFBx85iVk2H+KSlYqZ6Mm/1Fq7tdjO8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 51860352265A; Thu,  5 Nov 2020 06:28:10 -0800 (PST)
Date:   Thu, 5 Nov 2020 06:28:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 5/7] rcu/segcblist: Remove useless rcupdate.h include
Message-ID: <20201105142810.GA16800@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-6-joel@joelfernandes.org>
 <20201105034823.GK3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105034823.GK3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:23PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 03, 2020 at 09:26:01AM -0500, Joel Fernandes (Google) wrote:
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> This one looks fine, but depends on the earlier "rcu/segcblist: Add
> counters to segcblist datastructure" patch, which also changes the list
> of #include directives for this file.  It manages to avoid conflicting
> with "rcu/trace: Add tracing for how segcb list changes", despite this
> one also changing the #include directives.
> 
> I am testing it just out of curiosity, but it might make more sense
> to fold this one into "rcu/segcblist: Add counters to segcblist
> datastructure".

And it does pass light rcutorture.  ;-)

							Thanx, Paul

> > ---
> >  kernel/rcu/rcu_segcblist.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 2a03949d0b82..e9e72d72f7a6 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -10,7 +10,6 @@
> >  #include <linux/cpu.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> > -#include <linux/rcupdate.h>
> >  #include <linux/types.h>
> >  
> >  #include "rcu_segcblist.h"
> > -- 
> > 2.29.1.341.ge80a0c044ae-goog
> > 
