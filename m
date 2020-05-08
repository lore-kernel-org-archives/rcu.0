Return-Path: <SRS0=sn7Z=6W=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460AAC4724C
	for <rcu@archiver.kernel.org>; Fri,  8 May 2020 14:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145992173E
	for <rcu@archiver.kernel.org>; Fri,  8 May 2020 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588949242;
	bh=UToAk1Et6hJqu9wWwasMqPrw4EHOYt9QHzG/u3OpO+0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=kpC523XbyXxpJ2qEboLVro/yNZFMN7ZhPoUPkxtNrwCy5Pn9hp7s/w5aV3jRXxBDN
	 LHmQNbhCjhgo//17WSVBYfAFk1C/vz0OboXSL9vQuJl9uafEUElKFg8eX9WrMlSpCP
	 LPtUsuXurWmenn/hBwjeCAO2JFbf+FjYVpkNSCtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgEHOrS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 May 2020 10:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgEHOrR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 May 2020 10:47:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF9B221775;
        Fri,  8 May 2020 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588949236;
        bh=UToAk1Et6hJqu9wWwasMqPrw4EHOYt9QHzG/u3OpO+0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yEKqoFw5EU6cwX+Xs6Qg2naXNcwuRRhVLOQWKqc4XKTLu9x6ygQclkC/n/Cd+TVcg
         61z/pTTeFaCZDaC/GQqp/1zEZPqvlmw2LiA8jfGUp1YkeHcZ6vs7rMf0OqJHtywXZJ
         Tkympm5vF9BQklOwaPbWs8/OrNsGSAxSg4toMMtk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 950133522B1D; Fri,  8 May 2020 07:47:16 -0700 (PDT)
Date:   Fri, 8 May 2020 07:47:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH RFC tip/core/rcu] Add shrinker to shift to
 fast/inefficient GP mode
Message-ID: <20200508144716.GG2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200507004240.GA9156@paulmck-ThinkPad-P72>
 <20200507093647.11932-1-hdanton@sina.com>
 <20200508133743.9356-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508133743.9356-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 08, 2020 at 09:37:43PM +0800, Hillf Danton wrote:
> 
> On Thu, 7 May 2020 08:49:10 Paul E. McKenney wrote:
> >  
> > > +static void rcu_mph_info(void *data)
> >
> > This pointer will always be &rcu_state, so why not ignore the pointer
> > and use "rcu_state" below?
> >
> Yes you're right.
> 
> > RCU grace periods are inherently global, so I don't know of any way
> > for RCU to focus on a given NUMA node.  All or nothing.
> 
> Or is it feasible to expose certain RCU thing to VM, say, with which kswapd
> can kick grace period every time the kthreads think it's needed? That way
> the work to gauge memory pressure can be off RCU's shoulders.

A pair of functions RCU provides is easy for me.  ;-)

							Thanx, Paul

> > But on the
> > other hand, speeding up RCU grace periods will also help specific
> > NUMA nodes, so I believe that it is all good.
> > 
> > > +{
> > > +	struct rcu_state *state = data;
> > > +
> > > +	WRITE_ONCE(state->mph_end, jiffies + HZ / 10);
> > > +	smp_store_release(&state->mph, true);
> > > +	rcu_force_quiescent_state();
> > > +}
> > > +
> > > +static struct mph_subscriber rcu_mph_subscriber = {
> > > +	.info = rcu_mph_info,
> > > +	.data = &rcu_state,
> > 
> > Then this ".data" entry can be omitted, correct?
> 
> Yes :)
> 
> Hillf
> 
