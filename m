Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF93C433F8
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782C5206F4
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 14:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l3ZLmTNV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dBf+uBus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgGPOZm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgGPOZl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 10:25:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE9C08C5C0;
        Thu, 16 Jul 2020 07:25:40 -0700 (PDT)
Date:   Thu, 16 Jul 2020 16:25:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594909539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8pGaheYTYoGZYv5r4THVryy54oNNrDJrmVoeuGswsI=;
        b=l3ZLmTNV4qh6x04NTEwynyxGe7l8THGdxCYUWxLqXXP3wcyXtQ0ai34niwircMYYF8zjym
        n26JbEiSjL3/8CT7Px7Tonm9BjWdTLBn70gx4SBN6cgOcEznP23+k8JJIdqC6xIkaRh1Bt
        2/ieXp4QNjWFHe/u+SyV4++EA3CuYpsGLHE6DbSYExAKs55OA0AiZrCywdXLNlcFLfjes+
        r/xohezp/WpjDi0iW/B9oeMSljCXI2g0tpR41EXvkI4vKKKadOjmyjiFJWRWJTbbI3ITAV
        KaoDAygyzwwTYwYRdqWyU5fuHmLBS0WmvaD2BZYbT8MEAALFrE4a6h8lL7AgBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594909539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8pGaheYTYoGZYv5r4THVryy54oNNrDJrmVoeuGswsI=;
        b=dBf+uBusIFT/L0neyYIR02FQW3BLM6sIHJtxziWYRogPfi6O6X69EPZn6QtTBtz2wgubmE
        GZkc3klFzBky5fCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200716142537.ecp4icsq7kg6qhdx@linutronix.de>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
 <20200716091913.GA28595@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716091913.GA28595@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-07-16 11:19:13 [+0200], Uladzislau Rezki wrote:
> Sebastian, could you please confirm that if that patch that is in
> question fixes it?
> 
> It would be appreciated!

So that preempt disable should in terms any warnings. However I don't
think that it is strictly needed and from scheduling point of view you
forbid a CPU migration which might be good otherwise.
Also if interrupts and everything is enabled then someone else might
invoke kfree_rcu() from BH context for instance.

Sebastian
