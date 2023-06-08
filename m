Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C86FC7EE25
	for <rcu@archiver.kernel.org>; Thu,  8 Jun 2023 18:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjFHSwT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Jun 2023 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjFHSwS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Jun 2023 14:52:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EFD26BA;
        Thu,  8 Jun 2023 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=crfd50VGMNO8tIlX6qr1NtBRBI1ze8Ei5RCfvhQ3fkc=; b=IxZve4SadNgmUqrtkxvp/OIOXR
        01gNgQ/27IPCcKCc1pFi/x9M0k38ewUI29ohP01xqRla86eChSmQLhYYBP8gDP7cGTIEiu/IEWC9S
        IZb7pM16hmXJCklCu4cSYy9jOijZ6fPkhscHmTECEkwhJD39ofPqClJxrCl+6T4lVnEFiHSp8fgFX
        YGPztrmBKmmga+qo8CD28PONL9EWOzcP0GDLo55uZjiwaVr+F3okK+umbUINAAjbElmHBFGOv4u73
        E8Ba3VuKhJ0f61wdi04JzeVVD3UI+etkz6q6SMSiLpx24ZBYLtTVX7lmfFAXYpFcGcQMV2QR1j9Ik
        X5GSFBvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7KjZ-006IRw-0z;
        Thu, 08 Jun 2023 18:51:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B216F3001E7;
        Thu,  8 Jun 2023 20:51:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A73B244EC37C; Thu,  8 Jun 2023 20:51:42 +0200 (CEST)
Date:   Thu, 8 Jun 2023 20:51:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org, mingo@redhat.com,
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
Message-ID: <20230608185142.GA1019250@hirez.programming.kicks-ass.net>
References: <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
 <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net>
 <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
 <202306080917.C0B16C8@keescook>
 <CAKwvOdmY_NEK4cnrqwU8acpU=SK3Z2uV_3PYCnhA5zQt2_TJJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmY_NEK4cnrqwU8acpU=SK3Z2uV_3PYCnhA5zQt2_TJJg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 08, 2023 at 10:20:19AM -0700, Nick Desaulniers wrote:
> Presumably, one could simply just not use RAII(/SBRM someone else
> corrected me about this recently coincidentally; I taught them my fun
> C++ acronym IDGAF) when working with a value that conditionally
> "escapes" the local scope.

But then you're back to the error goto :/
