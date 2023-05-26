Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645BEC77B7A
	for <rcu@archiver.kernel.org>; Fri, 26 May 2023 18:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbjEZSXT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 May 2023 14:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbjEZSXS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 May 2023 14:23:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000DDD3
        for <rcu@vger.kernel.org>; Fri, 26 May 2023 11:23:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f588bc322so156897566b.1
        for <rcu@vger.kernel.org>; Fri, 26 May 2023 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685125395; x=1687717395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/M/UpOX/uPrVbeWrxnNFy2PEHqrEHRxe05fCpZOsMs=;
        b=G5uf1bs0RvltE32ftdsmTtv0E1GvjvHppVU9PHKoHpTrzqIFXMEsSiNk3rObR30Ixw
         d3fGPhxG/1kLC7ZbxSrTTvx7/xB8MvdKMRm6Gs9KnKPDtrvCaZ+8A5zNJErGJKsWJTwU
         n2FCie+2WhsnGQJMxjuseBEaeeClkRTJ2EMss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685125395; x=1687717395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/M/UpOX/uPrVbeWrxnNFy2PEHqrEHRxe05fCpZOsMs=;
        b=b3b7G8bkwkmbcCnimU1knmq+QFPGPD+pducdGvTWaNQToTvcnFUmGLWG1loYNLCzaQ
         7pET64uj99hd16tFIDPh2ZBUwLshpOXHZI1VN+v35BibcuC/Yc5NTzZEPTONOmAbihPA
         chITLn0PHdLWPqrGuWM1I5uOvgvWbcvNQ8gBFy7aVNo1V5rZVt5r2s3IYo6qxGi1dRGx
         h3vqVP8dMIxLvBKEuD4ly635hhjWq1fBSFKRIs7swWFqV4/bPczHVzgUnSqw/kkEEMZF
         Ovzx09nFOSQHyFsgrh/q7n+w5z9Hdq+RsiwMufPgyyyFWUufbsDc5jbbueZL974IzQpG
         5DlQ==
X-Gm-Message-State: AC+VfDzEgJk5oatpsVIBtcLU5YHirZqpUfgUBeosOHxkmWXVMX+PkJZu
        7HlgYqgfZt/n1oAPq/9eGyLR0eS/v7STxwB7CwMDyJro
X-Google-Smtp-Source: ACHHUZ61vxyzaydnl6m38nCv5z/9BdnmG/GMmaDlXqTRBm11/AaqTQldWnKUrZ4T4uzVdMzciKD0Vg==
X-Received: by 2002:a17:907:6093:b0:96f:c988:93b with SMTP id ht19-20020a170907609300b0096fc988093bmr3891048ejc.35.1685125395315;
        Fri, 26 May 2023 11:23:15 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906371500b0094f1fe1696bsm2427917ejc.216.2023.05.26.11.23.14
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 11:23:14 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-30a95ec7744so985695f8f.3
        for <rcu@vger.kernel.org>; Fri, 26 May 2023 11:23:14 -0700 (PDT)
X-Received: by 2002:a17:907:9620:b0:96a:2acf:61e1 with SMTP id
 gb32-20020a170907962000b0096a2acf61e1mr3395121ejc.64.1685125373395; Fri, 26
 May 2023 11:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230526150549.250372621@infradead.org> <20230526151946.960406324@infradead.org>
In-Reply-To: <20230526151946.960406324@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 11:22:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYL6JaL79EmOBV=vge7jWGkph73JnJgU9U3jeXa6b2=Q@mail.gmail.com>
Message-ID: <CAHk-=wgYL6JaL79EmOBV=vge7jWGkph73JnJgU9U3jeXa6b2=Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] locking: Introduce __cleanup__ based guards
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
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 26, 2023 at 8:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> The CPP is rather impenetrable -- but I'll attempt to write proper
> comments if/when people think this is worth pursuing.

Ugh.

It's not only impenetrable, it seems _unnecessarily_ so.

Yes, yes, 'for()' loops can only declare one type, and if you want
multiple typed variables you declare a struct that contains all the
types.

But you don't actually *need* multiple types.

Yes, you think you do, because you want to use that 'bool done' to
make the for-loop only execute once. Nasty limitation of the for
syntax.

But you can actually do the 'bool done' using the exact same type you
have for the guard - just make it a pointer instead, and use NULL for
"not done" and non-NULL for "done". It ends up acting exactly like a
boolean.

But that extra structure is only a detail. The real ugliness comes
from using different scoping macros.

And I think you don't actually need to have those different forms of
"scoped()" macros for different cases. I think you can just use
variable macro arguments.

IOW, something like this:

  #define variable_scope(type, enter, exit) \
        for (type *_done =3D NULL, _scope __cleanup(exit) =3D enter;
!_done; _done =3D (void *)8)

  #define scoped(type, init...) \
        variable_scope(scope_##type##_t, scope_##type##_init(init),
scope_##type##_cleanup)

and then you can do

        scoped (rcu) {
                ...
        }

and it will call "scope_rcu_init()" on entry, and
"scope_rcu_exit(_scope)" on exit.

And just doing

        scoped (mutex, mymutex) { ... }

will call "scope_mytex_init(mymutex)" on entry, and
"scope_mytex_exit(_scope)" on exit.

And if you just make the scope_##type##_init() functions return the
right values, it all works very naturally.

I think you can also do things like

        scoped(irqsave) { ... }
        scoped(irqoff) { ... }
        scoped(preempt) { ... }

very naturally. No need for that odd "one scope for 'void', one scope
for 'lock'" nonsense.

I dunno. I didn't *test* the above. Maybe you already tried something
like the above, and there's a reason why it doesn't work.

             Linus
