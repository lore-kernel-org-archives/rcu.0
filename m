Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52C2C38142
	for <rcu@archiver.kernel.org>; Mon, 23 Jan 2023 16:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjAWQ1R (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjAWQ1Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Jan 2023 11:27:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D933EEFA7;
        Mon, 23 Jan 2023 08:27:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C3B1B80DD6;
        Mon, 23 Jan 2023 16:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E87C433EF;
        Mon, 23 Jan 2023 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674491233;
        bh=aElySqo+VAF1KVpP6Ke3B6uZ7IU+c0ceWArbPT7cCZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdELtEfSzN5PLLxRytxTssNTHh+LtqHllBKfB1CAmFzHzCneok3MQOKX77D/q67eB
         ObTAZPjI/9ZNvv98zLWUDhUpVq1qO/iM4GqRFDkSWkkCXb0BeGoePZtknrKlpepE7h
         nWQrAIUkUSGB8upKEn1p7DMtRif1ARDjZFePClXH1s6U0csxwc6caL8HQMj0EypG1H
         cNOc5lb97wfyDbwBhVXxkXbufT8fWhUSUfYVqunJYk9+M6CZsEP+hFysx/SPxED1Hi
         KXoq89kVvpFxqwCkOcJlNXXI60DQkN148oTzVY0wBHr9eU3k0aOCJ/+6DJTgwG05LO
         Iwsrc4bq+uhFA==
Date:   Mon, 23 Jan 2023 17:27:10 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <Y861Xuoa+CrZt9PB@lothringen>
References: <PH0PR11MB5880A16045A842AB80A25C4BDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <B3E458A6-9279-4716-B242-873C77EC1E3A@joelfernandes.org>
 <Y8seE8Tr1w0UWf+m@lothringen>
 <CAEXW_YTTk_zETWy=xpL-8wF8vh6s_U5z9UyS17uBMda1BYpvug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTTk_zETWy=xpL-8wF8vh6s_U5z9UyS17uBMda1BYpvug@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 23, 2023 at 10:22:19AM -0500, Joel Fernandes wrote:
> > What am I missing?
> 
> That the acceleration is also done by __note_gp_changes() once the
> grace period ends anyway, so if any acceleration was missed as you
> say, it will be done anyway.
> 
> Also it is done by scheduler tick raising softirq:
> 
> rcu_pending() does this:
>         /* Has RCU gone idle with this CPU needing another grace period? */
>         if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
>             !rcu_rdp_is_offloaded(rdp) &&
>             !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>                 return 1;
> 
> and rcu_core():
>         /* No grace period and unregistered callbacks? */
>         if (!rcu_gp_in_progress() &&
>             rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
>                 rcu_nocb_lock_irqsave(rdp, flags);
>                 if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>                         rcu_accelerate_cbs_unlocked(rnp, rdp);
>                 rcu_nocb_unlock_irqrestore(rdp, flags);
>         }
> 
> So, I am not sure if you need needacc at all. Those CBs that have not
> been assigned grace period numbers will be taken care off :)

But that's only when there is no grace period pending, so it can't happen while
we report a QS.

OTOH without the needacc, those callbacks waiting to be accelerated would be
eventually processed but only on the next tick following the end of a grace
period...if none has started since then. So if someone else starts a new GP
before the current CPU, we must wait another GP, etc...

That's potentially dangerous.

And unfortunately we can't do the acceleration from __note_gp_changes() due
to lock ordering restrictions: nocb_lock -> rnp_lock

> 
> Thanks!
> 
>   -Joel
