Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1165E7734B
	for <rcu@archiver.kernel.org>; Fri, 29 Sep 2023 22:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjI2Woy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Sep 2023 18:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjI2Wox (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Sep 2023 18:44:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688D4193
        for <rcu@vger.kernel.org>; Fri, 29 Sep 2023 15:44:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90304C433C7;
        Fri, 29 Sep 2023 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696027492;
        bh=PNIEVLnEPw0U1qBs7pwgZgrBctbSIkEOg3q9DCdTkBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTEtVvHsq57QwiUWbXzbpt+vu0map01bL0ko77YCbIT9uSt4AQmi9VD5wRo8qD1Yv
         994ZFKCI5UJ8q7AY9zDjxOlLg0T5vlIBFz3cvZcDYnzshgyZmLLTyjPpwuOCugoRD3
         UbwMK2+B5Qk917hNn/a+SYr0/vJu63k1YSLFoylmOE1O5TW3Y2nUiLENIvZUPPMnup
         fWRf2CIkkWEGtXI3mIYGCp7j+SGGFNGdFnm/mWcNUnONUXBnh/D6TLjs4WBfkDQ2Ay
         S8LN1HILC2JwAZGHst0+EUrWdzw37gNjQHZq6vXTxRunE6w9qpIZN1BFbP3dqbBTqy
         8S/TwCzbFH78g==
Date:   Sat, 30 Sep 2023 00:44:48 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Subject: Re: SRCU: kworker hung in synchronize_srcu
Message-ID: <ZRdTYPFtGrbPqhUY@localhost.localdomain>
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Thu, Sep 28, 2023 at 05:39:17PM -0400, Joel Fernandes a écrit :
> If srcu_invoke_callbacks() was really called for the rdp, I would have
> expected rcu_segcblist_advance() to advance all those pending
> callbacks to 304.
> 
> I posit that probably srcu_invoke_callbacks() is not even being called
> in the first place, otherwise why is the DONE segment count still 0?
> DONE should not be 0, otherwise callbacks will not run. The segcblist
> of the rdp seems out of date perhaps due to rcu_invoke_callbacks() not
> being called due to some other bug (or a workqueue/timer issue causing
> the srcu_invoke_callbacks() to not run?).

Speaking of, I'm looking at srcu_gp_end() and the comment after releasing
srcu_gp_mutex says:

	      "/* A new grace period can start at this point.  But only one. */"

But what ensures that?

Because if we get preempted here and more than 3 grace periods elapse, then
->srcu_have_cbs[the_same_idx] could get overriden and then all sorts of race
may lead to srcu_invoke_callbacks() to not be invoked.

I'm not asking too loudly though because I'm sure I'm missing something obvious,
I see a lot of mirages these days...
