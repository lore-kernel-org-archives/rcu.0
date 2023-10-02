Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D8E7849A
	for <rcu@archiver.kernel.org>; Mon,  2 Oct 2023 11:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbjJBLFI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 2 Oct 2023 07:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBLFH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 2 Oct 2023 07:05:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ACAB3
        for <rcu@vger.kernel.org>; Mon,  2 Oct 2023 04:05:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B379AC433C7;
        Mon,  2 Oct 2023 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696244703;
        bh=138+xYJXN4mqDS5tLEIVZFPgwRLFt+CZdiVICo2QlLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHObG7YovfmFwVhhF1jwEoE0pJaPV8BJ6ag9ejS1CeQLFM2CddlIRGHj6h63SBlIx
         LGzpjy8Hm/u9unGPZHc17j2gARcNEhGfXACWpizrRvkCOrO6GI5LjelDEO3iCHwZaq
         RekmuQ4mNJwzSVJ3SUVQOv9HFpWY3aBhUEQB5rQE7EN0bg9bCNsY0NdJJ2nQ2QQb8u
         4WPYZt5/B/UC4KvJQm0gbBEQOXKnpqObzHkL0BnBZ3i7BkuzO7/dDunIeCMP3hyCOP
         bqvonW2mZRPTg6eQFD21VmDxHCphnBgr9M5N5T+rfGmqxswAGuvQbRyPdvmqbjb3eC
         98TrWnh/K456g==
Date:   Mon, 2 Oct 2023 13:05:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Subject: Re: SRCU: kworker hung in synchronize_srcu
Message-ID: <ZRqj3NMJ5nwNExLd@lothringen>
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
 <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
 <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
 <ZRnziciQQLdgYJNx@localhost.localdomain>
 <ZRn1PU8enLoM8u1T@localhost.localdomain>
 <CAFwiDX_RxMQ1SgG8Wc+JWB_9i-i90Qmxuei_Yk2yJ7ohTOHjLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX_RxMQ1SgG8Wc+JWB_9i-i90Qmxuei_Yk2yJ7ohTOHjLg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 02, 2023 at 07:51:10AM +0530, Neeraj upadhyay wrote:
> On Mon, Oct 2, 2023 at 4:10 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> > And if this works, can we then remove srcu_invoke_callbacks() self-requeue?
> > If queued several times before it actually fires, it will catch the latest
> > grace period's end. And if queued while the callback runs, it will re-run.
> >
> 
> This makes sense, but not sure for non-wq context which  link [1] mentions,
> whether it needs it.

I don't see a problem with it, see below.

> 
> > Also why do we have sdp->srcu_invoke_callbacks ? Is that workqueue re-entrant?
> >
> I think you mean sdp->srcu_cblist_invoking ?

Right!

> 
> There was a prior discussion on this [1], where Paul mentions about
> non-wq context.

I don't see that function called elsewhere than workqueue. So in early boot,
works queued must wait for workqueue_init() (and kthreads creation and running)
which is quite late in the boot process. So it looks like SRCU isn't really
usable synchonously in early boot.

Besides, this workqueue is already re-entrant. Several srcu_invoke_callbacks()
calls can already execute concurrently, which is fine thanks to the snp locking.

So I don't see an obvious need for this re-entrancy protection (coming along the
requeue thing).

Thanks.


> 
> 
> 
> Thanks
> Neeraj
> 
> [1] https://lkml.org/lkml/2020/11/19/1065
> 
> > Thanks.
