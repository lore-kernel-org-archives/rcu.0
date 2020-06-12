Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794FDC433DF
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 09:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABA220801
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFLJ1j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFLJ1i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jun 2020 05:27:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9BCC03E96F;
        Fri, 12 Jun 2020 02:27:38 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjfy6-0000uH-JW; Fri, 12 Jun 2020 11:27:22 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 06D73100F5A; Fri, 12 Jun 2020 11:27:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Cc:     luto@kernel.org, x86@kernel.org, frederic@kernel.org,
        rostedt@goodmis.org, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, will@kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH RFC] x86/entry: Ask RCU if it needs rcu_irq_{enter,exit}()
In-Reply-To: <20200611235305.GA32342@paulmck-ThinkPad-P72>
References: <20200611235305.GA32342@paulmck-ThinkPad-P72>
Date:   Fri, 12 Jun 2020 11:27:21 +0200
Message-ID: <87ftb0d47a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:
> +static __always_inline bool rcu_needs_irq_enter(void)
> +{
> +	return !IS_ENABLED(CONFIG_TINY_RCU) &&
> +               (context_tracking_enabled_cpu(smp_processor_id()) || is_idle_task(current));

This reintroduces the #PF problem which started the whole conditional
RCU entry discussion:

   https://lore.kernel.org/lkml/20200515235125.628629605@linutronix.de/

and which made us all come to the conclusion that we can do it always
conditional. No biscuit for you. :)

Thanks,

        tglx
