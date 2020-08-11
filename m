Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEADC433E0
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 15:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13A92078E
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 15:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q4D+OfpR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eKcqpl3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgHKPW5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:22:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59156 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgHKPW5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 11:22:57 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597159375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOKrhA9/8Dw3b1MEGoQnT3OLTeegBJg+uMIZeCAWcPA=;
        b=Q4D+OfpRS/p/vhHrfquXf6g0lyrsNdi1mroTAtY9KhvLFBpN9C1BKdL2o+E4GFj9v5ry2w
        gOojjnlKOZY7XlkFA+vfTTmynlHH/jAiS14XVy+kqXf8Qi2smXWdBM1HSEr8dO6+f/7qES
        NNyby2pgEjuPM1DnswKs9F8ZfphgWj8HP+Q+tZmZMCCjDL8g4a1IEaPgGg905J6axpM8Zk
        lonWW6ZY/I9GFa/PQzy7JFGnbQfXupLCLVhJTR+06NgwaNjIzsZ7ge9X86CCAXkthm7YoO
        vbL5MAWomQ/3AEW+8YVvrSHG+pObd5ZUsK9rqHolRXpBQ5y0Noml5G7+2lkdww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597159375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOKrhA9/8Dw3b1MEGoQnT3OLTeegBJg+uMIZeCAWcPA=;
        b=eKcqpl3aGqnoNbuEnk9+xeczPxofwMUfvBKJ9zXcIPBSGQaGiOQM/oWzZMbZ5bnJsEfb7f
        DKPJKuByk1O135Cw==
To:     Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
References: <20200809204354.20137-1-urezki@gmail.com> <20200809204354.20137-2-urezki@gmail.com> <20200810123141.GF4773@dhcp22.suse.cz> <20200810160739.GA29884@pc636> <20200810192525.GG4773@dhcp22.suse.cz> <87pn7x6y4a.fsf@nanos.tec.linutronix.de>
Date:   Tue, 11 Aug 2020 17:22:54 +0200
Message-ID: <87k0y56wc1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Michal Hocko <mhocko@suse.com> writes:
>> zone->lock should be held for a very limited amount of time.
>
> Emphasis on should. free_pcppages_bulk() can hold it for quite some time
> when a large amount of pages are purged. We surely would have converted
> it to a raw lock long time ago otherwise.
>
> For regular enterprise stuff a few hundred microseconds might qualify as
> a limited amount of time. For advanced RT applications that's way beyond
> tolerable..

Sebastian just tried with zone lock converted to a raw lock and maximum
latencies go up by a factor of 7 when putting a bit of stress on the
memory subsytem. Just a regular kernel compile kicks them up by a factor
of 5. Way out of tolerance.

We'll have a look whether it's solely free_pcppages_bulk() and if so we
could get away with dropping the lock in the loop.

Thanks,

        tglx
