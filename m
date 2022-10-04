Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643ECC433FE
	for <rcu@archiver.kernel.org>; Tue,  4 Oct 2022 13:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJDNaJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJDNaI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 Oct 2022 09:30:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFFE14D34;
        Tue,  4 Oct 2022 06:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 227D0B81A64;
        Tue,  4 Oct 2022 13:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48B3C433D6;
        Tue,  4 Oct 2022 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664890204;
        bh=pmD/76THUjmjMv87RaAXR785Z/FUTUEMriT7r4Exd14=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cg8UakfENBD85c56ET5JLM7T690PtRla3/xj64+A8wTGb7FAgV0fs3Z7pgEFdZPnc
         M3aK4ideDxGBpM/K7vlwQUHZNv8DxZHDiB5m+tnpdg/tG+2tTmQS8pDGjKpvwAT3r8
         /Mpzifb+kplZB2wVw3xc6xqx7j7b9r+PTP9K1QNUMjW2JJMkBgdY5db1uMafH6s3Ih
         iQTBm4+3zB+VAcdCc4Er9yeYH+ro5tfGopw/fn6QQEeLjP0hY1ma158sOUvlcYIdxc
         rhVGGv8gwAejiQnUO1DuWIJWtuZkgSG/JPcaVYJxSPFz/9lrBdrrnsg30ONRhulqWF
         TpS+oGRGXxbAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5BA1F5C0641; Tue,  4 Oct 2022 06:30:04 -0700 (PDT)
Date:   Tue, 4 Oct 2022 06:30:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
Message-ID: <20221004133004.GD4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org>
 <Yzwb8vgYhAvDJzK+@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzwb8vgYhAvDJzK+@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 04, 2022 at 01:41:38PM +0200, Uladzislau Rezki wrote:
> >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> >  		rcu_nocb_lock_irqsave(rdp, flags);
> >  		lockdep_assert_held(&rdp->nocb_lock);
> >  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > -		if (bypass_ncbs &&
> > +		lazy_ncbs = READ_ONCE(rdp->lazy_len);
> > +
> > +		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> > +		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> > +		     bypass_ncbs > 2 * qhimark)) {
> Do you know why we want double "qhimark" threshold? It is not only this
> place, there are several. I am asking because it is not expected by the
> user.

OK, I will bite...  What does the user expect?  Or, perhaps a better
question, how is this choice causing the user problems?

							Thanx, Paul
