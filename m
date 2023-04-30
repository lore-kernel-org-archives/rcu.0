Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A1C77B73
	for <rcu@archiver.kernel.org>; Sun, 30 Apr 2023 20:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjD3UuI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 30 Apr 2023 16:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjD3UuH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 30 Apr 2023 16:50:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF6FFD
        for <rcu@vger.kernel.org>; Sun, 30 Apr 2023 13:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6FF960F64
        for <rcu@vger.kernel.org>; Sun, 30 Apr 2023 20:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BD4C433EF;
        Sun, 30 Apr 2023 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682887805;
        bh=KHeoXAFHNPEfE+O63H5mEgXdsZN/jnJWuuFUB/SqqWs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cUUdWmEL/MA7KeXPpB/nc2Ahf/jCIQ6jC0YMDF+XhAAfIdEvbVH14/6baxq1NIIBt
         7ozk40vNRS1+hxX330tMFrQFHHVF8pgHxajUWPA4CP+qFnpjZFvbFhVVrN8y64k6cT
         6DRNJ2Z+QuwaqtuVh3dlLuKHtqMQBUeoLNPyg7Y3d4lPE1kD5L2Blg454eJwVt41zP
         gpHkgAWPMk/4N+zLG1huYoI+dc+XaLxmH5TBlvqQX51dPrAfWeijt192/VwethCHPd
         CUo7ix7GZu1kN4NZAlSBCYRqtAhirLoceCI5ARXqFOqTBfqDFame8B12spu9zRkhCV
         qk8p4hYteQrKQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ADF8415405A6; Sun, 30 Apr 2023 13:50:04 -0700 (PDT)
Date:   Sun, 30 Apr 2023 13:50:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: Exp GPs and rcu_read_unlock()
Message-ID: <a8ffd9f6-5696-4e49-a91d-bd9954abeb21@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEXW_YSFm0XNMkfodBXVx-AsgJvcvGF+kmE+ZqU0Y=ehFJx+JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSFm0XNMkfodBXVx-AsgJvcvGF+kmE+ZqU0Y=ehFJx+JQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Apr 30, 2023 at 03:56:11PM -0400, Joel Fernandes wrote:
> Hello,
> Quick question (for educational purpose) for anyone - why does
> PREEMPT=n kernel not want to get help from __rcu_read_unlock() for
> expedited grace periods?
> 
> Basically, with PREEMPT=y kernels,  rcu_read_unlock_special.b.exp_hint
> is set to true, but for PREEMPT=n, no such thing is done. Furthermore,
> the __rcu_read_unlock() for PREEMPT=n does not help expedited GPs come
> to an end either.
> 
> I am guessing the answer is, "no one cares about that", or "no one
> reported needing this", but if there is another reason why a PREEMPT=n
> kernel should not need it, do let me know :)

Because PREEMPT=n kernels value fast rcu_read_unlock() more than they
value fast expedited grace periods.

> To make it more interesting, it appears that CONFIG_PREEMPT=y where
> preemption is dynamically disabled, it _should_ have the  effect of
> helping expedited GPs as far as I can see. Which further seems a
> difference between booting PREEMPT=n versus PREEMPT=y + booting with
> preemption turned off via boot option.

Yes, very much so!

So if you care deeply about fast expedited grace periods and less
so about smallish rcu_read_unlock() slowdowns, but otherwise want
non-preemptibility, CONFIG_PREEMPT_DYNAMIC=y and dynamically selecting
non-preemptible operation might be your best choice.

							Thanx, Paul
