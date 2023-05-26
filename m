Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDDDC77B7C
	for <rcu@archiver.kernel.org>; Fri, 26 May 2023 21:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjEZVZY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 May 2023 17:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjEZVZX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 May 2023 17:25:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAECA7;
        Fri, 26 May 2023 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gFZ2in+Bj6QabV9ADwfQ2GWgsStwLuzs+bri9OCHBWo=; b=iVpzxbc0oGbuS/ewQv9UimvTvn
        V3fynCYHa14gGUL8Ixk0ruDOZB/xqk+OA/LdK3jlju3wf2D2zWyiX3uyPDmiqzcazTvzEm78X67WR
        45YeRfOKOB3mZXjmhqUymfxL0uOkXo8Gwa8vv85vvOaEpzys5qEsXB1SS7Z2ihbWj0ZtlY+gXjgrR
        StbhNvmWge+7qk8BJEtxvoKUaq90/XZehPhm70/pr5yO4CzM3FfIJbSSGEyqRwIlXL/gpMidnFCbG
        sGw9/tdBSarHsxXG140C1O65KX3QXlocCgoMFuDCzCoZunkzlks1P02TIle3HHbk5x6LgCxTeYVZ7
        9bgO5EuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2evg-0038wG-JA; Fri, 26 May 2023 21:24:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 909EB3006B1;
        Fri, 26 May 2023 23:24:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 71234205BBDAD; Fri, 26 May 2023 23:24:54 +0200 (CEST)
Date:   Fri, 26 May 2023 23:24:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] locking: Introduce __cleanup__ based guards
Message-ID: <20230526212454.GB4057254@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <20230526205855.587341916@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526205855.587341916@infradead.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 26, 2023 at 10:52:05PM +0200, Peter Zijlstra wrote:

> +++ b/include/linux/guards.h
> @@ -0,0 +1,142 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_GUARDS_H
> +#define __LINUX_GUARDS_H
> +
> +#include <linux/compiler_attributes.h>
> +
> +/*
> + * Pointer Guards are special pointers (variables) with a scope bound cleanup
> + * function.
> + *
> + * Various guard types can be created using:
> + *
> + *   DEFINE_PTR_GUARD(guard_type, typename, cleanup-exp)
> + *
> + * After which they can be used like so:
> + *
> + *   ptr_guard(guard_type, name) = find_get_object(foo);
> + *
> + * Where the return type of find_get_object() should match the guard_type's
> + * 'typname *'. And when @name goes out of scope cleanup-exp is ran (inserted
> + * by the compiler) when !NULL at that time. Also see the __cleanup attribute.
> + */
> +
> +#define DEFINE_PTR_GUARD(_type, _Type, _Put)					\
> +typedef _Type *ptr_guard_##_type##_t;						\
> +										\
> +static inline void ptr_guard_##_type##_cleanup(_Type **_ptr)			\
> +{										\
> +	_Type *_G = *_ptr;							\
> +	if (_G)									\
> +		_Put(_G);							\
> +}
> +
> +#define ptr_guard(_type, _name)							\
> +	ptr_guard_##_type##_t _name __cleanup(ptr_guard_##_type##_cleanup)
> +

Ha, and then I wanted to create an fdput() guard... :/
