Return-Path: <SRS0=qouz=BG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EBCC433E0
	for <rcu@archiver.kernel.org>; Mon, 27 Jul 2020 23:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEDB2070B
	for <rcu@archiver.kernel.org>; Mon, 27 Jul 2020 23:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dGOnxmLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgG0XD1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgG0XD1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 27 Jul 2020 19:03:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E586C0619D2
        for <rcu@vger.kernel.org>; Mon, 27 Jul 2020 16:03:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so16961386qkg.9
        for <rcu@vger.kernel.org>; Mon, 27 Jul 2020 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GBftFvyHvrin0kdl06v10bVa3MCqdXQloUXFuRhSc9k=;
        b=dGOnxmLzwK+/tLLwNr0I9cnSw4nho2QwiTGJwt0v2qNs6Z+PbQ1OhL4xeADddYSfQE
         +KuWpveDYW1bObBiAAEn3QwjAy0tzAfgtgE9TGnAVDe5A1V9ec/MZQsj5xzbPrNLF0RW
         xVesQErP5QQ8EtaQWU2UWIwv1t7gcE+ZM0XOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBftFvyHvrin0kdl06v10bVa3MCqdXQloUXFuRhSc9k=;
        b=Q71a3ma1ZfltZAvrBUngx1SDVZNHcIPf8AyDJzrlIFOa/QH5TXedTjG7ktFiMbr1Gj
         Pwr1yqEpn4XRkAha4Ip1ZpzlSj9sQzBz/saY8s04gFxSaEyU8cvJTtEcYlaykoiuWu/z
         jiY2xKULITFP95jWTQ3mcJ0p/965PkEKt7HyeEM2ooOERaMbv3h3H/lwoS8WwQr0Lj6N
         q26Np6QAd/sPhlfbQkaBapJS6koF4vVz1m//RVydDaBu8QR1t9o4GfFrjwTlefhDlfmE
         vMYxJQ5ECelb1/QRCZhozEnsBY7u4i6aZG/9odF0Mr5QWvdwTEgHXodrQoeNTm78IpGn
         rbhw==
X-Gm-Message-State: AOAM532y/4EgEK4Q829g279CSXo5V6KJe9mk6vTtND6RH36aVFQqIOBt
        aZEp6SpfUe5FRGezB1ii4XxRjQ==
X-Google-Smtp-Source: ABdhPJzSqUgi++lBXyma31OuRRPsRzshcfFme7Q9i4ZBKMuKkAbLkRrL3kq111ejLYEBNlmHdA2LDg==
X-Received: by 2002:a37:458f:: with SMTP id s137mr25188859qka.129.1595891005462;
        Mon, 27 Jul 2020 16:03:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t83sm20045377qke.133.2020.07.27.16.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:03:24 -0700 (PDT)
Date:   Mon, 27 Jul 2020 19:03:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC v2] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200727230323.GA3390623@google.com>
References: <20200719035518.2386828-1-joel@joelfernandes.org>
 <CAEXW_YQhYiYQZOJ95dqBcu_fAZ_6k7HGbrw53eTgPrgXU+5few@mail.gmail.com>
 <20200719041841.GA2398236@google.com>
 <20200720082211.GA35358@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <CAEXW_YR4dxuPV+Yu9HcYCSAdiV1H=9Rk9HJgCST-YMMc7J2Mgg@mail.gmail.com>
 <20200727134925.GB79404@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727134925.GB79404@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 27, 2020 at 09:49:25PM +0800, Boqun Feng wrote:
[...] 
> So C11 features are available to gnu89 as extensions, also I tried to
> compile the following code with -std=gnu89:
> 
> 	#include <stdio.h>
> 
> 	typedef struct {
> 		int a;
> 	} atomic_t;
> 
> 	void g(void) {
> 		printf("this is g\n");
> 	}
> 
> 	void h(void) {
> 		printf("this is f\n");
> 	}
> 
> 	#define gen(x) _Generic((x), atomic_t : h(), int : g())
> 
> 	int main(void) {
> 		int a;
> 		atomic_t b;
> 		gen(a);
> 		gen(b);
> 		gen(b);
> 	}
> 
> , and it worked.
> 
> Besides, please note that in include/linux/compiler_types.h, _Generic is
> already used.

> > > With these primitives introduced, you can avoid () to add those
> > > rcu_segcblist_*_seglen() which have #ifdefs in them. Of course, an
> > > alternative would be that we implement rcu_segcblist_*_seglen() using
> > > _Generic, but I think someone else may have the similar problems or
> > > requirement (already or in the future), so it might be worthwhile to
> > > introduce the gen_ primitives for broader usage.
> > 
> > One issue is code using memory barriers around the operation, such as
> > in rcu_segcblist_add_len() where you use smp_mb__before_atomic() for
> > the atomic version, and regular smp_mb() for the non-atomic version.
> > So ifdef will still exist to some degree.
> > 
> 
> Right, I think we can have two functions: long_add_mb() and
> atomic_long_add_mb(), this part is similar to ifdef approach, but we can
> make a gen_long_add_mb() based on these two functions, and
> gen_long_add_mb() simply switches between those functions according to
> the actual type of the field, which I think is better than ifdef
> approach at readability and maintenance.

Thanks for clarification. I agree with your idea, would you be able to write
a patch to add the helpers my patch can use?

If others are Ok with your idea, I can go ahead and use your helpers.

(I could write the helpers myself as well, next time I send the patch).

thanks,

 - Joel

