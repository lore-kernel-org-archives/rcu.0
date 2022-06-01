Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC16CCA468
	for <rcu@archiver.kernel.org>; Wed,  1 Jun 2022 14:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbiFAOXj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Jun 2022 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353732AbiFAOX0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Jun 2022 10:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7A839828
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 07:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3641D61238
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 14:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08194C385A5;
        Wed,  1 Jun 2022 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654092773;
        bh=1xzA+5vuleWOK8b4GQZ/XA4DZIi92wuR/dWPJcrmey4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSY5u1rWVgBCE/PcKH2V3IKhKuj8qBJYQS10II6MgI9YX3f0futpA3FSlWEnezdVd
         K7KvQj43yfX8LGd1bpO7LTnfR3tG6XIxyhSC8/E1AM67xzl0yYe1zBVDC6frmPbY/k
         0HeOBi9g4mcKC3zVcrjniX/onkLW4Ni7KI2XnAsvluaxib+DQZB/oKrHgimCnBmLGN
         6Tl1DFWhwKgwcgD4yprSgl4Bjoq99TMU2TMR61MQgrp1WVCK6yde8QLLO7pWLnDO/1
         zP5rjkcA7zhR96W8Or2z2GDbPsCwE3LrrBXpzHLHi1zFZp6ECtZ0vy3mkPn9+AQaxm
         iCH/rOJcJ6Raw==
Date:   Wed, 1 Jun 2022 16:12:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <20220601141250.GA1288128@lothringen>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org>
 <YoNl3o+JvDas5xxF@pc638.lan>
 <2f370485-915d-a6c9-8d82-d4f1bd200c9e@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f370485-915d-a6c9-8d82-d4f1bd200c9e@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 30, 2022 at 10:54:26AM -0400, Joel Fernandes wrote:
> >> +void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
> >> +{
> >> +	struct lazy_rcu_head *head = (struct lazy_rcu_head *)head_rcu;
> >> +	struct rcu_lazy_pcp *rlp;
> >> +
> >> +	preempt_disable();
> >> +        rlp = this_cpu_ptr(&rcu_lazy_pcp_ins);
> >> +	preempt_enable();
> >>
> > Can we get rid of such explicit disabling/enabling preemption?
> 
> Ok I'll try. Last I checked, something needs to disable preemption to
> prevent warnings with sampling the current processor ID.

raw_cpu_ptr()

Thanks.
