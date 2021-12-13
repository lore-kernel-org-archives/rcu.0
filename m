Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E49C433EF
	for <rcu@archiver.kernel.org>; Mon, 13 Dec 2021 10:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhLMKhO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Dec 2021 05:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242503AbhLMKhB (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 13 Dec 2021 05:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639391820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40eLXntQjwkzxluGI+Ho48g3cfuyzP7+uCcCy7+but0=;
        b=IFumIvD3OXkyFVtR5KIc24PDjqdD7XgN0XDWhMHnx0EJd67F8OpDRe0cmKSkqZPTaPI8ge
        68vR9b8fEpRVZErNJHdT7EvIR19NVrql++eHfoGEgqqlU0Sl55OgH+H8oFOHPyFjt/PkoR
        PdQWbdWeWtSdpK2pJYLeuw+gW+JMvF4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-rraxwvunNmaHt2nOvjzbPA-1; Mon, 13 Dec 2021 05:36:59 -0500
X-MC-Unique: rraxwvunNmaHt2nOvjzbPA-1
Received: by mail-wr1-f72.google.com with SMTP id k8-20020a5d5248000000b001763e7c9ce5so3735401wrc.22
        for <rcu@vger.kernel.org>; Mon, 13 Dec 2021 02:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=40eLXntQjwkzxluGI+Ho48g3cfuyzP7+uCcCy7+but0=;
        b=B0CLMQlHrRjbBa42zPOymW9glG2IPU0tDDOvSaBKjRPu27KYGoes7+yMwsYk9jVAo8
         lbAxInMZFH9qWfuSvWSR7vqNhKFf8v2/S5hHLa7TF36mGV43UMv9VMxlgOZCkganCd5G
         JilTahdeX+BzLfJ6QOufUWXclRQRoNNsTU1u2hbyeU18/7/Az+EeSkDXoNtyjnuPIfgi
         Z5vqGDNPLKwJ5VNJtUBbVVKogONPT02esqrueILtIHptWWVQXJR7ZEfkTfj1Nz+kajGJ
         GXxgLIB+UUkl0cH8tckcrijQS/4tBIZVOftPeTNBN04O4KQvc3TyKfQHt+x1cPb4IuCV
         X/cw==
X-Gm-Message-State: AOAM530i9mf7fp7VGbOqMYDVPFLThJsA9i5qKW51st4YQJY0jh8Wc2nz
        3dQQPNickNDN7jcoR9Ui0iMPniihoQaaZJ7umL5FHZD9naSGV1svrNMaYzToegvINdBQmJ6/G1Z
        75cpIN1yMXGNH
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr30343179wrt.327.1639391818072;
        Mon, 13 Dec 2021 02:36:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytd8VYPlYi5vX+zSxtfhOlDn/QhiGT3fs6BL5aTU+O00AleCbjsfI8Ycj2E/GoifYYYzZCTw==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr30343148wrt.327.1639391817857;
        Mon, 13 Dec 2021 02:36:57 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id p27sm6586325wmi.28.2021.12.13.02.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:36:57 -0800 (PST)
Message-ID: <09e4a37b390479baa4e0947670d49c44d58c2855.camel@redhat.com>
Subject: Re: [PATCH v2] Documentation: Fill the gaps about entry/noinstr
 constraints
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Date:   Mon, 13 Dec 2021 11:36:56 +0100
In-Reply-To: <20211203200808.GT641268@paulmck-ThinkPad-P17-Gen-1>
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
         <875ys9dacq.ffs@tglx> <20211130091356.7336e277@gandalf.local.home>
         <878rx5b7i5.ffs@tglx> <YadU1aSE6/0yGWny@FVFF77S0Q05N> <87v9088a5q.ffs@tglx>
         <Yae9tbtZW5mjcBVt@FVFF77S0Q05N> <87ee6w83yw.ffs@tglx> <87bl2083mu.ffs@tglx>
         <20211203200808.GT641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi All,
now that this is good shape I'm taking over Thomas and preparing v3.

Paul, I introduced most (if not all) your paragraph corrections. Some questions
below.

On Fri, 2021-12-03 at 12:08 -0800, Paul E. McKenney wrote:
> > +The update order depends on the transition type and is explained below in
> > +the transition type sections.
> @@@

Sorry, I'm not 100% sure I get what you meant by this. Maybe introducing some
sort of link?

[...]

> > +syscall_exit_to_user_mode() handles all work which needs to be done before
> > +returning to user space like tracing, audit, signals, task work etc. After
> > +that it invokes exit_to_user_mode() which again handles the state
> > +transition in the reverse order:
> > +
> > +  * Tracing
> > +  * RCU / Context tracking
> > +  * Lockdep
> > +
> > +syscall_enter_from_user_mode() and syscall_exit_to_user_mode() are also
> > +available as fine grained subfunctions in cases where the architecture code
> > +has to do extra work between the various steps. In such cases it has to
> > +ensure that enter_from_user_mode() is called first on entry and
> > +exit_to_user_mode() is called last on exit.
> 
> !!! Here I have a question.  Can calls to enter_from_user_mode()
> be nested?  RCU is OK with this, but I am not so sure that everything
> else is.  If nesting is prohibited, this paragraph should explicitly
> say that.  If nesting is theoretically possible, but should be avoided,
> it would be good to say that as well.  (Otherwise "It looks like it
> might work, so let's go for it!")


In __enter_from_user_mode() I see:

	CT_WARN_ON(ct_state() != CONTEXT_USER);

IIUC this signals that a nested syscall entry isn't expected from CT's point of
view. I remember reading through RCU's dyntick code that the rationale for
nesting in the syscall path was half interrupts (or upcalls). I did some
research, but couldn't find an example of this. Is this something we can
discard as an old technique not used anymore?

On the other hand, interrupts are prone to nesting:
 - Weird interrupt handlers that re-enable interrupts
 - NMIs interrupting Hard IRQ context
 - NMIs interrupting NMIs

Please let me know if I'm off-base, but I think the topic of nesting is worth a
sentence or two in each section.

[...]

> > +Interrupts and regular exceptions
> > +---------------------------------
> > +
> > +Interrupts entry and exit handling is slightly more complex than syscalls
> > +and KVM transitions.
> > +
> > +If an interrupt is raised while the CPU executes in user space, the entry
> > +and exit handling is exactly the same as for syscalls.
> > +
> > +If the interrupt is raised while the CPU executes in kernel space the entry
> > +and exit handling is slightly different. RCU state is only updated when the
> > +interrupt was raised in context of the CPU's idle task because that's the
> > +only kernel context where RCU can be not watching on NOHZ enabled kernels.
> > +Lockdep and tracing have to be updated unconditionally.
> 
> !!! You lost me on this one.  Does that second-to-last sentence instead
> want to end something like this?  "... where RCU will not be watching
> when running on non-nohz_full CPUs."

The paragraph covers IRQ entry from kernel space. In that context RCU is only
shut-off during idle. That only happens on a NOHZ-enabled kernel, be it
NO_HZ_IDLE or NO_HZ_FULL.

I'll try to reword it a bit so it's more explicit.

Thanks!

-- 
Nicolás Sáenz

