Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD07C7EE24
	for <rcu@archiver.kernel.org>; Tue,  6 Jun 2023 15:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbjFFPb5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Jun 2023 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbjFFPby (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Jun 2023 11:31:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A06B10C3
        for <rcu@vger.kernel.org>; Tue,  6 Jun 2023 08:31:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b025d26f4fso54966625ad.1
        for <rcu@vger.kernel.org>; Tue, 06 Jun 2023 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686065512; x=1688657512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fb93uIfCZb6rwnwNAQwabVrOWCYJJ49ebGpWxsvxKJI=;
        b=AgiVu6Sndwe40e93jTy9pnKUfE9+dNwzO+tyuNKoZE535xQPXIUDLmMiWxrqvIEC7e
         zvyr4BqTgd96a/Xr3zXliBxN3LMmoPWMkCOLrcy2Jofl3Nk8cTu0ivu6lbZFSb35iuXT
         3a7HOak6dBDcENxcV2zpbiZApa0pjyr6JoXX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686065512; x=1688657512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fb93uIfCZb6rwnwNAQwabVrOWCYJJ49ebGpWxsvxKJI=;
        b=e5AIZ9LwWDbjfRFy11x0VCT8Akr2SCT6587KlOkRj6vseHwW09pBFX6hCHzaB4Reyr
         u9rYfSb0v0osXkJqsB4mOvtBBY8jx/hmuNVTNwBCZPTUzCqzwyi83mzffIB/27PPM0vS
         dfe1CiO9wKIUGEAjNxyuJlM8HXlcajUesh0gj9mitz7mzAXLt/2eb/OkTyAlMmiLlk5R
         6LgsyzF57sJfPpjDciZFge4dhOBL3VcY+qoBjJAR/IYJ8HDYL6cVz+lQFowmYKOKyl4K
         VE3NiE669mXiMu3EemOoe+H5eViHd4mzEZVz1FZjpyNaixv3PyA68cKdSzPlc1ZpMA4x
         931Q==
X-Gm-Message-State: AC+VfDznNYxZXUKMfVrHfr4zQVDTlxmoKa46o+MWcCE1rfQTouKlylTz
        Nz1ebYudsX08+wsJcCaJ5jiuyg==
X-Google-Smtp-Source: ACHHUZ5wlvJWwEV0/FDPWI8fFDkLmsafPFg8iYtZ2JVd7FCNya8xEv09JXlqqS9TRLhRCO66HiFQJw==
X-Received: by 2002:a17:903:1252:b0:1b0:5304:5b4e with SMTP id u18-20020a170903125200b001b053045b4emr3408817plh.43.1686065512579;
        Tue, 06 Jun 2023 08:31:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db8500b001a4fe00a8d4sm8685551pld.90.2023.06.06.08.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:31:52 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:31:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Message-ID: <202306060829.C2FD998CF@keescook>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606094251.GA907347@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 06, 2023 at 11:42:51AM +0200, Peter Zijlstra wrote:
> [...]
> #define scoped_guard(_guard, _var...)                                  \
>        for (__ptr_guard(_guard, scope) = guard_init(_guard, _var),     \
>             *done = NULL; !done; done = (void *)1)

nit: Linus's example was "(void *)8" (instead of 1) because we've had
issues in the past with alignment warnings on archs that are sensitive
to it. (e.g. see the __is_constexpr() macro which is doing NULL/!NULL
comparisons.)

-- 
Kees Cook
