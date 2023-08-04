Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AED9C001DE
	for <rcu@archiver.kernel.org>; Fri,  4 Aug 2023 16:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjHDQSP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Aug 2023 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjHDQSO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Aug 2023 12:18:14 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632841BDD
        for <rcu@vger.kernel.org>; Fri,  4 Aug 2023 09:18:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b962535808so35659551fa.0
        for <rcu@vger.kernel.org>; Fri, 04 Aug 2023 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691165889; x=1691770689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OczlVn14irTWoDlxC+z8REFyp0aBePT2F2CzHZGwXHY=;
        b=RkqWEyJE4NqJikRdb1bt+JO7LGnVKha31RC4IVbIPIO5UDriOK5EaQZu47hf3Iq1RJ
         Dep+Jc1WWJU4IWnGHY16tTzDNoUHnuWQQ8+b/gqB0FxnB2qSa4b7PB0v8QxccmDQbQBC
         g5+MxPkXGouVVQuOkMCuyAnLYg0t7pvjis8tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165889; x=1691770689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OczlVn14irTWoDlxC+z8REFyp0aBePT2F2CzHZGwXHY=;
        b=Kqt847+tV9goymhbFJ01UnybRF4HoZMruqR0sOSjpD4k1Esx9ZVPMArdtii1yNZL9p
         gZRlDzrnDIQYWrmZ3HCNNxGQ+vFzCAkhEJ0RDREgCMGFeEhwF4QQRVJ+49O1NCZWA5Ey
         XfTtJOTwhmA1xh2KKLvGmhNs+o6U4YCDk/AWN3uKreNCqF7KtbIUn7/txhM3ZchVMZh6
         3CCoeDhXn0qori8fWe7Gjp2Lx6kGP9d4XO8knV8YbC8t0xWEwj3fAg3plAPMqT07NMd7
         lyKsJ668GFu8lUpPbJMdU7I3B95IhsDTqPl7jWi2alQHsuSU5q30CqL2QzXNKn+PDNa6
         +rzQ==
X-Gm-Message-State: AOJu0YyYS/puoFfalbWnGum6LYjsWuzf2EqTpm6AfWB4b9V8U95L9ctH
        KA0XNtKd+ZHCDLsn2zYJMsvKJ4kAO1kggXeURiB56A==
X-Google-Smtp-Source: AGHT+IHcxWWGSAQHtiWwyPSfo/ACKS0ls+B/Hyol0FLiP4sUcq/gmog/iWO3i6CScHvZwlVx+GIIt0JpctOBMGPSW0s=
X-Received: by 2002:a2e:a442:0:b0:2b8:3a95:38b5 with SMTP id
 v2-20020a2ea442000000b002b83a9538b5mr1789304ljn.50.1691165889424; Fri, 04 Aug
 2023 09:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <f5652b1a-de71-4881-8825-fedd73544f54@paulmck-laptop>
 <D594A2D8-0C46-402D-B186-39DE7B65ED61@joelfernandes.org> <b8fd5f26-f101-4b58-aa62-649996b6ac5e@paulmck-laptop>
In-Reply-To: <b8fd5f26-f101-4b58-aa62-649996b6ac5e@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 4 Aug 2023 12:17:58 -0400
Message-ID: <CAEXW_YQQsFiVqihOXN1pCtvvek4OBmphDR6D4gGFKkd4x9DQxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to requirements
To:     paulmck@kernel.org
Cc:     Alan Huang <mmpgouride@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

[...]
> > >> However, the kernel consider the volatile access to be atomic, right?
> > >
> > > The compiler must therefore act as if a volatile access to an aligned
> > > machine-word size location is atomic.  To see this, consider accesses
> > > to memory that is shared by a device driver and that device's firmware,
> > > both of which are written in either C or C++.
> >
> > Btw it appears TSAN complaints bitterly on even volatile 4 byte data races.
> > Hence we have to explicitly use atomic API for data race accesses in Chrome.
>
> That might have been a conscious and deliberate choice on the part of
> the TSAN guys.  Volatile does not imply any ordering in the standard
> (other than the compiler avoiding emitting volatile operations out of
> order), but some compilers did emit memory-barrier instructions for
> volatile accesses.  Which resulted in a lot of problems when such code
> found compilers that did not cause the CPU to order volatile operations.
>
> So a lot of people decided to thrown the volatile baby out with the
> unordered bathwather.  ;-)

Thanks for the input, I think TSAN was indeed worried about
memory-ordering even if relaxed ordering was intended. I think there
is a way to tell TSAN to shut-up in such situations but in my last
Chrome sprint, I just used the atomic API with relaxed ordering and
called it a day. :-)

 - Joel
