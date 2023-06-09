Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E46C7EE2E
	for <rcu@archiver.kernel.org>; Fri,  9 Jun 2023 02:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFIC0f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Jun 2023 22:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbjFIC0M (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Jun 2023 22:26:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E7A2D4B
        for <rcu@vger.kernel.org>; Thu,  8 Jun 2023 19:26:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1b1635661so13316911fa.0
        for <rcu@vger.kernel.org>; Thu, 08 Jun 2023 19:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686277565; x=1688869565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0dr2RCR8de9AHgGFM/BsL//DnL2oGg8Z2a/flMORU8=;
        b=dm//hitwhqDtT9mRHPJtKcuKS1NV6gyHaDGDid9dC6AB+KkBV0+sYQnKBHXaK1V2AP
         uxfsMgOylQWw1RRL5Szs34lfv2cW2K4aattQvHIKSwuzmR+U4uu0E9pFh30UWbfzGGtb
         fKmp53A697/E33jo0hLOit7bv3sWK3xHG6ouo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277565; x=1688869565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0dr2RCR8de9AHgGFM/BsL//DnL2oGg8Z2a/flMORU8=;
        b=UxkSMUbK4t7zEbViRisWiuBr7oRU8CUOeqKVXGEaY/JT1gBn7+ZNyFC6FbXg4EkvLE
         WUJf5kp9owxbnV4Ds7VQM4ScfcRx0P/AzjcfiEj6C6NW4dagTxmNmAoTTOHHidjCA+3A
         4dhTQ6gv859ceATnXRzSMShzTlqHRn9DFhXTj5l4t7TLM9rImgk+fkptxfCKZa3jEuHq
         p7Tz8qfhtAJc+ULd6YN7ItwY7izsqOl+PHQ4bHkQkaWBHYqBYnBp3q8XurFEtRPHbRQ0
         FdoUa8V3uNoszk7hD0soBIoFGzA9v2oHprPhpm5SUj01TWIhECYM3NBx+GtqcjBfII+v
         2auA==
X-Gm-Message-State: AC+VfDxwlLZUuaPEr8KgiQmCrpREFL1zzrkrfxn87347QvIjHLFtwjZa
        uwbp5Gkg1DBBV3f1IAQ/joZyGelRT/dRPGdEyTH+gOBy
X-Google-Smtp-Source: ACHHUZ5LGUT/A+zF9M7I4aRjXhl6dk7QvtW1oxbFTUUh2pCB4s9pnOxK3L04GFOnzsW28wPDz7/qiw==
X-Received: by 2002:a2e:3c04:0:b0:2b0:259d:f670 with SMTP id j4-20020a2e3c04000000b002b0259df670mr156127lja.4.1686277565385;
        Thu, 08 Jun 2023 19:26:05 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e8e97000000b002b20b012d41sm169060ljk.54.2023.06.08.19.26.04
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 19:26:05 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f6454a21a9so1560951e87.3
        for <rcu@vger.kernel.org>; Thu, 08 Jun 2023 19:26:04 -0700 (PDT)
X-Received: by 2002:a17:907:728b:b0:969:9fd0:7cf2 with SMTP id
 dt11-20020a170907728b00b009699fd07cf2mr271573ejc.10.1686277544358; Thu, 08
 Jun 2023 19:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net> <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net> <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net> <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com> <20230608200618.GA1020752@hirez.programming.kicks-ass.net>
In-Reply-To: <20230608200618.GA1020752@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Jun 2023 19:25:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcXuZ91WkKv0fuBcm+w7y=y=fNzW9EXfnYYSCFvuyhdA@mail.gmail.com>
Message-ID: <CAHk-=wjcXuZ91WkKv0fuBcm+w7y=y=fNzW9EXfnYYSCFvuyhdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 8, 2023 at 1:06=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
>         struct obj *p __free(kfree) =3D kmalloc(...);

Yeah, the above actually looks really good to me - I like the naming
here, and the use looks very logical to me.

Of course, maybe once I see the patches that use this I go "uhh", but
at least for now I think you've hit on a rather legible syntax.

I'm still a bit unsure of the "no_free_ptr(p)" naming, but at least
it's pretty clear about what it does.

So my only worry is that it's not pretty and to the point like your
"__free(kfree)" syntax.

But it feels workable and not misleading, so unless somebody can come
up with a better name, I think it's ok.

           Linus
