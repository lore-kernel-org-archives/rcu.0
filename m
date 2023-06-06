Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83075C77B73
	for <rcu@archiver.kernel.org>; Tue,  6 Jun 2023 16:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbjFFQIw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Jun 2023 12:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbjFFQIf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Jun 2023 12:08:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C159D10DE
        for <rcu@vger.kernel.org>; Tue,  6 Jun 2023 09:08:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b011cffe7fso29672385ad.1
        for <rcu@vger.kernel.org>; Tue, 06 Jun 2023 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686067713; x=1688659713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9TAxW9PyckEEU9Xcb/hGgs9B7vd7TQ7JPGY/iBjRiKo=;
        b=TgBq/5xnXtfr+asRrDtyu7i0oaaiI5RWgeKsztlNzykyemtgZJ23X3QVttOiHAr3DQ
         80dqKIFC9fx6L0W2ZrVtjUOnq35x50co6lumM/0mPxfeEEYnW65cutEqVabxukWM7Mmr
         GwOW1zT68pkV/63F1Mli0sTmjt4mbh50I6Vsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686067713; x=1688659713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TAxW9PyckEEU9Xcb/hGgs9B7vd7TQ7JPGY/iBjRiKo=;
        b=dJnhJ6ZhL3xguA5uozLVmg0So+HizJWV093vRyJXLRDT4ADq5Lin5MCYnWTLJGtVbi
         RfEshqXXqEqZUQ1B9q4dchdOez2Nq6jmY5acmvdkQlhFbBQDxJVKnzSBy/YSsKd+MTEl
         ShqAuo1PPCJu4cWWyDeiFnV1WLNNefrLDOeo148SrCY1cR3jmCujXfHzNF+BAxXd3YPv
         HGb6wMxZDT2z4mJ0xkxPRmZn8zs2Sb3HyICEyLDCCo4tG40KJ/9Mww4bFL6NPkRcA7Tk
         vK1cKBIWR0YCxHMmwiv5BzPp3u+cH109dU4zE9IV0LUSzGwL5lI7G5IWgYLODWGO82uO
         Tbqw==
X-Gm-Message-State: AC+VfDyy9G8o2/PSCVmydkNPOMnvihrLfjkBuEdfPriBgiT5xsSdiZhu
        b70srPLHIRVZ1JIsvCLYjL/AtA==
X-Google-Smtp-Source: ACHHUZ7I5CPds/r3cxVjHK9JMv4COB2xkgUgvxVf/oNN2V7W9uvxDtd7C7KljdKnlalv+WtlpdSSLg==
X-Received: by 2002:a17:902:a407:b0:1b0:26f0:4c8e with SMTP id p7-20020a170902a40700b001b026f04c8emr851115plq.69.1686067713134;
        Tue, 06 Jun 2023 09:08:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902f20200b001affb590696sm8758287plc.216.2023.06.06.09.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 09:08:32 -0700 (PDT)
Date:   Tue, 6 Jun 2023 09:08:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org,
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
Message-ID: <202306060907.D335A9F@keescook>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <202306060829.C2FD998CF@keescook>
 <CAHk-=wh=vs298o0gewFH725pQAYQ57CAQzj05FOx_VZubZ3jiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh=vs298o0gewFH725pQAYQ57CAQzj05FOx_VZubZ3jiA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 06, 2023 at 08:45:49AM -0700, Linus Torvalds wrote:
> On Tue, Jun 6, 2023 at 8:31 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > nit: Linus's example was "(void *)8" (instead of 1) because we've had
> > issues in the past with alignment warnings on archs that are sensitive
> > to it. (e.g. see the __is_constexpr() macro which is doing NULL/!NULL
> > comparisons.)
> 
> Note that I don't think we ever saw such a warning, it was just a
> theoretical observation that depending on type, the compiler might
> warn about known mis-aligned pointer bits.
> 
> So I'm not sure the 1-vs-8 actually matters. We do other things that
> assume that low bits in a pointer are retained and valid, even if in
> theory the C type system might have issues with it.
> 
> But maybe I mis-remember - if you did get an actual warning, maybe we
> should document that warning just to keep the memory alive.

I've never seen a warning, but since this came up in the dissection of
the __is_constexpr() behavior, it's been burned into my mind. ;)

-- 
Kees Cook
