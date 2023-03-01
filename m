Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F1AC7EE31
	for <rcu@archiver.kernel.org>; Wed,  1 Mar 2023 00:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCAApp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Feb 2023 19:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjCAApo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Feb 2023 19:45:44 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA3ECA32
        for <rcu@vger.kernel.org>; Tue, 28 Feb 2023 16:45:43 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id h3so12224745lja.12
        for <rcu@vger.kernel.org>; Tue, 28 Feb 2023 16:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677631541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5m78WOJU8Q8f13mfbwHzzeODEphAMSlmLmtQWAwznk=;
        b=vpxgg+RzU+WKen19EqJk1/2sn3MXymj9IIvV/DR2kisgIdPkoFuP3jcfGI67/Rt3yY
         5eFWE/bDHwCeOjzjavdS0mY9XG34GY+ykXfnDVE+sxxPFzNXE59BN7LcqrLcG61zkrNu
         g6fLacramYtPypiSVZjQyPcjEwaWp+NBGS7NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677631541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5m78WOJU8Q8f13mfbwHzzeODEphAMSlmLmtQWAwznk=;
        b=qxv77cSYsBoC2NgykKb0qyCXinLwuNxtMcA1ula+qsjKLmplcYnnHTCWKZToQEBJpX
         U9EKnYglJuERrgOF6ZgHOmt+pWM4QVnGqLeRbvG+yoByLgvHzGUGr3QFj+7X8B6ORyNH
         gc2RAfJAwjXfXYtM0GVAPnGbHC4mGwYDjEfOaE9TlKjSkqLugAXO1sd2Rbdp1bz+GAKR
         vI1n6LmSVy2Oku2C7RUkPr/+m/Pzx89sTAK+fDK5Zek73ySEEDoUxw3vs6Nal/9K4YHR
         jivZeVyHW7ePJ26wX66RgxoDUK+5eeGYSZINWP/9XGr1Q1aboKVFhvl19zqRJRcUk/BR
         IArQ==
X-Gm-Message-State: AO0yUKUvyO4GtleLBWXWIKtSfvu2Q9P966bku2DN/auFkS0sEad89+Vm
        +S13DEcKA85u8P7RMYogwlfOuu5CwdCEXeBqVPSAnw==
X-Google-Smtp-Source: AK7set9/hh2o8bm+fHkpcQlrQgSugVTdVkvXiR4SF1VBEJL6/MYChjro+BqRIATBG8FcsZvy4Kopido8eRPwR7bEO+4=
X-Received: by 2002:a05:651c:b9b:b0:295:8ef2:8744 with SMTP id
 bg27-20020a05651c0b9b00b002958ef28744mr1400092ljb.3.1677631541365; Tue, 28
 Feb 2023 16:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20230228155121.3416-1-ubizjak@gmail.com> <Y/5mguXPPqdP3MZF@google.com>
 <20230228160324.2a7c1012@gandalf.local.home> <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230228164124.77c126d2@gandalf.local.home> <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
 <20230228190846.79b06089@gandalf.local.home>
In-Reply-To: <20230228190846.79b06089@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 28 Feb 2023 19:45:30 -0500
Message-ID: <CAEXW_YTRG+7oTGgmqSKpC6Wzft6vsjOzEDkN=eLpcEWeAxYwdg@mail.gmail.com>
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

On Tue, Feb 28, 2023 at 7:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
[...]
> >
> > >
> > > But in your case, we don't need to update js, in which case the
> > > try_cmpxchg() does.
> >
> > Right, it has lesser value here but I'm curious why you feel it also
> > doesn't belong in that ring buffer loop you shared (or did you mean,
> > it does belong there but not in other ftrace code modified by Uros?).
>
> The ring buffer patch had more than one change, where half the updates we=
re
> fine, and half were not.

Thanks for all the clarifications. Good to know such loop design
patterns can benefit from it!


 - Joel
