Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F567C77B7A
	for <rcu@archiver.kernel.org>; Tue, 30 May 2023 00:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjE3AHQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 29 May 2023 20:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE3AHO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 29 May 2023 20:07:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201CAA8
        for <rcu@vger.kernel.org>; Mon, 29 May 2023 17:07:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5147f4bbfdaso4764092a12.0
        for <rcu@vger.kernel.org>; Mon, 29 May 2023 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685405231; x=1687997231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suYdpofyVku3nNo6ZHkNcqAvkTrrn87SaHmt4Im5vn8=;
        b=EVperXrVXFv94W+/cE+sVturt9OT9c2EfYJMOoHKR0IcXu3khzKyEQD4AHA5KGU2g5
         Im4yILNs7UUYJHNsIcpt3lljYYzH1WBZSqphxOapmWNXg/x9x3vJqO5WwYsrPNfZEotr
         WARegmxn9OcrJFinb7TCRPj7MuewimUvInGsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685405231; x=1687997231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suYdpofyVku3nNo6ZHkNcqAvkTrrn87SaHmt4Im5vn8=;
        b=AOEUzKdVGWwdTvUztooheLw6rQndbWbKG7mjVPPG6FEHl+BuTS9Kl6Vol9o4wjWjy2
         h7bwG1iepay/87ok9mX0mdY0K0217178UYQJVb84IzlZWQGti8YEfPljKbc1lay7tzIP
         7vxLg9a0ynu2n0zr1461Dd9n/WFjJQJ826hLbc1vR0V3k/50AaH5LKX5+0r1zsuHWqUi
         8LbzXEg2HSxe0Iu/kha5Yy6d1cPMAis1RnN5+52GmCgvqABL9ufC8xz5SLWxJLELg871
         w6467+E2RxUET/VtOVpr8AGVUGghoZsCtrQlL+ZhtZbAH+o3A7jHFOJRR3CBIq3NGLj+
         Ddkw==
X-Gm-Message-State: AC+VfDxevWg/K5ZGAT7jYVtFB5Spf9DuPiYRH9swk+ZvDjVW63J2g2Td
        +8Lglyr7iRAzYdpRAcJ+LzrTfuHIVOCleHMZfNNF25ZQ
X-Google-Smtp-Source: ACHHUZ6rtK3YIYtdihqTeO5zaeiOgapyAhnd8LpP8SamD2qbnLHx3AGxS0KyCUziWXetjWKfeOP0XA==
X-Received: by 2002:a17:907:3f0c:b0:973:a3f4:c87b with SMTP id hq12-20020a1709073f0c00b00973a3f4c87bmr720694ejc.50.1685405231417;
        Mon, 29 May 2023 17:07:11 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id bg9-20020a170906a04900b0094f124a37c4sm6608230ejb.18.2023.05.29.17.07.10
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 17:07:11 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-30ae7cc0e86so1811210f8f.1
        for <rcu@vger.kernel.org>; Mon, 29 May 2023 17:07:10 -0700 (PDT)
X-Received: by 2002:a17:907:7f16:b0:96f:65db:d6d2 with SMTP id
 qf22-20020a1709077f1600b0096f65dbd6d2mr646581ejc.14.1685405209906; Mon, 29
 May 2023 17:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <CABgObfbhvOnqKQs9r2+3apg0UK3ub03Nf2SfGpe1=NcL9ewSSg@mail.gmail.com>
 <CAHk-=wjF4n=bEk-MDCWmOzyrm_zGsjP4RVkK72S3m4Oppg7F3Q@mail.gmail.com> <CAKOQZ8w_X8GyqE6xg2oY31hYkDWCPnVjLpdOK5Xo4E+ZMdJ9nA@mail.gmail.com>
In-Reply-To: <CAKOQZ8w_X8GyqE6xg2oY31hYkDWCPnVjLpdOK5Xo4E+ZMdJ9nA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 May 2023 20:06:33 -0400
X-Gmail-Original-Message-ID: <CAHk-=whEsr6fuVSdsoNPokLR2fZiGuo_hCLyrS-LCw7hT_N7cQ@mail.gmail.com>
Message-ID: <CAHk-=whEsr6fuVSdsoNPokLR2fZiGuo_hCLyrS-LCw7hT_N7cQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Ian Lance Taylor <iant@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 29, 2023 at 5:27=E2=80=AFPM Ian Lance Taylor <iant@google.com> =
wrote:
>
> It was a while ago, but I expect that I was just thinking of the
> implementation.  I agree that the documentation could be clearer.  I
> filed https://gcc.gnu.org/PR110029.

Thanks. I think we can proceed with the assumption that it's all
clearly ordered. Even when the scopes are explicit (ie actual separate
block scopes for the variables and no shared scope), doing a 'return'
(or break out of a loop) will obviously exit multiple scopes at once,
so it would be good to have it documented that the cleanup is always
in that reverse order by scope and declaration order within a scope.

I guess I should check with the clang people too.

              Linus
