Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA9EE7734F
	for <rcu@archiver.kernel.org>; Sat, 30 Sep 2023 02:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjI3CpX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Sep 2023 22:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3CpX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Sep 2023 22:45:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B512DD
        for <rcu@vger.kernel.org>; Fri, 29 Sep 2023 19:45:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso14645195a12.2
        for <rcu@vger.kernel.org>; Fri, 29 Sep 2023 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696041920; x=1696646720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY/WyrpMcIvWWnn7BkBCLAgVUZdCbx6thltJzcLUoXg=;
        b=Zu8CMbTmSJbJrJN3WL5an816ugGknWqRnAgrgS+EzgI6rNXdhsnBLqc9pua0W2aCGO
         SNLtPk3+12rqvjRWCdZXC1Le9WKr05XSvw0s8H46ZiFfov85lMNAhJ/7+H75VaMWNTE1
         EiUT8X2TF68R1B/aWC6cQiqFkfQMym5BVJ9ZJY42cZ9Kec0tCe3LFP0OtUWSWMMguc7u
         bGXrGf9AJaApaBB60iFvdcXyu8FJo6peq6NuB2F8ru9q6dpi/ga7BsaErx0jyv2+LFvR
         ezNgA7lmGMcniYLW8yVSdMN1tnvYc2LMjWDdALN5t/rw7IMMsTa725dREQ3cCR4SBBmD
         1PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696041920; x=1696646720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY/WyrpMcIvWWnn7BkBCLAgVUZdCbx6thltJzcLUoXg=;
        b=DS2HJ1l4wjYNEI5cY2BNBfX3FP51zpS10X1CIsdICtgqJnUSBCk/xh6qo2dI+276Pt
         TrC6bYL+yuCAnJZFKvtZCHnqcdtyPyL2umXb3Yrcll4xUUqAqK45KclBjTcNx/k8VN/Z
         yZcwih4M8l7K+gkCc1PQCOa2WWnuVMVX5KsBM+P4C5jxdYkyFqHhhsWs580NsA0QN/zu
         aRgeLjkwf4h5FfLa18y1TR88OO79XsHITk9aejfNWnleMP2L5xdBuWIm1zJloN44/mci
         RWtqMkrnLAO30v/nV+aUdSd/ZnnCJpdwzSWpEu2CAZU9NEhoxuV2foZJFIxfyCNR/F1z
         kK9w==
X-Gm-Message-State: AOJu0YyAw09nyvDCgvzin/mGuZleoyfVcSqsYqRFCtMQfQrfc9dRLpOF
        P2WzdICnqi6xveJWudkHV+xN6/tduVdoWltgkHMu4Ugbrf8g5BRa
X-Google-Smtp-Source: AGHT+IHVxmwzLlBoEGWaXPj18ppkuqhxAPJN+gEufK2TGDbPnBOfy3qgXPhqdqbWOOZ5G7NfzSVmHeSZqCD7zS45wNY=
X-Received: by 2002:aa7:c412:0:b0:522:b112:6254 with SMTP id
 j18-20020aa7c412000000b00522b1126254mr5672254edq.4.1696041919504; Fri, 29 Sep
 2023 19:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com> <ZRdTYPFtGrbPqhUY@localhost.localdomain>
In-Reply-To: <ZRdTYPFtGrbPqhUY@localhost.localdomain>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Sat, 30 Sep 2023 08:15:06 +0530
Message-ID: <CAFwiDX9V1tmRo+qv=3=dmPMsDvoRU3vBai3NBP6KBzr6RXGVtA@mail.gmail.com>
Subject: Re: SRCU: kworker hung in synchronize_srcu
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Sep 30, 2023 at 4:15=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Thu, Sep 28, 2023 at 05:39:17PM -0400, Joel Fernandes a =C3=A9crit :
> > If srcu_invoke_callbacks() was really called for the rdp, I would have
> > expected rcu_segcblist_advance() to advance all those pending
> > callbacks to 304.
> >
> > I posit that probably srcu_invoke_callbacks() is not even being called
> > in the first place, otherwise why is the DONE segment count still 0?
> > DONE should not be 0, otherwise callbacks will not run. The segcblist
> > of the rdp seems out of date perhaps due to rcu_invoke_callbacks() not
> > being called due to some other bug (or a workqueue/timer issue causing
> > the srcu_invoke_callbacks() to not run?).
>
> Speaking of, I'm looking at srcu_gp_end() and the comment after releasing
> srcu_gp_mutex says:
>
>               "/* A new grace period can start at this point.  But only o=
ne. */"
>
> But what ensures that?
>

I think ->srcu_cb_mutex ensures that.

/* Prevent more than one additional grace period. */
mutex_lock(&sup->srcu_cb_mutex);


Thanks
Neeraj

> Because if we get preempted here and more than 3 grace periods elapse, th=
en
> ->srcu_have_cbs[the_same_idx] could get overriden and then all sorts of r=
ace
> may lead to srcu_invoke_callbacks() to not be invoked.
>
> I'm not asking too loudly though because I'm sure I'm missing something o=
bvious,
> I see a lot of mirages these days...
