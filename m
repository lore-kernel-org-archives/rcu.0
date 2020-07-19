Return-Path: <SRS0=SldO=A6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09757C433E1
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 04:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D228F20684
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 04:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YN+yV8+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgGSEGk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Jul 2020 00:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgGSEGk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Jul 2020 00:06:40 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA5C0619D2
        for <rcu@vger.kernel.org>; Sat, 18 Jul 2020 21:06:39 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id c16so14279508ioi.9
        for <rcu@vger.kernel.org>; Sat, 18 Jul 2020 21:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihKeSQeLv7BBxInfCJI8ZRk0YjhCHk5lYGDi1OJs57k=;
        b=YN+yV8+92VHbOUHL0HTyo5JNlm0zk+zZ0D57uInpIH9RnDoAIgBQIeKKdSuXadAb3/
         qeA9TZEqiX/maRX4jLkStfPgYILKEI3eedN9CJXP991d15Qnhgwdm9R3rpXGoRQGd8XK
         q6UcbKVbPO726Dsdu1TyHnYDmNQzOMwUlYUAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihKeSQeLv7BBxInfCJI8ZRk0YjhCHk5lYGDi1OJs57k=;
        b=fJy+fqG9y/NOrBmzDq5MgoSkRF6ObOVc03bqn78UM2Si8CHzCfNvdouLToBu0jJE0w
         +3Y1YYhGpPKzo40xC/rvuaiWKDB0Zd+nMJH5G01EVuvlsVlfM3D4TivZDCTvQP7XIUy1
         V2IrUnwZ3JVWIO6qcY2td7OoEjiD1q9t2m4EN779in3awVpu/PDNpXsAVQzgCt5BP5fZ
         pMctQP+A0m4QPw+DiDNOvxwoIpKWS92tgWfZ3FjWhMJi8rMzlExbrC0z3+rWaEIi699W
         H7AEMc82WXFjYi5pRvXP4rwHbAGUrvt+TgpwTF9CW4MXHQ9YoBz6HKKOYcGbvriL5bsX
         mXoQ==
X-Gm-Message-State: AOAM532IX7Wd7MaNABS1E7YLTvSvMih2smDc4WPCgXuMUvrFwRSoCSrd
        gNW+Rr1l3ZeohQGYJpNSiLYzSsspyRi6TUYNXECiRTHKHkk=
X-Google-Smtp-Source: ABdhPJxrziSRaJdKhJ3sXR1kDEShPsgwAGaKXwtBtn0FUhDvAOM+vhDazqqIdVifwpKuJODJXGmMvpWYuqQ25uFPhec=
X-Received: by 2002:a05:6638:1504:: with SMTP id b4mr16212035jat.23.1595131599242;
 Sat, 18 Jul 2020 21:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200719035518.2386828-1-joel@joelfernandes.org>
In-Reply-To: <20200719035518.2386828-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 19 Jul 2020 00:06:28 -0400
Message-ID: <CAEXW_YQhYiYQZOJ95dqBcu_fAZ_6k7HGbrw53eTgPrgXU+5few@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rcu/segcblist: Add counters to segcblist datastructure
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jul 18, 2020 at 11:55 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
[...]
>         /* If no callbacks moved, nothing more need be done. */
> @@ -419,10 +494,9 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>          * callbacks.  The overall effect is to copy down the later pointers
>          * into the gap that was created by the now-ready segments.
>          */
> -       for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++, j++) {
> -               if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
> -                       break;  /* No more callbacks. */
> +       for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL && j < RCU_NEXT_TAIL; i++, j++) {
>                 WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> +               rcu_segcblist_move_seglen(rsclp, i, j);
>                 rsclp->gp_seq[j] = rsclp->gp_seq[i];
>         }

Unfortunately I broke this code, _sigh_.  I need to reinstate the
if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL]) , I completely
misunderstood that.
