Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC1C77B7C
	for <rcu@archiver.kernel.org>; Thu, 11 May 2023 05:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEKFrx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 May 2023 01:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEKFrt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 May 2023 01:47:49 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B110919BA
        for <rcu@vger.kernel.org>; Wed, 10 May 2023 22:47:48 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b9e2f227640so10315938276.3
        for <rcu@vger.kernel.org>; Wed, 10 May 2023 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683784068; x=1686376068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQlEekySQF52YhMHEw8D5nR4uh5gqpXzONo/bL8otQk=;
        b=pOwlZcdAxRKV4NPMj2MYMEiA7b+8IuYtKRiioIOQhYnNjfvtqf2X/6x/p9UUqUXpQ+
         I1Zzs+jqmpXVaoyAcioTHsfEfUllCBRXSZTNz2RHbs9hBCXREIhtQ/VSFPNOxMy1nnvI
         3ZAbpMUt7ALzI4OmJRAnWcF6YDL76R2LQkgR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683784068; x=1686376068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQlEekySQF52YhMHEw8D5nR4uh5gqpXzONo/bL8otQk=;
        b=jJoBLcIA62OtMwqrMPOYcz4bMDfnzPwyg73uIapILxC6eVYufWdXWWfiKt5whom5Bw
         wMByR9pxRtbEOlBA48diMaC9xG8oVmCo0U3jocaWGppH536P04MyPnRT0NGXBNoc0GXe
         1kCpTYzRqgkT1AbiFtSbXa6+Y1I7AqnfUAZpEDtbE/azwu8GS15lttEO8f6qyDuBNy9z
         FPt7+0BIgL/ySRRSFBG7c+sXAKYtWaN67VBvuvdBjj6xqxTlwlPwR0HKYjfcFkprj7yo
         6ClCMtnYLDFca47EYSConF4g81fXGLK2bK2n9PljJxAnujcwZf5EnHCKF3ojwVBchKkd
         MF/g==
X-Gm-Message-State: AC+VfDzMSULClHH89FHPl8B+l5NcQGzHeCcCRgY4HrSxgpYMGRahPcJk
        L32PkaLSfx8uax9UjnMkDAEt31JNKjZ3mcbKaCGsFA==
X-Google-Smtp-Source: ACHHUZ6wAWXHrv0njSSijEPO06hDqDVAN1MRuN/Wpg52wSUEiT5gS3hrjznfhj1BXxXu0vgJSGG5XX7lztgwZfy00HQ=
X-Received: by 2002:a25:f81d:0:b0:b9a:7845:ebdd with SMTP id
 u29-20020a25f81d000000b00b9a7845ebddmr19604793ybd.17.1683784067743; Wed, 10
 May 2023 22:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop> <20230510171238.2189921-5-paulmck@kernel.org>
In-Reply-To: <20230510171238.2189921-5-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 10 May 2023 22:47:36 -0700
Message-ID: <CAEXW_YQNRQuPP8GzHMZXWPoLmbpK3rB_+eVXmiRu6RrsihrEpQ@mail.gmail.com>
Subject: Re: [PATCH rcu 5/6] doc/rcutorture: Add description of rcutorture.stall_cpu_block
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Zqiang <qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 10, 2023 at 10:12=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> From: Zqiang <qiang1.zhang@intel.com>
>
> If you build a kernel with CONFIG_PREEMPTION=3Dn and CONFIG_PREEMPT_COUNT=
=3Dy,
> then run the rcutorture tests specifying stalls as follows:
>
> runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4" \
>         bootparams=3D"console=3DttyS0 rcutorture.stall_cpu=3D30 \
>         rcutorture.stall_no_softlockup=3D1 rcutorture.stall_cpu_block=3D1=
" -d
>
> The tests will produce the following splat:
>
> [   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
> [   10.841073] rcu_torture_stall start on CPU 3.
> [   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x0000000
> ....
> [   10.841108] Call Trace:
> [   10.841110]  <TASK>
> [   10.841112]  dump_stack_lvl+0x64/0xb0
> [   10.841118]  dump_stack+0x10/0x20
> [   10.841121]  __schedule_bug+0x8b/0xb0
> [   10.841126]  __schedule+0x2172/0x2940
> [   10.841157]  schedule+0x9b/0x150
> [   10.841160]  schedule_timeout+0x2e8/0x4f0
> [   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
> [   10.841195]  rcu_torture_stall+0x2e8/0x300
> [   10.841199]  kthread+0x175/0x1a0
> [   10.841206]  ret_from_fork+0x2c/0x50

Another way to get rid of the warning would be to replace the
cur_ops->readlock() with rcu_read_lock(). Though perhaps that will not
test whether the particular RCU flavor under testing is capable of
causing a stall :-).

>         rcutorture.stall_cpu_block=3D [KNL]
>                         Sleep while stalling if set.  This will result
> -                       in warnings from preemptible RCU in addition
> -                       to any other stall-related activity.
> +                       in warnings from preemptible RCU in addition to
> +                       any other stall-related activity.  Note that
> +                       in kernels built with CONFIG_PREEMPTION=3Dn and
> +                       CONFIG_PREEMPT_COUNT=3Dy, this parameter will
> +                       cause the CPU to pass through a quiescent state.
> +                       Any such quiescent states will suppress RCU CPU
> +                       stall warnings, but the time-based sleep will
> +                       also result in scheduling-while-atomic splats.

Could change last part to "but may also result in
scheduling-while-atomic splats as preemption might be disabled for
certain RCU flavors in order to cause the stall".

> +                       Which might or might not be what you want.
> +

Suggest drop this line ;-).

 - Joel

>         rcutorture.stall_cpu_holdoff=3D [KNL]
>                         Time to wait (s) after boot before inducing stall=
.
> --
> 2.40.1
>
