Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A05C64EC7
	for <rcu@archiver.kernel.org>; Tue, 28 Feb 2023 23:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjB1Xa3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjB1Xa2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Feb 2023 18:30:28 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988A611E93
        for <rcu@vger.kernel.org>; Tue, 28 Feb 2023 15:30:27 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f16so12078298ljq.10
        for <rcu@vger.kernel.org>; Tue, 28 Feb 2023 15:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677627026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOSxGvDXAN2XBjTFFoV5qPpPuqcyWu9fKmABaUWkmfs=;
        b=UluvzYOLn0CmJBu2rIfZPWCNBj1bg60iunkHhbMmYFNVN4tfeHPO3+wxDtyLzyzWE+
         mMLk8Wi7aJLmXjcPZNnxU6Heq5W4LcyUtu5vntA3gL8+NlDsP15jzMeE5Ht8Chb6rEVZ
         J6pJRRjGUrYX6zL4Jvhb56p8abe71e4dCRlmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677627026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOSxGvDXAN2XBjTFFoV5qPpPuqcyWu9fKmABaUWkmfs=;
        b=xhPEDUP6ryWwKhSwN+YaeEzCK0YBJc3ykf5QDSnY/uNsHgauzPVznHENufqdCwY8Yh
         P8PeB6maN8D6uRNDKI96CvdfNSP+C32glkaQZ9hNLuvUEy+tNtxfpP9MF6JKa85ny4g3
         SugqnksgIuYLtaxD782slRHa2IHTvS3FVT90t/X+Nz07hNkoS6XuC2SInaRBo7af+kv6
         nPZoIzUxUWKdY7FR6rfXwPGhgazEuoWdRo/3fNv8IGxyFxpr3mVwPP/pIyUJAU+oI6Dx
         JCdlPlXEkDgtZ+d/T3mMZYRf46jjrRWbiMwkNibB0xWXRT59kJdOWkj/aurgym+dCXK9
         dMEQ==
X-Gm-Message-State: AO0yUKXd3QaQv3f2LHZPu/RD26UP0L7yRs+iig3qqUrFNIiCNzDC56UC
        5Ihme097o/xYLNKC7GUgX48+6E+Mu7ueZEWeRD4oeuTIVcqG2ZWI
X-Google-Smtp-Source: AK7set9xNRYPzLUDBbe907018mq80QIk4R5DUuPvY8T8qeEoSF0YbOKYjPygamDUCNdwkm9n/guf3XTS7hiQ13Dkfdg=
X-Received: by 2002:a05:651c:895:b0:293:4ab4:3bb1 with SMTP id
 d21-20020a05651c089500b002934ab43bb1mr2220633ljq.4.1677627025774; Tue, 28 Feb
 2023 15:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20230228155121.3416-1-ubizjak@gmail.com> <Y/5mguXPPqdP3MZF@google.com>
 <20230228160324.2a7c1012@gandalf.local.home> <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230228164124.77c126d2@gandalf.local.home>
In-Reply-To: <20230228164124.77c126d2@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 28 Feb 2023 18:30:14 -0500
Message-ID: <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hey Steve,

On Tue, Feb 28, 2023 at 4:41=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 28 Feb 2023 13:29:11 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>
> > All well and good, but the stall-warning code is nowhere near a fastpat=
h.
> >
> > Is try_cmpxchg() considered more readable in this context?
>
>
> -           cmpxchg(&rcu_state.jiffies_stall, js, jn) =3D=3D js) {
> +           try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
>
> It's basically the same :-/
>
> But looking at this use case, I'd actually NAK it, as it is misleading.

I'm trying to parse this. You are saying it is misleading, because it
updates js when it doesn't need to?

> As try_cmpxchg() is used to get rid of the updating of the old value. As =
in
> the ring buffer code we had:
>
> void ring_buffer_record_off(struct trace_buffer *buffer)
> {
>         unsigned int rd;
>         unsigned int new_rd;
>
>         do {
>                 rd =3D atomic_read(&buffer->record_disabled);
>                 new_rd =3D rd | RB_BUFFER_OFF;
>         } while (!atomic_cmpxchg(&buffer->record_disabled, &rd, new_rd) !=
=3D rd);

Hear you actually meant "rd" as the second parameter without the & ?

> }
>
> and the try_cmpxchg() converted it to:
>
> void ring_buffer_record_off(struct trace_buffer *buffer)
> {
>         unsigned int rd;
>         unsigned int new_rd;
>
>         rd =3D atomic_read(&buffer->record_disabled);
>         do {
>                 new_rd =3D rd | RB_BUFFER_OFF;
>         } while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_r=
d));
> }
>
> Which got rid of the need to constantly update the rd variable (cmpxchg
> will load rax with the value read, so it removes the need for an extra
> move).

So that's a good thing?

>
> But in your case, we don't need to update js, in which case the
> try_cmpxchg() does.

Right, it has lesser value here but I'm curious why you feel it also
doesn't belong in that ring buffer loop you shared (or did you mean,
it does belong there but not in other ftrace code modified by Uros?).

> The patch that Uros sent me for the ring buffer code also does some of
> that, which I feel is wrong.

I am guessing that is code *other than* the ring buffer loop above.

> So with that, I would nack the patch.

Dropping it for RCU is fine with me as well.

(And yes for the other thread, I had it backwards, try_cmpxchg is what
drops the need for cmp instruction -- sorry.)

thanks,

 -Joel
