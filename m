Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CB6C0044D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 23:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908EB205ED
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 23:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="d0rNLcz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbgCPXaA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:30:00 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:41595 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732855AbgCPXaA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 19:30:00 -0400
Received: by mail-il1-f179.google.com with SMTP id l14so18322495ilj.8
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TrjtaVY+vtnXNgILuu1pyGv5c+ezxSxkFH1UyNpNmU=;
        b=d0rNLcz2a1SShaLbA2F5rd7NBjGMcXHur2Sl5kt1KBx0IQvfUreW7GGshFqSl9EbtO
         GDXA58bMJttO35kJdwTpEF2IxREmvtqg3yenIfPCmsq0yzgCR+0sR0BrP6R+KcZoMrYW
         5cG/zKnfyOJyVuXKofRRSVuv9asVbfm/Cg5pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TrjtaVY+vtnXNgILuu1pyGv5c+ezxSxkFH1UyNpNmU=;
        b=j7qjjzfdT2tXC1lXVpL7lvRk6xaFxnWc5EiWNV4dllSAoE7PcC9eBmQzEKz1uEhVIY
         mE1pSFdMRFiWCjsO1OyT/s7s1ZhxHyjAVrgZnchJTS+zmSjcs7AFNUiXjLi/zauUCdpn
         gycDRyz4YQeB1h7AoOZakDt/Wjfd1I6GTA/grR0EKwUk37bODvoKYwKHmhfTnLYfsa90
         0iqKT+eD1YhvSzMq3B1nblu1kaxY8Zvk1evrWdw6ax5yKtF6UuTtYhn6thJFSr74xImw
         Iz4V7GXSRL6ggPPKbKjgWMoCE5fPHDhmQxjwTUl0qdcjhUlFnk+zvct4jUzRiwRaOM5C
         WT5g==
X-Gm-Message-State: ANhLgQ17+RQdZgXJWI2isUs9PW6B9oGoi3wjaCoLQEW071U02YfPY5vF
        ZcaXW5PuHTFnLgCwtv80dhv7fjWHmiP/gtn/8tuyWA==
X-Google-Smtp-Source: ADFU+vt92k85OKOq3HgRjLYsK0ojnBhoyCELlM5ADzikWfGvm7vJtuLBQV2mPaeD8zA+1GuJq+hkQIHdwD4IHyGQUzc=
X-Received: by 2002:a05:6e02:bc7:: with SMTP id c7mr2449567ilu.78.1584401397643;
 Mon, 16 Mar 2020 16:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJzB8QEUkcfx19N5369AqvfkOfQ+DL3pEjYJsK7yJi+tSq8CFg@mail.gmail.com>
In-Reply-To: <CAJzB8QEUkcfx19N5369AqvfkOfQ+DL3pEjYJsK7yJi+tSq8CFg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 16 Mar 2020 19:29:46 -0400
Message-ID: <CAEXW_YSBe3UOWwjTBpya_bM47RvrpV8kcx=RrskPP3z0i0nY2g@mail.gmail.com>
Subject: Re: Power outage
To:     Paul McKenney <paulmckrcu@gmail.com>
Cc:     rcu <rcu@vger.kernel.org>, rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

I saw a bunch of ping timeouts on IRC and was wondering, yours among
them. :-). See you soon back online!

On Mon, Mar 16, 2020 at 6:55 PM Paul McKenney <paulmckrcu@gmail.com> wrote:
>
> More than 2000 affected. Current repair estimate 6:45 PM PDT. For some reason, going to the local coffee shop seems less attractive than it might have a few weeks ago. :-)
>
> Thanx, Paul
