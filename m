Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B320C7EE29
	for <rcu@archiver.kernel.org>; Tue,  6 Jun 2023 13:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbjFFNke (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjFFNkb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Jun 2023 09:40:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26AFE6E;
        Tue,  6 Jun 2023 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DEJxdjtBU7vOKqRY6jPSih5dZGAPLaGnK5K+JQdXahk=; b=fmScmA7quQpUDmvTdnGAr90SOA
        07IMw8QsepSEaGk7U9W8ZeqvvgfopoSPAjNAxCNWFlfvY8GAnYAmHfnA3K4w+2ZWM+o28eptMhxQu
        q8n3htgKAFPHLbXkwFm9ke4ZBs23Wm2hU5r1iht5IJxUTFW6lJwPQVXCaUBlbgsBR1UKZt1klNcd8
        qrb61SlHK9EUNMfZrp4wPRr1IVQklUPuPlGVbptApgg+IbAlNpjLvYlkEvq25hxIhqnH2tVNIuID6
        pUE5AtT2l1yZpxXvZAIyvo5x+qlpauZP9HwIqYxHMUNLttIDLhKxV39pfMifMbltat3U/frbFe/PW
        MgGhdR7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6Wut-00DByY-Ut; Tue, 06 Jun 2023 13:40:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4983300188;
        Tue,  6 Jun 2023 15:40:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8569A205EA3E8; Tue,  6 Jun 2023 15:40:05 +0200 (CEST)
Date:   Tue, 6 Jun 2023 15:40:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Message-ID: <20230606134005.GE905437@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 06, 2023 at 06:17:33AM -0700, Linus Torvalds wrote:

> That said, I still don't understand why you lke the name "guard" for
> this.  I understand not liking "auto", but "guard" doesn't seem any
> better. In fact, much worse. Guarded expressions means something
> completely different both in real life and in computer science.
> 
> I'm assuming there's some history there, but it makes no sense to me
> as a name here.

I know the name from C++ where it is std::lock_guard<> (well, back when
I still did C++ it wasn't std, but whatever), and Rust seems to have
std::sync::MutexGuard<>.

But if that's the sole objection left, lets have a bike-shed party and
pick a colour :-)

'shield' 'sentry' 'sentinel' 'keeper' 'custodian' 'warden' ?
