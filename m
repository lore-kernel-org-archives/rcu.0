Return-Path: <SRS0=HY8l=A2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404FEC433E0
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FD32065D
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 14:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hgOSV1AX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tm+QHIA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGOOQZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOOQZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jul 2020 10:16:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74473C061755;
        Wed, 15 Jul 2020 07:16:25 -0700 (PDT)
Date:   Wed, 15 Jul 2020 16:16:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594822583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9MVvQyO+jCrVVB3QDS1JKwfFe3gjJSwdqICpDxVzZvk=;
        b=hgOSV1AXBaEWIWAOGdQMpggwpCKaYYY/XQCg/OEvpi9XR75jYdPDyPl05FoArS7p1VOluO
        2U0WUshJ/ca/bUAe9ajG193cHmCnf62Ypex3pKOhD6rVSDgMKmG956AN5LlF2XyZfOs3Kq
        VHVrThBcSmMe/tVTF73FW2A6j6cG0+i0Dy7a9sMv19nCpCnF8JXIkK42gEaM1B1uWwfNel
        lfTfi5QZMkJvIi4iv/MSGxLLj2tziUH5ZybQHnifEFPaHDGEyM0pygmvXozIKB3w28Evgj
        nlQelESIzmIifruYvUtK2uvjN6R3O3ys7SPwtCCwclM1fbFRuIhv6S7jTADGnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594822583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9MVvQyO+jCrVVB3QDS1JKwfFe3gjJSwdqICpDxVzZvk=;
        b=Tm+QHIA9ZIr56ueY4vkbTwnnhcAkHf6e9hnMhIrC2XKLI/WqhF7vGsRjYQazP3eoPMMvWf
        /PzIUxpTSF+VVPAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200715141622.zd2h3mnhd7ypd2fp@linutronix.de>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200715133808.GA24778@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715133808.GA24778@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-07-15 15:38:08 [+0200], Uladzislau Rezki wrote:
> > As of -rc3 it should complain about printk() which is why it is still disabled by default.
> >
> Have you tried to trigger a "complain" you are talking about?

No, but I is wrong because a raw_spinlock_t is acquired followed by a
spinlock_t.

> I suspect to get some trace dump when CONFIG_PROVE_RAW_LOCK_NESTING=y.

You should get one if you haven't received any splat earlier (like from
printk code because it only triggers once).

> Thank you.

Sebastian
